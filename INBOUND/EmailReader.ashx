<%@ WebHandler Language="C#" Class="EmailReader" %>

using System;
using System.Web;
using OpenPop.Pop3;
using OpenPop.Mime;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls; 

using System.Collections.Generic;


using System.Data;
using System.Data.Odbc;


using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;
 
using System.Text.RegularExpressions;


[Serializable]
public class Email
{
    public Email()
    {
        this.Attachments = new List<Attachment>();
    }
    public int MessageNumber { get; set; }
    public string From { get; set; }
    public string To { get; set; }
    public string Cc { get; set; }
    public string Subject { get; set; }
    public string Body { get; set; }
    public string MessageId { get; set; }
    
    public DateTime DateSent { get; set; }
    public List<Attachment> Attachments { get; set; }
}

[Serializable]
public class Attachment
{
    public string FileName { get; set; }
    public string ContentType { get; set; }
    public byte[] Content { get; set; }
    public string ContentId { get; set; }
}

public class EmailReader : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public string setting(string code, int IdTask)
    {

        using (TaskSettingContext db = new TaskSettingContext())
        {
            var settings = db.TaskSettings.SqlQuery("SELECT * FROM [INBOUND].[dbo].[cc_TaskSetting] WITH(NOLOCK) WHERE IdTask = " + IdTask + " AND [IdSetting] = (SELECT Id FROM [dbo].[cc_TypeSetting] WITH(NOLOCK) WHERE [SystemTitle] = '" + code + "')");

            return settings.Count() > 0 ? settings.First().Value : "";
        }
    }
    
    public void ProcessRequest (HttpContext context) {

        Read_Emails(context);
        
        context.Response.ContentType = "text/plain";
        context.Response.Write("Finish");
    }
     


    private void Read_Emails(HttpContext context)
    {
        System.Configuration.Configuration config = WebConfigurationManager.OpenWebConfiguration("~");


        TaskContext db = new TaskContext();
        var Tasks = db.Tasks.Where(p => p.Active == 1 && p.Deleted == 0);
        foreach (Task t in Tasks)
        {
            int IdTask = t.Id; 
            int IdProject = t.IdProject;
            if (setting("ON_READER_EMAIL", IdTask) != "1") continue;
            
            Pop3Client pop3Client;
            //if (context.Session["Pop3Client"] == null)
            // {
            pop3Client = new Pop3Client();
            pop3Client.Connect(setting("POP_HOST", IdTask), setting("POP_SSL", IdTask) == "1" ? 995 : 110, setting("POP_SSL", IdTask) == "1");
            pop3Client.Authenticate(setting("POP_USER", IdTask), setting("POP_PASSWORD", IdTask), AuthenticationMethod.UsernameAndPassword);
            context.Session["Pop3Client"] = pop3Client;
            //   }
            //   else
            //   {
            //       pop3Client = (Pop3Client)context.Session["Pop3Client"];
            //    }
            int count = pop3Client.GetMessageCount();
            int counter = 0;
            for (int i = 1; i <= count; i++)
            {

                Message message = pop3Client.GetMessage(i);
                //   if(message.Headers.

                // context.Response.Write(message.Headers.MessageId.ToString() + System.Environment.NewLine);
                Email email = new Email()
                {
                    To = String.Join(", ", message.Headers.To.ToList()),
                    Cc = String.Join(", ", message.Headers.Cc.ToList()),
                    MessageNumber = i,
                    MessageId = message.Headers.MessageId.ToString(),
                    Subject = message.Headers.Subject,
                    DateSent = message.Headers.DateSent,
                    From = message.Headers.From.Address,//   string.Format("{0}<{1}>", message.Headers.From.DisplayName, message.Headers.From.Address),
                };
                MessagePart body = message.FindFirstHtmlVersion();
                if (body != null)
                {
                    email.Body = body.GetBodyAsText();
                }
                else
                {
                    body = message.FindFirstPlainTextVersion();
                    if (body != null)
                    {
                        email.Body = body.GetBodyAsText();
                    }
                }
                List<MessagePart> attachments = message.FindAllAttachments();

                foreach (MessagePart attachment in attachments)
                {

                    email.Attachments.Add(new Attachment
                    {
                        FileName = attachment.FileName,
                        ContentType = attachment.ContentType.MediaType,
                        Content = attachment.Body,
                        ContentId = attachment.ContentId
                    });
                }
                context.Response.Write(email.Subject.ToString() + System.Environment.NewLine);
                context.Response.Write("----------------------------------" + System.Environment.NewLine);
                saveEmailInDb(email, context, IdTask, IdProject);
                pop3Client.DeleteMessage(i);
                counter++;
                if (counter > 40)
                {
                    break;
                }
            };
            // pop3Client.Reset();
            pop3Client.Dispose();

        }
        //pop3Client.Disconnect(); 
    }


    public void saveEmailInDb(Email email,HttpContext context, int IdTask, int IdProject)
    {


        PopupLoadContext db = new PopupLoadContext(); 
        Regex pattern = new Regex("\\[([0-9]+)\\]"); 
        Match m = pattern.Match(email.Subject);
        
        int ParentID = 0;
        if (m.Groups.Count > 1 )
        {
            int num;
            bool isNum = int.TryParse(m.Groups[1].Value, out num);
            if (isNum)
                ParentID = num;
        }

        EmailHistory eh = new EmailHistory()
        {
            Body = email.Body,
            Copy = email.Cc,
            From = email.From,
            Subject = email.Subject,
            To = email.To,
            DTCreated = DateTime.Now,
            IdType = 2,
            MessageArrived = "",
            MessageID = email.MessageId,
            ParentID = ParentID,
            IdTask = IdTask,
            IdProject = IdProject
        };
        db.EmailHistorys.Add(eh);
        db.SaveChanges();


       // context.Response.Write(TicketID.ToString()+System.Environment.NewLine);

         

        if(email.Attachments.Count>0)
        for(int i =0; i < email.Attachments.Count; i++){
            saveEmailFileInDb(eh.Id, ParentID, email.Attachments[i], email, context);
        }
       
        
    }



    public void saveEmailFileInDb(int EmailID, int ParentId, Attachment attachment, Email email, HttpContext context)
    {
        if (attachment.ContentId != null) return;
        ConnectionStringSettings settings =
           ConfigurationManager.ConnectionStrings["INBOUNDConnectionString"];

        SqlConnection myConnection = new SqlConnection(settings.ConnectionString);
        //запишем инфу о звонке  в бд
        SqlCommand myCommand = new SqlCommand("  INSERT INTO [dbo].[cc_EmailFile] ([ParentId]  ,[MessageID]  ,[FileName]  ,[Content]  ,[ContentType],[ContentId]   ,[DTCreated],[EmailId])    VALUES  (@ParentId  ,@MessageID  ,@FileName, @Content ,@ContentType  ,@ContentId     ,getDate(), @EmailId)"
            , myConnection);
        myCommand.CommandType = CommandType.Text;

        SqlParameter param = myCommand.Parameters.Add("@Content", SqlDbType.VarBinary);
        param.Value = attachment.Content;

        myCommand.Parameters.AddWithValue("@ParentId", ParentId);
        myCommand.Parameters.AddWithValue("@EmailId", EmailID);
        myCommand.Parameters.AddWithValue("@FileName", attachment.FileName);
        //myCommand.Parameters.AddWithValue("@Content", attachment.Content);
        myCommand.Parameters.AddWithValue("@ContentType", attachment.ContentType);
        myCommand.Parameters.AddWithValue("@ContentId", attachment.ContentId!=null?attachment.ContentId:""); 
        myCommand.Parameters.AddWithValue("@MessageID", email.MessageId);
        myCommand.Connection.Open();
        myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        myConnection.Close();
 




    } 
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}
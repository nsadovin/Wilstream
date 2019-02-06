using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class biocad : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonSendToEmail_Click(object sender, EventArgs e)
    {
        System.IO.StringWriter sw = new System.IO.StringWriter();
        HtmlTextWriter tw = new HtmlTextWriter(sw);

        form1.RenderControl(tw);
        send("vesdehod@mail.ru", sw.ToString(), "Анкета", true);
        Response.Write("Отправлено");
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        //Оставить пустым
    }


    public void send(string emails, string body, string subject, bool IsBodyHtml = false)
    {
         

        string from = "pls@wilstream.ru";
        
        System.Net.Mail.MailMessage m = new System.Net.Mail.MailMessage(from, emails);
        m.IsBodyHtml = IsBodyHtml;
        m.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

        m.Subject = subject;


        m.Bcc.Add("vesdehod@yandex.ru");

        string EMAIL_BCOPY = "vesdehod@mail.ru";
        if (EMAIL_BCOPY != "") m.Bcc.Add(EMAIL_BCOPY);

        m.Body = body;

        System.Net.Mail.SmtpClient sc = new System.Net.Mail.SmtpClient("mail.wilstream.ru");

        sc.Credentials = new System.Net.NetworkCredential("pls@wilstream.ru", "15986");
        sc.EnableSsl = false;

        sc.Send(m);

    }

}
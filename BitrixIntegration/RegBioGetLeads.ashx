<%@ WebHandler Language="C#" Class="RegBioGetLeads" %>

using System;
using System.Web;

using System.Linq;
using Newtonsoft;
using Newtonsoft.Json;

using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

public class RegBioGetLeads : IHttpHandler {

    private static HttpContext _context  ;


    private readonly Bitrix24 BX24 = new Bitrix24(HttpContext.Current, "local.5e6366c7b5b046.63199819", "RwSdKiMWacHu275q7T9b1f1aB36BkxWB7MHw5D8HSbOdi2BkFh", "https://sevan.bitrix24.ru", "https://oauth.bitrix.info", "boychenko@sevancert.am", "Bychkova73");


    public void ProcessRequest (HttpContext context) {
        _context = context;


        var dataListLids = new
        {
            sort = new { ID = "desc" }
        };

        string next = "0";
        while (true)
        {

            string Campaigns = BX24.SendCommand("crm.company.list", "SELECT[]=PHONE&SELECT[]=ID&SELECT[]=TITLE&SELECT[]=DATE_CREATE&ORDER[ID]=ASC&start="+next, JsonConvert.SerializeObject(dataListLids), "POST");

            var CampaignsJSON = JsonConvert.DeserializeObject<dynamic>(Campaigns);
            if (CampaignsJSON.total == 0) return;



            foreach (var campaign in CampaignsJSON.result)
            {
                AddToDataBase(campaign.PHONE, (int)campaign.ID, Convert.ToDateTime(campaign.DATE_CREATE), campaign.TITLE.ToString()); 
            }
            if (CampaignsJSON.next!=null)
                next = CampaignsJSON.next.ToString();
            else
                break;
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("Good");
    }



    private void AddToDataBase(dynamic Phones, int IdCampaign, DateTime Created, string Name) {
        try
        {
                string work_phone = "";
                string mobile_phone = "";
                string home_phone = "";
                string mailing_phone = "";
                string other_phone = "";

            foreach (var Phone in Phones) {
                string type_phone = Phone.VALUE_TYPE.ToString();
                switch (type_phone) {
                    case "WORK": work_phone = Phone.VALUE; break;
                    case "MOBILE": mobile_phone = Phone.VALUE; break;
                    case "HOME": home_phone = Phone.VALUE; break;
                    case "MAILING": mailing_phone = Phone.VALUE; break;
                    case "OTHER": other_phone = Phone.VALUE; break;
                } 
            } 

            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "IF not exists(select * from [dbo].[WS_RegBio] with(nolock) where IdCampaign = "+IdCampaign.ToString()+") INSERT INTO  [dbo].[WS_RegBio]  " +
                " (Phone1,Phone2,Phone3,Phone4,Phone5, IdCampaign, TitleCampaign, [Created]) " +
                " Values " +
                "( " +
                (String.IsNullOrEmpty(work_phone)?      "'',":("oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + work_phone + "'), ")) +
                (String.IsNullOrEmpty(mobile_phone)?    "'',":("oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + mobile_phone + "'), ")) +
                (String.IsNullOrEmpty(home_phone)?      "'',":("oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + home_phone + "'), ")) +
                (String.IsNullOrEmpty(mailing_phone)?   "'',":("oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + mailing_phone + "'), ")) +
                (String.IsNullOrEmpty(other_phone)?     "'',":("oktell_ccws.[dbo].[clearPhoneAndAddEight]('" + other_phone + "'), ")) +
                ""+IdCampaign.ToString()+",@TitleCampaign, @CreatedLead)  ";

            /*Рабочий телефон
            Мобильный телефон
            Домашний телефон
            Телефон для рассылок
            Другой телефон*/



            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@CreatedLead", Created);
            myOdbcCommand.Parameters.AddWithValue("@TitleCampaign", Name);
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);

            myOdbcReader.Close();
            myOdbcConnection.Close();

        }
        catch (Exception ex)
        {
            _context.Response.Write(ex.Message);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
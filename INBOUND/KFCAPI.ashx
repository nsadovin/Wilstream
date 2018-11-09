<%@ WebHandler Language="C#" Class="KFCAPI" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public class KFCAPI : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {

        var phone = context.Request.QueryString["phone"].ToString();
        var worksheet_id = context.Request.QueryString["worksheet_id"].ToString();
        saveData(phone, worksheet_id);
        context.Response.ContentType = "text/plain";
        context.Response.Write("OK");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }



    protected bool saveData(string phone, string worksheet_id)
    {


        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["oktell_ccwsConnectionString"];

        bool isSaveAnswer = false;

        try
        {


            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("INSERT INTO oktell.dbo.KFC_Data (phone, worksheet_id) values (@phone, @worksheet_id)", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@phone", phone);
            myOdbcCommand.Parameters.AddWithValue("@worksheet_id", worksheet_id);
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            if (myOdbcReader.Read())
            {
                isSaveAnswer = myOdbcReader.GetValue(0).ToString() == "True";


            }
            myOdbcReader.Close();
            myOdbcConnection.Close();
        }
        catch (SqlException SqlEx)
        {

            throw new Exception("An error occurred while transaction", SqlEx);

        }
        finally
        {
            if (conn != null)
            {
                conn.Close();
            }
        }



        return isSaveAnswer;

    }



}
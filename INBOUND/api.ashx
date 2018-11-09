<%@ WebHandler Language="C#" Class="api" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public class api : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
    
        var method = context.Request.QueryString["method"].ToString();
        
        switch(method)
        {
         case "add" :  
         {
            var phone = context.Request.QueryString["phone"].ToString();
            var date = context.Request.QueryString["date"]==null?"":context.Request.QueryString["date"].ToString();
            var id = context.Request.QueryString["id"].ToString();
            var city = context.Request.QueryString["city"]==null?"":context.Request.QueryString["city"].ToString();
            var name = context.Request.QueryString["name"]==null?"":context.Request.QueryString["name"].ToString();
            var sum = context.Request.QueryString["sum"]==null?"":context.Request.QueryString["sum"].ToString();
            var birthdate = context.Request.QueryString["birthdate"]==null?"":context.Request.QueryString["birthdate"].ToString();
            var brend = context.Request.QueryString["brend"]==null?"": context.Request.QueryString["brend"].ToString();
            var model = context.Request.QueryString["model"]==null?"":context.Request.QueryString["model"].ToString();
            var year = context.Request.QueryString["year"]==null?"":context.Request.QueryString["year"].ToString();
            var link_anketa = context.Request.QueryString["link_anketa"]==null?"": context.Request.QueryString["link_anketa"].ToString();
            var link_document = context.Request.QueryString["link_document"]==null?"": context.Request.QueryString["link_document"].ToString(); 
            var source = context.Request.QueryString["source"]==null?"": context.Request.QueryString["source"].ToString(); 
            saveData(phone, date,id, city, name, sum,birthdate,  brend, model, year,link_anketa ,link_document, source);
            }
            break;
           case "update":
           {
            var id = context.Request.QueryString["id"].ToString();
            var brend = context.Request.QueryString["brend"]==null?"": context.Request.QueryString["brend"].ToString();
            var model = context.Request.QueryString["model"]==null?"":context.Request.QueryString["model"].ToString();
            var year = context.Request.QueryString["year"]==null?"":context.Request.QueryString["year"].ToString();
            var link_anketa = context.Request.QueryString["link_anketa"]==null?"": context.Request.QueryString["link_anketa"].ToString();
            var link_document = context.Request.QueryString["link_document"]==null?"": context.Request.QueryString["link_document"].ToString(); 
            updateData( id, brend, model, year,link_anketa ,link_document);
            }
           break;
        }
        context.Response.ContentType = "text/json";
        context.Response.Write("{\"success\":true}");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    
    
    

    protected bool updateData(string id,string brend,string model,string year,string link_anketa ,string link_document)
    {


        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["oktell_ccwsConnectionString"];

        bool isSaveAnswer = false;

        try
        {


            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("UPDATE oktell.dbo.CarMoney_Data SET brend = @brend, model = @model, year = @year , link_anketa = @link_anketa, link_document = @link_document  where carmoney_id = @carmoney_id", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@brend", brend);
            myOdbcCommand.Parameters.AddWithValue("@model", model);
            myOdbcCommand.Parameters.AddWithValue("@carmoney_id", id);
            myOdbcCommand.Parameters.AddWithValue("@year", year);
            myOdbcCommand.Parameters.AddWithValue("@link_anketa", link_anketa);
            myOdbcCommand.Parameters.AddWithValue("@link_document", link_document);
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



    protected bool saveData(string phone, string date,string id, string city, string name, string sum,string birthdate, string brend,string model,string year,string link_anketa ,string link_document, string source)
    {


        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["oktell_ccwsConnectionString"];

        bool isSaveAnswer = false;

        try
        {


            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("declare @result nvarchar(2000); set @result = null; if exists(select * from oktell.dbo.CarMoney_Data where phone = @phone) set @result = 'Дублирование'; INSERT INTO oktell.dbo.CarMoney_Data ([Результат обработки контакта],phone, [date],carmoney_id, city, name, [sum], birthdate,   brend,  model,  year,  link_anketa ,  link_document, source) values (@result,@phone, @date,@carmoney_id, @city, @name, @sum, @birthdate,   @brend,  @model,  @year,  @link_anketa ,  @link_document, @source)", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@phone", phone);
            myOdbcCommand.Parameters.AddWithValue("@date", date);
            myOdbcCommand.Parameters.AddWithValue("@carmoney_id", id);
            myOdbcCommand.Parameters.AddWithValue("@city", city);
            myOdbcCommand.Parameters.AddWithValue("@name", name);
            myOdbcCommand.Parameters.AddWithValue("@sum", sum);
            myOdbcCommand.Parameters.AddWithValue("@birthdate", birthdate);
            myOdbcCommand.Parameters.AddWithValue("@brend", brend);
            myOdbcCommand.Parameters.AddWithValue("@model", model); 
            myOdbcCommand.Parameters.AddWithValue("@year", year);
            myOdbcCommand.Parameters.AddWithValue("@link_anketa", link_anketa);
            myOdbcCommand.Parameters.AddWithValue("@link_document", link_document);
            myOdbcCommand.Parameters.AddWithValue("@source", source);
            
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
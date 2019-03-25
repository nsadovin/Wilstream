<%@ WebHandler Language="C#" Class="GetBookData" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;

public class GetBookData : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json"; 
        context.Response.Write(JsonConvert.SerializeObject(GetData(Convert.ToInt32(context.Request.QueryString["id"].ToString()), Convert.ToInt32(context.Request.QueryString["parent"]!=null?context.Request.QueryString["parent"].ToString():"0"))));
    }


    protected List<Tuple<int,string,int>> GetData(int IdReferenceBook, int IdParent = 0)
    {


        var rslt = new List<Tuple<int,string,int>>();

        SqlConnection conn = null;

        ConnectionStringSettings settings =
        ConfigurationManager.ConnectionStrings["INBOUNDConnectionString"];

        bool isSaveAnswer = false;

        try
        { 
            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            SqlCommand myOdbcCommand = new SqlCommand("select [Id], [Title], [IdParent] from [INBOUND].[dbo].[cc_ReferenceBookData] where [IdReferenceBook] = @IdReferenceBook and ([IdParent] = @IdParent or @IdParent=0) and [Active] = 1 and [Deleted] = 0 order by [Sort], [Title]", myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Parameters.AddWithValue("@IdReferenceBook", IdReferenceBook);
            myOdbcCommand.Parameters.AddWithValue("@IdParent", IdParent);
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            while (myOdbcReader.Read())
            {
                    rslt.Add(new Tuple<int, string, int>(myOdbcReader.GetInt32(0), myOdbcReader.GetString(1), myOdbcReader.GetInt32(2))); 
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



        return rslt;

    }


    public bool IsReusable {
        get {
            return false;
        }
    }

}

using log4net;
using log4net.Config;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;

namespace Guru
{
    /// <summary>
    /// Сводное описание для api
    /// </summary>
    public class api : IHttpHandler
    {
        private static ILog log = LogManager.GetLogger("LOGGER");


        public void ProcessRequest(HttpContext context)
        {
            XmlConfigurator.Configure();

            StreamReader reader = new StreamReader(HttpContext.Current.Request.InputStream);
            string requestFromPost = reader.ReadToEnd();
            try
            {
                log.Debug("requestFromPost is " + requestFromPost);
                var order = JsonConvert.DeserializeObject<Order>(requestFromPost);
                bool result = saveOrder(order);
            }
            catch (SqlException ex)
            {
                context.Response.ContentType = "text/plain";
                context.Response.Write("Error:" + ex.Message);
                log.Error(ex);
                context.Response.End();
            }
            catch (Exception ex)
            {

                context.Response.ContentType = "text/plain";
                context.Response.Write("Error:" + ex.Message);
                log.Error(ex);
                context.Response.End();
            }


            context.Response.ContentType = "text/plain";
            context.Response.Write("OK");
        }

        private bool saveOrder(Order order)
        {
             
                System.Data.SqlClient.SqlConnection conn = null;

                System.Configuration.ConnectionStringSettings settings =
                System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

                SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

                var SqlStr = "INSERT INTO[oktell].[dbo].[WS_GuruTaxi] ([Gury_car_brand]   ,[Gury_car_model]  ,[Gury_driver_firstName]  ,[Gury_driver_lastName]  ,[Gury_driver_phone]  ,[Gury_driver_license_number]  ,[Gury_driver_license_country]   ,[Gury_driver_experience]   ,[Gury_Id]  ,[Gury_car_id]   ,[Gury_driver_id]    ,[Gury_company_id]  ,[Gury_company_brand]  ,[Gury_company_interviewSchedule]  ,[Gury_company_token])   VALUES ('"+ order.car.brand+ "','" + order.car.model + "'  ,'" + order.driver.firstName + "','" + order.driver.lastName + "','" + order.driver.phone + "','" + order.driver.license.number + "','" + order.driver.license.country + "','" + order.driver.experience + "' ," + order.id + "," + order.car.id + "," + order.driver.id + " ," + order.company.id + " ,'" + order.company.brand+ "' ,'" + order.company.interviewSchedule + "'   ,'" + order.company.token + "')";
 



                SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
                myOdbcCommand.CommandType = CommandType.Text;
                myOdbcCommand.Connection.Open();
                SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);

                myOdbcReader.Close();
                myOdbcConnection.Close();

                return true;
 
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
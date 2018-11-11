using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Guru
{
    public partial class OrderForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var Id = Request.QueryString["Id"] != null ? Request.QueryString["Id"].ToString() : "";
            if (Id == "")
            {
                Response.Write("Не указан Id заявки");
                Response.End();
            }
            var order = GetOrder(Convert.ToInt32(Id));
            if (order == null)
            {
                Response.Write("Заявка не найдена в системе");
                Response.End();
            }
            HiddenFieldId.Value = Id;
            LabelBrand.Text = order.car.brand;
            LabelModel.Text = order.car.model;
            LabelFirstName.Text = order.driver.firstName;
            LabelLastName.Text = order.driver.lastName;
            LabelPhone.Text = order.driver.phone;
            LabelCountry.Text = order.driver.license.country;
            LabelNumber.Text = order.driver.license.number;
            LabelExperience.Text = order.driver.experience.ToString();
            LabelCBrand.Text = order.company.brand;
            HiddenFieldToken.Value = order.company.token;
            LabelInterviewSchedule.Text = order.company.interviewSchedule;
        }

        private Order GetOrder(int Id)
        {

            System.Data.SqlClient.SqlConnection conn = null;

            System.Configuration.ConnectionStringSettings settings =
            System.Configuration.ConfigurationManager.ConnectionStrings["oktellConnectionString"];

            SqlConnection myOdbcConnection = new SqlConnection(settings.ConnectionString);

            var SqlStr = "SELECT * FROM [oktell].[dbo].[WS_GuruTaxi] WHERE Guru_Id = " + Id+"";

            Order order = null;


            SqlCommand myOdbcCommand = new SqlCommand(SqlStr, myOdbcConnection);
            myOdbcCommand.CommandType = CommandType.Text;
            myOdbcCommand.Connection.Open();
            SqlDataReader myOdbcReader = myOdbcCommand.ExecuteReader(CommandBehavior.CloseConnection);
            if (myOdbcReader.Read())
            {
                order = new Order();
                order.id = myOdbcReader.GetInt32(myOdbcReader.GetOrdinal("Guru_Id"));
                order.car = new Car();
                order.car.id = myOdbcReader.GetInt32(myOdbcReader.GetOrdinal("Guru_car_id"));
                order.car.model = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_car_model"));
                order.car.brand = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_car_brand"));
                order.driver = new Driver();
                order.driver.id = myOdbcReader.GetInt32(myOdbcReader.GetOrdinal("Guru_driver_id"));
                order.driver.lastName = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_driver_lastName"));
                order.driver.firstName = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_driver_firstName"));
                order.driver.phone = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_driver_phone"));
                order.driver.experience = myOdbcReader.GetInt32(myOdbcReader.GetOrdinal("Guru_driver_experience"));
                order.driver.license = new License();
                order.driver.license.country = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_driver_license_country"));
                order.driver.license.number = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_driver_license_number"));
                order.company = new Company();
                order.company.brand = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_company_brand"));
                order.company.id = myOdbcReader.GetInt32(myOdbcReader.GetOrdinal("Guru_company_id"));
                order.company.interviewSchedule = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_company_interviewSchedule"));
                order.company.token = myOdbcReader.GetString(myOdbcReader.GetOrdinal("Guru_company_token"));
            }
            myOdbcReader.Close();
            myOdbcConnection.Close();

            return order;

        }

        protected void ButtonSaveOrUpdateOrder_Click(object sender, EventArgs e)
        {
            var order = GetOrder(Convert.ToInt32(HiddenFieldId.Value));
            string URI = "https://guru.taxi/api/v1/company/car/request/driver/"+ order.driver.id;
            string myParameters = "comment="+ TextBoxComment.Text+ "&interviewAt="+ TextBoxDateTime.Text.Replace(" ","T")+"+03";

            using (WebClient wc = new WebClient())
            {
                
                wc.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";
                wc.Headers[HttpRequestHeader.Authorization] =  "Bearer " + order.company.token;
                 
                string HtmlResult = wc.UploadString(URI,"PATCH", myParameters);
                Response.Write(HtmlResult);
                Response.End();
            }


            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(URI);
            request.Headers[HttpRequestHeader.Authorization] = "Bearer " + order.company.token; ;
            request.Method = "PATCH";
            request.ContentType = "text/plain;charset=utf-8";

            System.Text.UTF8Encoding encoding = new System.Text.UTF8Encoding();
            byte[] bytes = encoding.GetBytes(myParameters);
            request.ContentLength = bytes.Length;

            using (Stream requestStream = request.GetRequestStream())
            {
                // Send the data.
                requestStream.Write(bytes, 0, bytes.Length);
            }
            var response = (HttpWebResponse)request.GetResponse();
            var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
        }

        protected void ButtonCancelOrder_Click(object sender, EventArgs e)
        {
            var order = GetOrder(Convert.ToInt32(HiddenFieldId.Value));
            string URI = "https://guru.taxi/api/v1/company/car/request/driver/" + order.driver.id+"/reject";
            
            using (WebClient wc = new WebClient())
            {

                wc.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";
                wc.Headers[HttpRequestHeader.Authorization] = "Bearer " + order.company.token;

                string HtmlResult = wc.UploadString(URI, "POST", "");
                Response.Write(HtmlResult);
                Response.End();
            }
        }
    }
}
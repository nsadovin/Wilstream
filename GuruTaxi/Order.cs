using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Guru
{
    public class Order
    {
        public int id { get; set; }
        public Car car { get; set; }
        public Driver driver { get; set; }
        public Company company { get; set; }
    }

    public class Car
    {
        public int id { get; set; }
        public string brand { get; set; }
        public string model { get; set; }
    }
     
    public class Driver
    {

        public int id { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string phone { get; set; }
        public License license { get; set; }
        public int experience { get; set; }
    }  

    public class License
    {
        public string country { get; set; }
        public string number { get; set; }
    }


    public class Company
    {
        public int id { get; set; }
        public string brand { get; set; }
        public string interviewSchedule { get; set; }
        public string token { get; set; }
    } 
}
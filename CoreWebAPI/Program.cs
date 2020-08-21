using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace CoreWebAPI
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var a = "0002".ToCharArray();
            Increment(a);
            
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });

         static void Increment(char[] refernceNumber) {

            bool prevInc = false;
            
            for (int i = refernceNumber.Length; i > 0; i--)
            { 
                int current;
                if (int.TryParse(refernceNumber[i].ToString(), out current))
                {
                    current++;
                    if(prevInc) current++;
                    if (current > 9)
                    {
                        refernceNumber[i] = '0';
                        prevInc = true;
                    }
                    else
                    {
                        refernceNumber[i] = (char)current;
                        prevInc = false;
                        return;
                    }
                }
                else
                {
                    return;
                }
            }
        }
    }
}

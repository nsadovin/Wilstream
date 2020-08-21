
using System.Data.Entity;

namespace WebAPI.Models
{
    public class ApplicationContext : DbContext
    {
        public DbSet<LandproOrder> LandproOrders { get; set; }
        public DbSet<LandproSupply> LandproSupplies { get; set; }
        public DbSet<LandproProduct> LandproProducts { get; set; }
        public ApplicationContext(): base("oktell_ccwsConnectionString")
        {
            //Database.EnsureCreated();   // создаем базу данных при первом обращении

        } 
    }
}

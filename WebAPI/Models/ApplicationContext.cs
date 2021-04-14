
using System.Data.Entity;

namespace WebAPI.Models
{
    public class ApplicationContext : DbContext
    {
        public DbSet<DbLandproOrderV2> DbLandproOrders { get; set; }
        public DbSet<LandproOrder> LandproOrders { get; set; }
        public DbSet<LandproSupply> LandproSupplies { get; set; }
        public DbSet<LandproProduct> LandproProducts { get; set; }
        public DbSet<DbLandproProductV2> DbLandproProducts { get; set; }
        public ApplicationContext(): base("oktell_ConnectionString")
        {
            //Database.EnsureCreated();   // создаем базу данных при первом обращении

        } 
    }
}

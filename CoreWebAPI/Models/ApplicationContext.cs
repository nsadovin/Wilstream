using Microsoft.EntityFrameworkCore;

namespace CoreWebAPI.Models
{
    public class ApplicationContext : DbContext
    {
        public DbSet<LandproOrder> LandproOrders { get; set; }
        public DbSet<LandproSupply> LandproSupplies { get; set; }
        public DbSet<LandproProduct> LandproProducts { get; set; }
        public ApplicationContext(DbContextOptions<ApplicationContext> options)
            : base(options)
        {
            Database.EnsureCreated();   // создаем базу данных при первом обращении

        } 
    }
}

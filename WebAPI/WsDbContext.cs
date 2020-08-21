using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using WebAPI.Models;

namespace WebAPI
{
    public class WsDbContext : DbContext
    {
        public WsDbContext()
            : base("oktell_ConnectionString")
        { }

        public DbSet<Cofactor2User> Cofactor2Users { get; set; }
        public DbSet<CofactorUser> CofactorUsers { get; set; }
        public DbSet<CofactorStat> CofactorStats { get; set; }
        public DbSet<AlfaCapital> AlfaCapitals { get; set; }
        public DbSet<User> ApiUsers { get; set; }
    }
}
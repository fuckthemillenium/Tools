using Microsoft.EntityFrameworkCore;
using Webtool.Models;

namespace Webtool.Data
{
    public class AwsContext : DbContext
    {

        public AwsContext(DbContextOptions<AwsContext> options) : base(options)
        {
        }

        // Add Class in Model to DBSet
        public DbSet<AwsInstance> AwsInstances { get; set; }

        // Overide database table name.  Default uses same as DBSet property name
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AwsInstance>().ToTable("AwsInstance");
        }
    }
}

using System.Linq;
using Webtool.Models;

namespace Webtool.Data
{
    public static class AwsDbInitializer
    {
        public static void Initialize(AwsContext context)
        {
            context.Database.EnsureCreated();

            // Look for any data.
            if (context.AwsInstances.Any())
            {
                return;   // DB has been seeded
            }

            // Set initial data to AwsInstance
            var awsinstances = new AwsInstance[]
            {
              new AwsInstance{ AwsInstanceID = "000000", Region = "nowhere", InstanceState = "unknown", Environment = "Uknown", Name = "Unknown"},
              //new AwsInstance{ AwsInstanceID = "111111", Region = "nowhere", InstanceState = "unknown" }
            };

            // Add initial data to Database
            foreach (AwsInstance aws in awsinstances )
            {
                context.AwsInstances.Add(aws);
            }
            context.SaveChanges();


        }
    }
}

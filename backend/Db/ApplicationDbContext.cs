using Microsoft.EntityFrameworkCore;

namespace backend.Db {

  public class ApplicationDbContext : DbContext {
    public DbSet<PeakDataLocation> Locations { get; set; }
    public DbSet<ElectricityCompany> ElectricityCompanies { get; set; }
    public DbSet<ElectricityCompanySeason> ElectricityCompanySeasons { get; set; }
    public DbSet<ElectricityCompanySeasonDay> ElectricityCompanySeasonDays { get; set; }
    public DbSet<ElectricityCompanySeasonDayEntry> ElectricityCompanySeasonDayEntries { get; set; }
    public DbSet<ElectricityCompanySeasonDayEntryRange> ElectricityCompanySeasonDayEntryRanges { get; set; }

    public string DbConectionString { get; }

    public ApplicationDbContext() {
      DbConectionString = GetConnectionString();
    }

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) {
      DbConectionString = GetConnectionString();
    }

    private string GetConnectionString() {
      var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
      if (environment == null) {
        throw new Exception("Unable to load environment variable ASPNETCORE_ENVIRONMENT");
      }
      var configurationBuilder = new ConfigurationBuilder()
        .SetBasePath(AppContext.BaseDirectory)
        .AddJsonFile($"appSettings{(environment == "Production" ? "" : $".{environment}")}.json", true)
        .AddJsonFile($"secrets{(environment == "Production" ? "" : $".{environment}")}.json");
      var configuration = configurationBuilder.Build();

      var connectionString = configuration.GetConnectionString("MoneyLaundrying");
      if (connectionString == null) {
        throw new Exception("Unable to load connection string");
      }
      return ParseConnectionString(connectionString);
    }

    private string ParseConnectionString(string connectionString) {
      var folder = Environment.SpecialFolder.LocalApplicationData;
      var folderPath = Environment.GetFolderPath(folder);
      var dbPath = Path.Join(folderPath, "peak_data.db");
      return connectionString.Replace("{Path}", dbPath);
    }

    protected override void OnConfiguring(DbContextOptionsBuilder options) {
      base.OnConfiguring(options);
      options
        .UseSqlite(DbConectionString)
        .UseSeeding((context, _) => {
          Task _task = Seeder.Seed(context);
          _task.Wait();
        }).UseAsyncSeeding(async (context, _, cancellationToken) => {
          await Seeder.Seed(context, cancellationToken);
        });
    }

    public override int SaveChanges() {
      foreach (var entry in ChangeTracker.Entries()) {
        if (entry.Entity is IId entity && entry.State == EntityState.Added) {
          if (string.IsNullOrEmpty(entity.Id)) {
            entity.Id = Guid.NewGuid().ToString();
          }
        }
      }
      return base.SaveChanges();
    }

    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default) {
      foreach (var entry in ChangeTracker.Entries()) {
        if (entry.Entity is IId entity && entry.State == EntityState.Added) {
          if (string.IsNullOrEmpty(entity.Id)) {
            entity.Id = Guid.NewGuid().ToString();
          }
        }
      }
      return await base.SaveChangesAsync(cancellationToken);
    }
  }

}

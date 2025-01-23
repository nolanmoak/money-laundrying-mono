using Microsoft.EntityFrameworkCore;

namespace backend.Db {

  public class ApplicationDbContext : DbContext {
    public DbSet<ElectricityCompany> ElectricityCompanies { get; set; }
    public DbSet<PeakDataLocation> Locations { get; set; }
    public DbSet<PeakDataLocationSeason> LocationSeasons { get; set; }
    public DbSet<PeakDataLocationSeasonDay> LocationSeasonDays { get; set; }
    public DbSet<PeakDataLocationSeasonDayEntry> LocationSeasonDayEntries { get; set; }
    public DbSet<PeakDataLocationSeasonDayEntryRange> LocationSeasonDayEntryRanges { get; set; }

    public string DbPath { get; }

    public ApplicationDbContext() {
      var folder = Environment.SpecialFolder.LocalApplicationData;
      var path = Environment.GetFolderPath(folder);
      DbPath = Path.Join(path, "peak_data.db");
    }

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) {
      var folder = Environment.SpecialFolder.LocalApplicationData;
      var path = Environment.GetFolderPath(folder);
      DbPath = Path.Join(path, "peak_data.db");
    }

    protected override void OnConfiguring(DbContextOptionsBuilder options) {
      base.OnConfiguring(options);
      options
        .UseSqlite($"Data Source={DbPath}")
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

using Microsoft.EntityFrameworkCore;

namespace backend.Db {

  public static class Seeder {
    public static async Task Seed(DbContext context, CancellationToken cancellationToken = default) {
      Console.WriteLine("Starting Seeder...");
      ElectricityCompany hydroOttawa = new() {
        Name = "Hydro Ottawa",
        Url = "https://hydroottawa.com/en/accounts-services/accounts/rates-conditions/electricity-charge",
      };
      await context.Set<ElectricityCompany>().AddAsync(hydroOttawa);
      await context.SaveChangesAsync();
      Console.WriteLine($"Added hydro ottawa: {hydroOttawa}");

      PeakDataLocation ottawaLocation = new() {
        City = "Ottawa",
        State = "Ontario",
        StateCode = "ON",
        Country = "Canada",
        CountryCode = "CA",
        ElectricityCompany = hydroOttawa,
      };
      await context.Set<PeakDataLocation>().AddAsync(ottawaLocation);
      await context.SaveChangesAsync();
      Console.WriteLine($"Added ottawa location: {ottawaLocation}");

      List<PeakDataLocationSeason> seasons = [
        new() {
          Location = ottawaLocation,
          Season = PeakDataSeason.Winter,
        },
        new() {
          Location = ottawaLocation,
          Season = PeakDataSeason.Summer,
        },
      ];
      await context.Set<PeakDataLocationSeason>().AddRangeAsync(seasons, cancellationToken);
      await context.SaveChangesAsync(cancellationToken);
      Console.WriteLine($"Added seasons: {seasons}");

      List<PeakDataLocationSeasonDay> days = [];
      foreach (var season in seasons) {
        for (int i = 1; i <= 7; i++) {
          days.Add(new() {
            Day = i,
            Season = season,
          });
        }
      }
      await context.Set<PeakDataLocationSeasonDay>().AddRangeAsync(days, cancellationToken);
      await context.SaveChangesAsync(cancellationToken);
      Console.WriteLine($"Added days: {days}");

      List<PeakDataLocationSeasonDayEntry> entries = [];
      foreach (var day in days) {
        entries.AddRange([
        new() {
          Type = PeakDataType.Off,
          Day = day,
        },
        new() {
          Type = PeakDataType.Mid,
          Day = day,
        },
        new() {
          Type = PeakDataType.On,
          Day = day,
        }]);
      }
      await context.Set<PeakDataLocationSeasonDayEntry>().AddRangeAsync(entries, cancellationToken);
      await context.SaveChangesAsync(cancellationToken);
      Console.WriteLine($"Added entries: {entries}");

      List<PeakDataLocationSeasonDayEntryRange> ranges = [];
      foreach (var entry in entries) {
        if (entry.Day.Day >= 6) {
          if (entry.Type == PeakDataType.Off) {
            ranges.Add(new() {
              Entry = entry,
              StartHour = 0,
              EndHour = 24,
            });
          }
        }
        else if (entry.Day.Season.Season == PeakDataSeason.Winter) {
          switch (entry.Type) {
            case PeakDataType.Off:
              ranges.Add(new() {
                Entry = entry,
                StartHour = 19,
                EndHour = 7,
              });
              break;
            case PeakDataType.Mid:
              ranges.Add(new() {
                Entry = entry,
                StartHour = 11,
                EndHour = 17,
              });
              break;
            case PeakDataType.On:
              ranges.AddRange([
                new() {
                  Entry = entry,
                  StartHour = 7,
                  EndHour = 11,
                },
                new() {
                  Entry = entry,
                  StartHour = 17,
                  EndHour = 19,
                },
              ]);
              break;
          }
        }
        else {
          switch (entry.Type) {
            case PeakDataType.Off:
              ranges.Add(new() {
                Entry = entry,
                StartHour = 19,
                EndHour = 7,
              });
              break;
            case PeakDataType.Mid:
              ranges.AddRange([
                  new() {
                  Entry = entry,
                  StartHour = 7,
                  EndHour = 11,
                },
                new() {
                  Entry = entry,
                  StartHour = 17,
                  EndHour = 19,
                },
              ]);
              break;
            case PeakDataType.On:
              ranges.Add(new() {
                Entry = entry,
                StartHour = 11,
                EndHour = 17,
              });
              break;
          }
        }
      }
      await context.Set<PeakDataLocationSeasonDayEntryRange>().AddRangeAsync(ranges, cancellationToken);
      await context.SaveChangesAsync(cancellationToken);
      Console.WriteLine($"Added ranges: {ranges}");
    }
  }

}

using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace backend.Db {

  interface IId {
    string Id { get; set; }
  }

  public enum PeakDataSeason {
    Winter,
    Summer,
  }

  public enum PeakDataType {
    Off,
    Mid,
    On,
  }

  [Index(nameof(City), [nameof(CountryCode)], IsUnique = true), Index(nameof(ElectricityCompanyId), IsUnique = true)]
  public class PeakDataLocation : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    [StringLength(255)]
    public required string City { get; set; }
    [StringLength(255)]
    public required string State { get; set; }

    [StringLength(255)]
    public required string StateCode { get; set; }

    [StringLength(255)]
    public required string Country { get; set; }

    [StringLength(255)]
    public required string CountryCode { get; set; }

    public ElectricityCompany ElectricityCompany { get; set; } = null!;

    [StringLength(100)]
    public string ElectricityCompanyId { get; set; } = null!;

    public ICollection<PeakDataLocationSeason> Seasons { get; } = [];
  }

  public class ElectricityCompany : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();
    [StringLength(255)]
    public required string Name { get; set; }
    [StringLength(255)]
    public required string Url { get; set; }

    public PeakDataLocation? Location { get; set; }
  }

  [Index(nameof(LocationId), [nameof(Season)], IsUnique = true)]
  public class PeakDataLocationSeason : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required PeakDataSeason Season { get; set; }

    public PeakDataLocation Location { get; set; } = null!;

    [StringLength(100)]
    public string LocationId { get; set; } = null!;

    public ICollection<PeakDataLocationSeasonDay> Days { get; } = [];
  }

  [Index(nameof(SeasonId), [nameof(Day)], IsUnique = true)]
  public class PeakDataLocationSeasonDay : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required int Day { get; set; }

    public PeakDataLocationSeason Season { get; set; } = null!;

    [StringLength(100)]
    public string SeasonId { get; set; } = null!;

    public ICollection<PeakDataLocationSeasonDayEntry> Entries { get; } = [];
  }

  [Index(nameof(DayId), [nameof(Type)], IsUnique = true)]
  public class PeakDataLocationSeasonDayEntry : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required PeakDataType Type { get; set; }

    public PeakDataLocationSeasonDay Day { get; set; } = null!;

    [StringLength(100)]
    public string DayId { get; set; } = null!;

    public ICollection<PeakDataLocationSeasonDayEntryRange> Ranges { get; } = [];
  }

  public class PeakDataLocationSeasonDayEntryRange : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required int StartHour { get; set; }
    public required int EndHour { get; set; }

    public PeakDataLocationSeasonDayEntry Entry { get; set; } = null!;

    [StringLength(100)]
    public string EntryId { get; set; } = null!;
  }

}

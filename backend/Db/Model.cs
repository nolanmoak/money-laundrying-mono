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

  [Index(nameof(City), [nameof(CountryCode)], IsUnique = true), Index(nameof(City), [nameof(StateCode), nameof(CountryCode)])]
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

    public ICollection<ElectricityCompany> ElectricityCompanies { get; } = [];
  }

  public class ElectricityCompany : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();
    [StringLength(255)]
    public required string Name { get; set; }
    [StringLength(255)]
    public required string Url { get; set; }

    public PeakDataLocation Location { get; set; } = null!;

    [StringLength(100)]
    public string LocationId { get; set; } = null!;
    public ICollection<ElectricityCompanySeason> Seasons { get; } = [];
  }

  [Index(nameof(CompanyId), [nameof(Season)], IsUnique = true)]
  public class ElectricityCompanySeason : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required PeakDataSeason Season { get; set; }

    public ElectricityCompany Company { get; set; } = null!;

    [StringLength(100)]
    public string CompanyId { get; set; } = null!;

    public ICollection<ElectricityCompanySeasonDay> Days { get; } = [];
  }

  [Index(nameof(SeasonId), [nameof(Day)], IsUnique = true)]
  public class ElectricityCompanySeasonDay : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required int Day { get; set; }

    public ElectricityCompanySeason Season { get; set; } = null!;

    [StringLength(100)]
    public string SeasonId { get; set; } = null!;

    public ICollection<ElectricityCompanySeasonDayEntry> Entries { get; } = [];
  }

  [Index(nameof(DayId), [nameof(Type)], IsUnique = true)]
  public class ElectricityCompanySeasonDayEntry : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required PeakDataType Type { get; set; }

    public ElectricityCompanySeasonDay Day { get; set; } = null!;

    [StringLength(100)]
    public string DayId { get; set; } = null!;

    public ICollection<ElectricityCompanySeasonDayEntryRange> Ranges { get; } = [];
  }

  public class ElectricityCompanySeasonDayEntryRange : IId {
    [StringLength(100)]
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public required int StartHour { get; set; }
    public required int EndHour { get; set; }

    public ElectricityCompanySeasonDayEntry Entry { get; set; } = null!;

    [StringLength(100)]
    public string EntryId { get; set; } = null!;
  }

}

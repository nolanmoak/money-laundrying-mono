using backend.Db;

namespace backend.Models {

  public class PeakDataHourRange {
    public required int Start { get; set; }
    public required int End { get; set; }
  }

  public class PeakDataEntry {
    public required PeakDataType Type { get; set; }
    public required IEnumerable<PeakDataHourRange> Ranges { get; set; }
  }

  public class PeakDataDay {
    public required int DayOfWeek { get; set; }
    public required IEnumerable<PeakDataEntry> Entries { get; set; }
  }

  public class DataModel {
    public required IEnumerable<PeakDataDay> Days { get; set; }
  }

  public class Location {
    public required string Id { get; set; }
    public required string City { get; set; }
    public required string State { get; set; }
    public required string StateCode { get; set; }
    public required string Country { get; set; }
    public required string CountryCode { get; set; }
  }

  public class LocationAndCompanyModel {
    public required IEnumerable<LocationAndCompany> LocationsAndCompanies { get; set; }
  }

  public class PeakDataElecitricityCompanyMinimal {
    public required string Id { get; set; }
    public required string Name { get; set; }
    public required string Url { get; set; }
  }

  public class LocationAndCompany {
    public required Location Location { get; set; }
    public required PeakDataElecitricityCompanyMinimal Company { get; set; }
  }
}

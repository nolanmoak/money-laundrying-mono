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
    public required IEnumerable<PeakDataDay> Data { get; set; }
  }
}

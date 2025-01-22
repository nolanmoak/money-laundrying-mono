namespace backend.Models {
  public enum PeakDataType {
    Off,
    Mid,
    On
  }

  public class PeakDataHourRange {
    public required int Start { get; set; }
    public required int End { get; set; }
  }

  public class PeakDataEntry {
    public required PeakDataType Type { get; set; }
    public required List<PeakDataHourRange> Ranges { get; set; }
  }

  public class PeakDataDay {
    public required int DayOfWeek { get; set; }
    public required List<PeakDataEntry> Entries { get; set; }
  }

  public class DataModel {
    public required List<PeakDataDay> Data { get; set; }
  }
}

using backend.Models;

namespace backend.Data {

  public interface ISeasonalDataModel {
    DataModel GetDataModel();
  }

  public class WinterDataModel : ISeasonalDataModel {
    public DataModel GetDataModel() {
      return new DataModel() {
        Data = [
          new() // Monday
          {
            DayOfWeek = 1,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [new() { Start = 11, End = 17 }],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
            ],
          },
          new() // Tuesday
          {
            DayOfWeek = 2,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [new() { Start = 11, End = 17 }],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
            ],
          },
          new() // Wednesday
          {
            DayOfWeek = 3,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [new() { Start = 11, End = 17 }],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
            ],
          },
          new() // Thursday
          {
            DayOfWeek = 4,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [new() { Start = 11, End = 17 }],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
            ],
          },
          new() // Friday
          {
            DayOfWeek = 5,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [new() { Start = 11, End = 17 }],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
            ],
          },
          new() // Saturday
          {
            DayOfWeek = 6,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 0, End = 24 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [],
              },
            ],
          },
          new() // Sunday
          {
            DayOfWeek = 7,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 0, End = 24 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [],
              },
            ],
          },
        ],
      };
    }
  }

  public class SummerDataModel : ISeasonalDataModel {
    public DataModel GetDataModel() {
      return new DataModel() {
        Data = [
          new() // Monday
          {
            DayOfWeek = 1,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 19, End = 19 },
                ],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [new() { Start = 11, End = 17 }],
              },
            ],
          },
          new() // Tuesday
          {
            DayOfWeek = 2,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [new() { Start = 11, End = 17 }],
              },
            ],
          },
          new() // Wednesday
          {
            DayOfWeek = 3,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [new() { Start = 11, End = 17 }],
              },
            ],
          },
          new() // Thursday
          {
            DayOfWeek = 4,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [new() { Start = 11, End = 17 }],
              },
            ],
          },
          new() // Friday
          {
            DayOfWeek = 5,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 19, End = 7 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [
                  new() { Start = 7, End = 11 },
                  new() { Start = 17, End = 19 },
                ],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [new() { Start = 11, End = 17 }],
              },
            ],
          },
          new() // Saturday
          {
            DayOfWeek = 6,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 0, End = 24 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [],
              },
            ],
          },
          new() // Sunday
          {
            DayOfWeek = 7,
            Entries = [
              new()
              {
                Type = PeakDataType.Off,
                Ranges = [new() { Start = 0, End = 24 }],
              },
              new()
              {
                Type = PeakDataType.Mid,
                Ranges = [],
              },
              new()
              {
                Type = PeakDataType.On,
                Ranges = [],
              },
            ],
          },
        ],
      };
    }
  }
}

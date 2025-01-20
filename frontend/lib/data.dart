enum PeakDataType { off, mid, on }

typedef PeakDataHourRange = ({int start, int end});
typedef PeakDataList = List<PeakDataHourRange>;
typedef PeakDataEntry = Map<PeakDataType, PeakDataList>;
typedef PeakData = Map<int, PeakDataEntry>;

const PeakData peakDataWinter = {
  DateTime.monday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [(start: 11, end: 17)],
    PeakDataType.on: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
  },
  DateTime.tuesday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [(start: 11, end: 17)],
    PeakDataType.on: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
  },
  DateTime.wednesday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [(start: 11, end: 17)],
    PeakDataType.on: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
  },
  DateTime.thursday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [(start: 11, end: 17)],
    PeakDataType.on: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
  },
  DateTime.friday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [(start: 11, end: 17)],
    PeakDataType.on: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
  },
  DateTime.saturday: {
    PeakDataType.off: [(start: 0, end: 24)],
    PeakDataType.mid: [],
    PeakDataType.on: [],
  },
  DateTime.sunday: {
    PeakDataType.off: [(start: 0, end: 24)],
    PeakDataType.mid: [],
    PeakDataType.on: [],
  },
};

const PeakData peakDataSummer = {
  DateTime.monday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
    PeakDataType.on: [(start: 11, end: 17)],
  },
  DateTime.tuesday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
    PeakDataType.on: [(start: 11, end: 17)],
  },
  DateTime.wednesday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
    PeakDataType.on: [(start: 11, end: 17)],
  },
  DateTime.thursday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
    PeakDataType.on: [(start: 11, end: 17)],
  },
  DateTime.friday: {
    PeakDataType.off: [(start: 19, end: 7)],
    PeakDataType.mid: [
      (start: 7, end: 11),
      (start: 17, end: 19),
    ],
    PeakDataType.on: [(start: 11, end: 17)],
  },
  DateTime.saturday: {
    PeakDataType.off: [(start: 0, end: 24)],
    PeakDataType.mid: [],
    PeakDataType.on: [],
  },
  DateTime.sunday: {
    PeakDataType.off: [(start: 0, end: 24)],
    PeakDataType.mid: [],
    PeakDataType.on: [],
  },
};

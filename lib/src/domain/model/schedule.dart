class Schedule {
  String? id;
  DateTime? dateTime;
  String? time;
  bool? isBooked;

  Schedule({
    required this.id,
    required this.dateTime,
    required this.time,
    required this.isBooked,
  });

  Schedule.fromJson(dynamic json) {
    id = ((json['scheduleDetails'] as List).first)['id'];
    dateTime = json['startTimestamp'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['startTimestamp'])
        : null;
    time = "${json['startTime']} - ${json['endTime']}";
    isBooked = json['isBooked'];
  }
}

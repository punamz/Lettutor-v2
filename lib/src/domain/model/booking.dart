class Booking {
  String? scheduleId;
  String? tutorId;
  String? tutorName;
  String? tutorAvatar;
  DateTime? date;
  String? time;
  String? request;
  String? studentMeetingLink;
  String? tutorReview;

  Booking({
    this.scheduleId,
    this.tutorName,
    this.tutorAvatar,
    this.date,
    this.time,
    this.request,
    this.studentMeetingLink,
    this.tutorReview,
    this.tutorId,
  });
  Booking.fromJson(dynamic json) {
    scheduleId = json['scheduleDetailId'];
    tutorName = json['scheduleDetailInfo']['scheduleInfo']['tutorInfo']['name'];
    tutorAvatar = json['scheduleDetailInfo']['scheduleInfo']['tutorInfo']['avatar'];
    studentMeetingLink = json['studentMeetingLink'];
    date = json['scheduleDetailInfo']['startPeriodTimestamp'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['scheduleDetailInfo']['startPeriodTimestamp'])
        : null;
    time =
        "${json['scheduleDetailInfo']['startPeriod']} - ${json['scheduleDetailInfo']['endPeriod']}";
    request = json['studentRequest'];
    tutorReview = json['tutorReview'];
    tutorId = json['scheduleDetailInfo']['scheduleInfo']['tutorId'];
  }
}

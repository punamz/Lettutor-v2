class Review {
  Review({this.bookingId, this.rating, this.avatar, this.name, this.content, this.time});

  String? bookingId;
  String? avatar;
  String? name;
  int? rating;
  String? content;
  DateTime? time;

  Review.fromJson(dynamic json) {
    name = json['firstInfo']['name'];
    avatar = json['firstInfo']['avatar'];
    bookingId = json["bookingId"];
    rating = json["rating"];
    content = json["content"];
    time = json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
  }
}

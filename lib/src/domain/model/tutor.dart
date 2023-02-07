import 'package:lettutor/src/domain/model/review.dart';

class Tutor {
  Tutor({
    this.avatar,
    this.name,
    this.country,
    this.feedbacks,
    this.userId,
    this.video,
    this.bio,
    this.experience,
    this.interests,
    this.languages,
    this.specialties,
    this.rating,
    this.isLike,
  });

  Tutor.fromJson(dynamic json) {
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    if (json['feedbacks'] != null) {
      feedbacks = [];
      json['feedbacks'].forEach((v) {
        feedbacks?.add(Review.fromJson(v));
      });
    }
    userId = json['userId'];
    video = json['video'];
    bio = json['bio'];

    experience = json['experience'];
    interests = json['interests'];
    languages = json['languages']?.split(',');
    specialties = json['specialties']?.split(',');
    rating = json['rating'];
  }
  String? avatar;
  String? name;
  String? country;
  List<Review>? feedbacks;
  String? userId;
  String? video;
  String? bio;
  String? experience;
  String? interests;
  List<String>? languages;
  List<String>? specialties;
  double? rating;
  bool? isLike;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatar'] = avatar;
    map['name'] = name;
    map['country'] = country;
    map['userId'] = userId;
    map['video'] = video;
    map['bio'] = bio;
    map['experience'] = experience;
    map['interests'] = interests;
    map['languages'] = languages;
    map['specialties'] = specialties;
    map['rating'] = rating;
    return map;
  }
}

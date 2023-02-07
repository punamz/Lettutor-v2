import 'package:lettutor/src/domain/model/topic.dart';

class Course {
  Course({
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.topics,
  });

  Course.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    reason = json['reason'];
    purpose = json['purpose'];
    if (json['topics'] != null) {
      topics = [];
      json['topics'].forEach((v) {
        topics?.add(Topic.fromJson(v));
      });
    }
  }
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  List<Topic>? topics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['level'] = level;
    map['reason'] = reason;
    map['purpose'] = purpose;
    if (topics != null) {
      map['topics'] = topics?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Topic {
  Topic({
    this.name,
    this.nameFile,
  });

  Topic.fromJson(dynamic json) {
    name = json['name'];
    nameFile = json['nameFile'];
  }
  String? name;
  String? nameFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['nameFile'] = nameFile;
    return map;
  }
}

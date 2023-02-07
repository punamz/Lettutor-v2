class Wallet {
  Wallet({
    this.id,
    this.userId,
    this.amount,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.bonus,
  });

  Wallet.fromJson(dynamic json) {
    id = json['id'];
    userId = json['userId'];
    amount = json['amount'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'] != null ? DateTime.parse(json["createdAt"]) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.parse(json["updatedAt"]) : null;
    bonus = json['bonus'];
  }
  String? id;
  String? userId;
  String? amount;
  bool? isBlocked;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? bonus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userId'] = userId;
    map['amount'] = amount;
    map['isBlocked'] = isBlocked;
    map['createdAt'] = createdAt?.toIso8601String();
    map['updatedAt'] = updatedAt?.toIso8601String();
    map['bonus'] = bonus;
    return map;
  }
}

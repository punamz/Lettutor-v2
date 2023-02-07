import 'package:intl/intl.dart';
import 'package:lettutor/src/domain/model/wallet.dart';

class User {
  User({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.walletInfo,
    this.level,
    this.isPhoneActivated,
    this.timezone,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'] != null ? DateFormat("yyyy-MM-dd").parse(json["birthday"]) : null;
    walletInfo = json['walletInfo'] != null ? Wallet.fromJson(json['walletInfo']) : null;
    level = json['level'];
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
  }
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  String? language;
  DateTime? birthday;
  Wallet? walletInfo;
  String? level;
  bool? isPhoneActivated;
  int? timezone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['name'] = name;
    map['avatar'] = avatar;
    map['country'] = country;
    map['phone'] = phone;
    map['language'] = language;
    map['birthday'] = birthday?.toIso8601String();
    if (walletInfo != null) {
      map['walletInfo'] = walletInfo?.toJson();
    }
    map['level'] = level;
    map['isPhoneActivated'] = isPhoneActivated;
    map['timezone'] = timezone;
    return map;
  }
}

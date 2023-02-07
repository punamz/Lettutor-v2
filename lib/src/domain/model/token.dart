class Token {
  Token({
    this.access,
    this.refresh,
  });

  Token.fromJson(dynamic json) {
    access = json['access'] != null ? TokenInfo.fromJson(json['access']) : null;
    refresh = json['refresh'] != null ? TokenInfo.fromJson(json['refresh']) : null;
  }
  TokenInfo? access;
  TokenInfo? refresh;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (access != null) {
      map['access'] = access?.toJson();
    }
    if (refresh != null) {
      map['refresh'] = refresh?.toJson();
    }
    return map;
  }
}

class TokenInfo {
  TokenInfo({
    this.token,
    this.expires,
  });

  TokenInfo.fromJson(dynamic json) {
    token = json['token'];
    expires = json['expires'] != null ? DateTime.parse(json['expires']) : null;
  }
  String? token;
  DateTime? expires;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['expires'] = expires?.toIso8601String();
    return map;
  }
}

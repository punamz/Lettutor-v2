import 'package:lettutor/src/domain/model/token.dart';
import 'package:lettutor/src/domain/model/user.dart';

class Auth {
  Auth({
    this.user,
    this.tokens,
  });

  User? user;
  Token? tokens;

  Auth.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json["user"]);
    tokens = Token.fromJson(json["tokens"]);
  }
}

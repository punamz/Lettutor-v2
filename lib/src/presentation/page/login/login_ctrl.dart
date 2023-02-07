import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/domain/model/auth.dart';
import 'package:lettutor/src/domain/model/user.dart';
import 'package:lettutor/src/domain/service/authentication_service.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxnString emailError = RxnString();
  final RxnString passwordError = RxnString();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> onLogin() async {
    emailError.value = null;
    passwordError.value = null;
    if (emailController.text.isNullOrEmpty()) {
      emailError.value = 'Email cannot be empty';
      return false;
    }
    if (passwordController.text.isNullOrEmpty()) {
      passwordError.value = 'Password cannot be empty';
      return false;
    }

    Util.showLoading();
    final AuthenticationService authenticationService = Get.find();
    Map<String, dynamic> param = {
      'email': emailController.text,
      'password': passwordController.text
    };
    Either<String, Auth> res = await authenticationService.login(param);
    return res.fold(
      (l) {
        Util.hideLoading();
        Util.showSnackBar(
          l,
          backgroundColor: Get.theme.colorScheme.error,
          textColor: Get.theme.colorScheme.onError,
        );
        return false;
      },
      (r) {
        _saveDataToLocal(r.user!, r.tokens!.access!.token!);
        Util.hideLoading();
        return true;
      },
    );
  }

  void _saveDataToLocal(User user, String token) {
    Storage.instance.writeString(Constant.userId, user.id);
    Storage.instance.writeString(Constant.soDT, user.phone);
    Storage.instance.writeString(Constant.avatar, user.avatar);
    Storage.instance.writeString(Constant.fullName, user.name);
    Storage.instance.writeString(Constant.email, user.email);
    Storage.instance.writeString(Constant.jwtToken, token);
    Storage.instance.writeString(Constant.dayOfBirth, user.birthday?.toIso8601String());
    Storage.instance.writeString(Constant.country, user.country);
    Storage.instance.writeString(Constant.level, user.level);
    Storage.instance.writeString(Constant.walletId, user.walletInfo?.id);
    Storage.instance.writeInt(
        Constant.walletAmount, (int.parse(user.walletInfo?.amount ?? '0') / 100000).round());
  }
}

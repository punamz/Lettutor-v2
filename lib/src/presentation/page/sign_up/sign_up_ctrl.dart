import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/domain/service/authentication_service.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final hidePassword = true.obs;
  final hideRePassword = true.obs;
  final RxnString nameError = RxnString();
  final RxnString emailError = RxnString();
  final RxnString passwordError = RxnString();
  final RxnString rePasswordError = RxnString();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  Future<bool> onSignUp() async {
    nameError.value = null;
    emailError.value = null;
    passwordError.value = null;
    rePasswordError.value = null;

    if (emailController.text.isNullOrEmpty()) {
      emailError.value = 'Email cannot be empty';
      return false;
    }
    if (passwordController.text.isNullOrEmpty()) {
      passwordError.value = 'Password cannot be empty';
      return false;
    }
    if (rePasswordController.text.isNullOrEmpty()) {
      rePasswordError.value = 'Re-password cannot be empty';
      return false;
    }
    if (rePasswordController.text != passwordController.text) {
      rePasswordError.value = 'Password does not match';
      return false;
    }

    Util.showLoading();
    final AuthenticationService authenticationService = Get.find();
    Map<String, dynamic> param = {
      'email': emailController.text,
      'password': passwordController.text
    };
    var res = await authenticationService.register(param);
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
        Util.hideLoading();
        return true;
      },
    );
  }
}

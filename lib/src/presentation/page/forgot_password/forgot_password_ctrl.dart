import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/domain/service/authentication_service.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final RxnString emailError = RxnString();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<bool> onSubmit() async {
    emailError.value = null;
    if (emailController.text.isNullOrEmpty()) {
      emailError.value = 'Email cannot be empty';
      return false;
    }
    Util.showLoading();
    final AuthenticationService authenticationService = Get.find();
    Map<String, dynamic> param = {'email': emailController.text};
    Either<String, String> res = await authenticationService.forgotPassword(param);
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

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lettutor/config/image_assets.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/presentation/custom_widget/custom_text_field.dart';
import 'package:lettutor/src/presentation/page/forgot_password/forgot_password_ctrl.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  static const String routeName = '/ForgotPasswordView';
  const ForgotPasswordView({Key? key}) : super(key: key);

  Future<void> _onPressSendBtn() async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool result = await controller.onSubmit();
    if (result) {
      Get.back();
      Util.showSnackBar(
        'Check your email for a link to reset your password.',
        title: 'Reset your password',
        backgroundColor: Get.theme.colorScheme.primary,
        textColor: Get.theme.colorScheme.onPrimary,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(title: const Text('Forgot password'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 50),
              Center(
                child: ExtendedImage.asset(ImageAssets.appLogo, width: 120, fit: BoxFit.cover),
              ),
              const SizedBox(height: 50),
              Text(
                "Enter your email address and we'll send you a link to reset your password",
                textAlign: TextAlign.center,
                style: context.textTheme
                    .apply(bodyColor: context.theme.colorScheme.secondary)
                    .bodyMedium,
              ),
              const SizedBox(height: 50),
              Obx(() => CustomTextField(
                    controller: controller.emailController,
                    hintText: 'Enter your email',
                    errorText: controller.emailError.value,
                  )),
              const SizedBox(height: 50),
              SizedBox(
                width: context.width,
                height: 45,
                child: ElevatedButton(onPressed: _onPressSendBtn, child: const Text('SEND')),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

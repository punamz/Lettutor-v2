import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lettutor/config/image_assets.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/presentation/custom_widget/input_field_widget.dart';
import 'package:lettutor/src/presentation/page/sign_up/sign_up_ctrl.dart';

class SignUpView extends GetView<SignUpController> {
  static const String routeName = '/SignUpView';
  const SignUpView({Key? key}) : super(key: key);

  Future<void> _onPressRegisterBtn() async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool result = await controller.onSignUp();
    if (result) {
      Get.back();
      Util.showSnackBar(
        'Check your email to verify account.',
        title: 'Create account',
        backgroundColor: Get.theme.colorScheme.primary,
        textColor: Get.theme.colorScheme.onPrimary,
      );
    }
  }

  void _onPressLoginWithFacebookBtn() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onPressLoginWithGoogleBtn() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onPressLoginBtn() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign up'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 50),
              Obx(() => InputFieldWidget(
                    controller: controller.emailController,
                    title: 'Email',
                    hintText: 'example@example.com',
                    errorText: controller.emailError.value,
                  )),
              const SizedBox(height: 20),
              Obx(() => InputFieldWidget(
                    controller: controller.passwordController,
                    title: 'Password',
                    hintText: '******',
                    errorText: controller.passwordError.value,
                    isPassword: controller.hidePassword.value,
                  )),
              const SizedBox(height: 20),
              Obx(() => InputFieldWidget(
                    controller: controller.rePasswordController,
                    title: 'Confirm password',
                    hintText: '******',
                    errorText: controller.rePasswordError.value,
                    isPassword: controller.hideRePassword.value,
                  )),
              const SizedBox(height: 40),
              SizedBox(
                width: context.width,
                height: 45,
                child: ElevatedButton(
                  onPressed: _onPressRegisterBtn,
                  child: const Text('REGISTER'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Or continue with',
                  style: context.textTheme
                      .apply(bodyColor: context.theme.colorScheme.secondary)
                      .bodyMedium,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _onPressLoginWithFacebookBtn,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: context.theme.colorScheme.primary),
                      ),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Center(child: Image.asset(IconAssets.facebookLogo, height: 24)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: _onPressLoginWithGoogleBtn,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: context.theme.colorScheme.primary),
                      ),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Center(child: Image.asset(IconAssets.googleLogo, height: 24)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Already have account? "),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: _onPressLoginBtn,
                          child: Text(
                            ' Sign in',
                            style: context.textTheme
                                .apply(bodyColor: context.theme.colorScheme.primary)
                                .bodyMedium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

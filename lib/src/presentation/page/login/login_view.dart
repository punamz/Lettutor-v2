import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lettutor/config/image_assets.dart';
import 'package:lettutor/src/presentation/custom_widget/input_field_widget.dart';
import 'package:lettutor/src/presentation/page/forgot_password/forgot_password_view.dart';
import 'package:lettutor/src/presentation/page/landing/landing_view.dart';
import 'package:lettutor/src/presentation/page/login/login_ctrl.dart';
import 'package:lettutor/src/presentation/page/sign_up/sign_up_view.dart';

class LoginView extends GetView<LoginController> {
  static const String routeName = '/LoginView';
  const LoginView({Key? key}) : super(key: key);

  void _onPressForgotPasswordBtn() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.toNamed(ForgotPasswordView.routeName);
  }

  Future<void> _onPressLoginBtn() async {
    FocusManager.instance.primaryFocus?.unfocus();
    bool result = await controller.onLogin();
    if (result) Get.offAndToNamed(LandingView.routeName);
  }

  void _onPressLoginWithFacebookBtn() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onPressLoginWithGoogleBtn() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onPressSignUpBtn() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.toNamed(SignUpView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign in'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 50),
              Center(
                child: ExtendedImage.asset(ImageAssets.appLogo, width: 120, fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),
              Obx(() => InputFieldWidget(
                    controller: controller.emailController,
                    hintText: 'example@example.com',
                    title: 'Email',
                    errorText: controller.emailError.value,
                  )),
              const SizedBox(height: 20),
              Obx(() => InputFieldWidget(
                    controller: controller.passwordController,
                    hintText: '******',
                    isPassword: true,
                    title: 'Password',
                    errorText: controller.passwordError.value,
                  )),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _onPressForgotPasswordBtn,
                  child: Text(
                    'Forgot Password?',
                    style: context.textTheme
                        .apply(bodyColor: context.theme.colorScheme.primary)
                        .bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: context.width,
                height: 45,
                child: ElevatedButton(onPressed: _onPressLoginBtn, child: const Text('LOGIN')),
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
              const SizedBox(height: 20),
              Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Don't have account? "),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: _onPressSignUpBtn,
                          child: Text(
                            ' Sign up',
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/page/register_tutor/child_widget/approval_widget.dart';
import 'package:lettutor/src/presentation/page/register_tutor/child_widget/complete_profile_widget.dart';
import 'package:lettutor/src/presentation/page/register_tutor/child_widget/video_introduction_widget.dart';
import 'package:lettutor/src/presentation/page/register_tutor/register_tutor_ctrl.dart';

class RegisterTutorView extends GetView<RegisterTutorController> {
  static const String routeName = '/RegisterTutorView';
  const RegisterTutorView({Key? key}) : super(key: key);

  void _onStepContinue() {
    switch (controller.step.value) {
      case 0:
        controller.handleProfile();
        break;
      case 1:
        controller.submit();
        break;
      default:
        Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Tutor')),
      body: Obx(() => Stepper(
            currentStep: controller.step.value,
            onStepCancel: Get.back,
            onStepContinue: _onStepContinue,
            steps: [
              Step(
                state: controller.profileStepState.value,
                isActive: controller.step.value == 0,
                title: const Text('Complete profile'),
                content: const CompleteProfileWidget(),
              ),
              Step(
                state: controller.introductionStepState.value,
                isActive: controller.step.value == 1,
                title: const Text('Video introduction'),
                content: const VideoIntroductionWidget(),
              ),
              Step(
                state: controller.approvalStepState.value,
                label: const Text('ok'),
                isActive: controller.step.value == 2,
                title: const Text('Approval'),
                content: const ApprovalWidget(),
              ),
            ],
          )),
    );
  }
}

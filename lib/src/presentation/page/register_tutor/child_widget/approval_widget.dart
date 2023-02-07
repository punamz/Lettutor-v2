import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/image_assets.dart';
import 'package:lettutor/src/presentation/page/register_tutor/register_tutor_ctrl.dart';
import 'package:lottie/lottie.dart';

class ApprovalWidget extends GetView<RegisterTutorController> {
  const ApprovalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Lottie.asset(AnimationAssets.done, height: 150),
          Text(
            "You have done all the steps\nPlease, wait for the operator's approval",
            style: context.textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}

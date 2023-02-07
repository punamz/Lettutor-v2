import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/config/image_assets.dart';
import 'package:lettutor/src/presentation/page/register_tutor/register_tutor_ctrl.dart';

class VideoIntroductionWidget extends GetView<RegisterTutorController> {
  const VideoIntroductionWidget({Key? key}) : super(key: key);

  _onPressChooseVideoBtn() async {
    final ImagePicker picker = ImagePicker();
    XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    controller.videoSelected.value = video;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(ImageAssets.tutorVideo, width: 75, fit: BoxFit.cover),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Introduce yourself',
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Let students know what they can expect from a lesson with you by recording '
                    'a video highlighting your teaching style, expertise and personality. '
                    'Students can be nervous to speak with a foreigner, so it really helps to have '
                    'a friendly video that introduces yourself and invites students to call you.',
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Text('Introduction video', style: context.textTheme.titleLarge),
              const Expanded(child: Divider()),
            ],
          ),
        ),
        Obx(() => controller.videoSelected.value != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(controller.videoSelected.value!.path.split('/').last),
              )
            : const SizedBox.shrink()),
        ElevatedButton(onPressed: _onPressChooseVideoBtn, child: const Text('Choose video'))
      ],
    );
  }
}

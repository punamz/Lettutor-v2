import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_ctrl.dart';

class ReportDialog extends GetView<TutorDetailController> {
  const ReportDialog({Key? key}) : super(key: key);

  void _onPressSubmit() {
    controller.reportTutor();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: AlertDialog(
        title: Text('Report ${controller.tutor.name}'),
        content: SizedBox(
          height: context.height * 0.4,
          child: Column(
            children: [
              Row(
                children: [
                  Obx(() => Checkbox(
                        value: controller.isAnnoying.value,
                        onChanged: (bool? value) {
                          if (value != null) controller.isAnnoying.value = value;
                        },
                      )),
                  const Expanded(child: Text('This tutor is annoying me'))
                ],
              ),
              Row(
                children: [
                  Obx(() => Checkbox(
                        value: controller.isFake.value,
                        onChanged: (bool? value) {
                          if (value != null) controller.isFake.value = value;
                        },
                      )),
                  const Expanded(child: Text('This profile is pretending be someone or is fake'))
                ],
              ),
              Row(
                children: [
                  Obx(() => Checkbox(
                        value: controller.isInappropriate.value,
                        onChanged: (bool? value) {
                          if (value != null) controller.isInappropriate.value = value;
                        },
                      )),
                  const Expanded(child: Text('Inappropriate profile photo'))
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  controller: controller.reportController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Please help us know details about your problem',
                    hintMaxLines: 3,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: context.theme.colorScheme.onPrimary,
              backgroundColor: context.theme.colorScheme.primary,
            ),
            onPressed: _onPressSubmit,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

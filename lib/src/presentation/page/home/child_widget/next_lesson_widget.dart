import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:lettutor/src/presentation/page/call/call_view.dart';
import 'package:lettutor/src/presentation/page/home/home_ctrl.dart';

class NextLessonWidget extends GetView<HomeController> {
  const NextLessonWidget({Key? key}) : super(key: key);

  void _onPressEnterNextLesson() {
    Get.toNamed(CallView.routeName, arguments: controller.nextLesson.value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: context.width,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.theme.colorScheme.primary),
        child: Center(
          child: Obx(
            () => controller.isGettingNextLesson.value
                ? const LoadingWidget()
                : Obx(
                    () => controller.nextLesson.value == null
                        ? Text(
                            'You have no upcoming lesson',
                            style: context.textTheme
                                .apply(bodyColor: context.theme.colorScheme.onPrimary)
                                .titleLarge,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Upcoming lesson',
                                style: context.textTheme
                                    .apply(bodyColor: context.theme.colorScheme.onPrimary)
                                    .titleMedium,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${controller.nextLesson.value?.date.format('EEE, dd MMM yy')} ${controller.nextLesson.value?.time}',
                                style: context.textTheme
                                    .apply(bodyColor: context.theme.colorScheme.onPrimary)
                                    .titleLarge,
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _onPressEnterNextLesson,
                                child: const Text('Enter lesson room'),
                              )
                            ],
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}

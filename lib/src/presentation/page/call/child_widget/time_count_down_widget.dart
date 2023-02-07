import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/page/call/call_ctrl.dart';

class TimeCountDownWidget extends GetView<CallController> {
  const TimeCountDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Lesson will be started after'),
              const SizedBox(height: 10),
              CountdownTimer(
                endTime: controller.booking.date?.millisecondsSinceEpoch,
                widgetBuilder: (_, remainingTime) => remainingTime == null
                    ? const SizedBox.shrink()
                    : Text(
                        '${remainingTime.hours ?? 0} : ${remainingTime.min ?? 0} : ${remainingTime.sec}',
                        style: context.textTheme
                            .apply(displayColor: context.theme.colorScheme.onSecondaryContainer)
                            .headlineMedium,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

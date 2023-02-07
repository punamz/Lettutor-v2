import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/src/domain/model/schedule.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_ctrl.dart';

class BookingDetailDialog extends GetView<TutorDetailController> {
  final Schedule schedule;
  const BookingDetailDialog({required this.schedule, Key? key}) : super(key: key);

  void _onPressSubmit() {
    Get.back();
    controller.bookSchedule(schedule);
  }

  int get lesson => Storage.instance.readInt(Constant.walletAmount);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: AlertDialog(
        title: const Text('Booking details'),
        contentPadding: const EdgeInsets.only(top: 20),
        content: SizedBox(
          width: context.width,
          height: context.height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Booking time ', style: context.textTheme.titleMedium),
              const SizedBox(height: 10),
              Text('${schedule.time} ${schedule.dateTime.format('EEEE, dd MMMM yyyy')}'),
              const SizedBox(height: 20),
              Text.rich(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                TextSpan(
                  children: [
                    TextSpan(text: 'Balance ', style: context.textTheme.titleMedium),
                    TextSpan(
                      text: 'you have $lesson lesson left',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                TextSpan(
                  children: [
                    TextSpan(text: 'Price ', style: context.textTheme.titleMedium),
                    const TextSpan(text: '1 lesson'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Note', style: context.textTheme.titleMedium),
              Expanded(
                child: TextField(
                  controller: controller.noteController,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
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

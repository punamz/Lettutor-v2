import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/config/raw_data.dart';
import 'package:lettutor/src/domain/model/schedule.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/child_widget/booking_detail_dialog.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_ctrl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class BookingDialog extends StatefulWidget {
  const BookingDialog({Key? key}) : super(key: key);

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  final TutorDetailController controller = Get.find();
  final LinkedScrollControllerGroup _controllers = LinkedScrollControllerGroup();
  late final ScrollController _headController;
  late final ScrollController _bodyController;

  @override
  void initState() {
    super.initState();
    _headController = _controllers.addAndGet();
    _bodyController = _controllers.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      title: const Text('Select schedule'),
      contentPadding: const EdgeInsets.only(top: 20),
      content: SizedBox(
        width: context.width,
        height: context.height * 0.4,
        child: Obx(
          () => controller.isGotSchedule.value
              ? const Center(child: LoadingWidget())
              : Column(
                  children: [
                    _TableHead(scrollController: _headController),
                    Expanded(child: _TableBody(scrollController: _bodyController)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _TableHead extends StatelessWidget {
  final ScrollController scrollController;
  const _TableHead({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const _HeaderCell(title: ''),
          Expanded(
            child: ListView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              children: List.generate(
                7,
                (index) => _HeaderCell(
                  title: DateTime.now().add(Duration(days: index)).format('EEE dd/MM'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableBody extends StatefulWidget {
  final ScrollController scrollController;
  const _TableBody({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<_TableBody> createState() => _TableBodyState();
}

class _TableBodyState extends State<_TableBody> {
  final LinkedScrollControllerGroup _controllers = LinkedScrollControllerGroup();
  final TutorDetailController controller = Get.find();
  late final ScrollController _firstColumnController;
  late final ScrollController _restColumnsController;
  @override
  void initState() {
    super.initState();
    _firstColumnController = _controllers.addAndGet();
    _restColumnsController = _controllers.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: ListView(
            controller: _firstColumnController,
            children: List.generate(
              scheduleTimes.length,
              (index) => _HeaderCell(title: scheduleTimes[index]),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 7 * 100,
              child: ListView(
                controller: _restColumnsController,
                children: List.generate(
                  scheduleTimes.length,
                  (schedule) => Row(
                    children: List.generate(
                      7,
                      (index) => _ElementCell(
                        schedule: controller.schedules.firstWhereOrNull((element) =>
                            element.time == scheduleTimes[schedule] &&
                            element.dateTime.isSameDate(DateTime.now().add(Duration(days: index)))),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String title;
  const _HeaderCell({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.theme.colorScheme.secondaryContainer),
        child: Center(child: Text(title)),
      ),
    );
  }
}

class _ElementCell extends StatelessWidget {
  final Schedule? schedule;
  const _ElementCell({Key? key, required this.schedule}) : super(key: key);

  void _onBookingClass() {
    Get.dialog(BookingDetailDialog(schedule: schedule!), barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: DecoratedBox(
        decoration: BoxDecoration(color: context.theme.colorScheme.background),
        child: schedule != null && (schedule!.dateTime?.isAfter(DateTime.now()) ?? true)
            ? Center(
                child: schedule!.isBooked == true
                    ? const Text('Booked')
                    : ElevatedButton(
                        onPressed: _onBookingClass,
                        child: const Text('Book'),
                      ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

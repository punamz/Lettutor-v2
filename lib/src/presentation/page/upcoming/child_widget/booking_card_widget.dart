import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/src/domain/model/booking.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';
import 'package:lettutor/src/presentation/page/call/call_view.dart';

class BookingCardWidget extends StatelessWidget {
  final Booking booking;
  final void Function() onCancel;
  BookingCardWidget({Key? key, required this.booking, required this.onCancel}) : super(key: key);

  void _onPressMeetingBtn() {
    Get.toNamed(CallView.routeName, arguments: booking);
  }

  final RxBool _expanded = false.obs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => ExpansionPanelList(
                  elevation: 0,
                  children: [
                    ExpansionPanel(
                      backgroundColor: Colors.transparent,
                      headerBuilder: (context, isExpanded) => Row(
                        children: [
                          AvatarWidget(size: 50, imageUrl: booking.tutorAvatar ?? ''),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(booking.tutorName ?? '', style: context.textTheme.titleMedium),
                              const SizedBox(height: 5),
                              Text('${booking.date.format('yyyy-MM-dd')} ${booking.time}'),
                            ],
                          )
                        ],
                      ),
                      body: SizedBox(
                        width: context.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                              booking.request ?? 'Currently there are no requests for this class.'),
                        ),
                      ),
                      isExpanded: _expanded.value,
                      canTapOnHeader: true,
                    ),
                  ],
                  expansionCallback: (panelIndex, isExpanded) => _expanded.toggle(),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onCancel,
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: context.theme.colorScheme.onPrimary,
                          backgroundColor: context.theme.colorScheme.primary,
                        ),
                        onPressed: _onPressMeetingBtn,
                        child: const Text('Go to Meeting'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/custom_widget/listview_loadmore.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:lettutor/src/presentation/page/session_history/child_widget/session_card_widget.dart';
import 'package:lettutor/src/presentation/page/session_history/session_history_ctrl.dart';

class SessionHistoryView extends GetView<SessionHistoryController> {
  static const String routeName = '/SessionHistoryView';
  const SessionHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session history')),
      body: Obx(
        () => controller.isGettingData.value
            ? const Center(child: LoadingWidget())
            : Obx(
                () => controller.bookings.isNotEmpty
                    ? Obx(
                        () => ListViewLoadMoreWidget(
                          itemCount: controller.bookings.length,
                          itemBuilder: (context, index) =>
                              SessionCardWidget(booking: controller.bookings[index]),
                          funcLoadMore: controller.loadMoreBooking,
                          showLoading: controller.isLoadingMore.stream,
                          canLoadMore: controller.canLoadMore.stream,
                        ),
                      )
                    : Center(
                        child: Text(
                          'Empty data\nBook a lesson to get started',
                          style: context.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
      ),
    );
  }
}

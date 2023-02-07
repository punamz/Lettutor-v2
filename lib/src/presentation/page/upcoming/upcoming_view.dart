import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/custom_widget/listview_loadmore.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:lettutor/src/presentation/page/upcoming/upcoming_ctrl.dart';

import 'child_widget/booking_card_widget.dart';

class UpcomingView extends GetView<UpcomingController> {
  static const String routeName = '/UpcomingView';
  const UpcomingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming')),
      body: Obx(
        () => controller.isGettingData.value
            ? const Center(child: LoadingWidget())
            : RefreshIndicator(
                onRefresh: controller.refreshData,
                child: Obx(
                  () => controller.bookings.isNotEmpty
                      ? Obx(
                          () => ListViewLoadMoreWidget(
                            itemCount: controller.bookings.length,
                            itemBuilder: (context, index) => BookingCardWidget(
                              booking: controller.bookings[index],
                              onCancel: () => controller.cancelBooking(controller.bookings[index]),
                            ),
                            funcLoadMore: controller.loadMoreBooking,
                            showLoading: controller.isLoadingMore.stream,
                            canLoadMore: controller.canLoadMore.stream,
                            physics: const AlwaysScrollableScrollPhysics(),
                          ),
                        )
                      : Stack(
                          children: [
                            ListView(),
                            Center(
                              child: Text(
                                'Empty data\nBook a lesson to get started',
                                style: context.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
      ),
    );
  }
}

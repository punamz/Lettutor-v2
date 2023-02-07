import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/custom_widget/listview_loadmore.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:lettutor/src/presentation/page/booking_history/booking_history_ctrl.dart';
import 'package:lettutor/src/presentation/page/booking_history/child_widget/booking_card_widget.dart';

class BookingHistoryView extends GetView<BookingHistoryController> {
  static const String routeName = '/BookingHistoryView';
  const BookingHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking history')),
      body: Obx(
        () => controller.isGettingData.value
            ? const Center(child: LoadingWidget())
            : Obx(
                () => controller.bookings.isNotEmpty
                    ? Obx(
                        () => ListViewLoadMoreWidget(
                          itemCount: controller.bookings.length,
                          itemBuilder: (context, index) =>
                              BookingCardWidget(booking: controller.bookings[index]),
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

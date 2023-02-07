import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/domain/model/booking.dart';
import 'package:lettutor/src/domain/service/home_service.dart';

class UpcomingController extends GetxController {
  int page = 1;
  final RxBool isGettingData = true.obs;
  final RxList<Booking> bookings = <Booking>[].obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool canLoadMore = true.obs;

  @override
  void onInit() {
    _getBookingList(page);
    super.onInit();
  }

  Future<void> _getBookingList(int page) async {
    final HomeService homeService = Get.find();
    Either<String, List<Booking>> res =
        await homeService.getBookedClass(isComing: true, page: page);
    res.fold(
      (l) => {canLoadMore.value = false},
      (r) => {
        if (r.isEmpty) canLoadMore.value = false,
        bookings.addAll(r),
      },
    );
    isGettingData.value = false;
  }

  Future<void> refreshData() async {
    page = 1;
    isGettingData.value = true;
    bookings.clear();
    isLoadingMore.value = false;
    canLoadMore.value = true;
    _getBookingList(page);
  }

  Future<void> loadMoreBooking() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    await _getBookingList(++page);
    isLoadingMore.value = false;
  }

  Future<void> cancelBooking(Booking booking) async {
    final HomeService homeService = Get.find();
    Either<String, bool> res = await homeService.cancelBookingClass(booking.scheduleId ?? '');
    res.fold(
      (l) => {
        Util.showSnackBar(
          l,
          backgroundColor: Get.theme.colorScheme.error,
          textColor: Get.theme.colorScheme.onError,
        )
      },
      (r) => {
        Util.showSnackBar(
          'Canceled',
          backgroundColor: Get.theme.colorScheme.primary,
          textColor: Get.theme.colorScheme.onPrimary,
        ),
        bookings.remove(booking)
      },
    );
  }
}

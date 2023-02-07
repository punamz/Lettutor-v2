import 'package:get/get.dart';
import 'package:lettutor/src/domain/model/booking.dart';
import 'package:lettutor/src/domain/service/home_service.dart';

class BookingHistoryController extends GetxController {
  int page = 1;
  final RxBool isLoadingMore = false.obs;
  final RxBool canLoadMore = true.obs;

  final RxBool isGettingData = true.obs;
  final RxList<Booking> bookings = <Booking>[].obs;
  @override
  void onInit() {
    _getBookingList(page);
    super.onInit();
  }

  Future<void> _getBookingList(int page) async {
    final HomeService homeService = Get.find();
    var res = await homeService.getBookedClass(isComing: false, page: page);
    res.fold(
      (l) => {canLoadMore.value = false},
      (r) => {
        if (r.isEmpty) canLoadMore.value = false,
        bookings.addAll(r),
      },
    );

    isGettingData.value = false;
  }

  Future<void> loadMoreBooking() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    await _getBookingList(++page);
    isLoadingMore.value = false;
  }
}

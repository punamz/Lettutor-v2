import 'package:get/get.dart';
import 'package:lettutor/src/domain/model/booking.dart';

class SessionHistoryController extends GetxController {
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
    await Future.delayed(const Duration(seconds: 2));
    bookings.add(Booking(
      date: DateTime.now().subtract(const Duration(days: 1)),
      time: ' 00:00 - 01:00',
      tutorName: 'Nam $page nè',
      tutorAvatar:
          'https://afamilycdn.com/150157425591193600/2022/5/4/thanh-meme-vua-khoc-vua-cuoi-gay-bao-nam-nao-nay-da-vao-lop-1-68195c-1651655554182262053422.jpg',
    ));
    isGettingData.value = false;
  }

  Future<void> loadMoreBooking() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    await _getBookingList(++page);
    isLoadingMore.value = false;
  }
}

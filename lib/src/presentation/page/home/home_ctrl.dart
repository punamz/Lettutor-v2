import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/domain/model/booking.dart';
import 'package:lettutor/src/domain/model/tutor.dart';
import 'package:lettutor/src/domain/service/home_service.dart';

class HomeController extends GetxController {
  final RxBool isGettingNextLesson = true.obs;
  final RxBool isGettingFavoriteTutor = true.obs;

  final RxList<Tutor> favoriteTutor = <Tutor>[].obs;
  final Rxn<Booking> nextLesson = Rxn<Booking>();

  @override
  void onInit() {
    _getNextLesson();
    _getFavoriteTutor();
    super.onInit();
  }

  Future _getNextLesson() async {
    final HomeService homeService = Get.find();
    Either<String, List<Booking>> res =
        await homeService.getBookedClass(isComing: true, perPage: 1);
    res.fold((l) => {}, (r) => {if (r.isNotEmpty) nextLesson.value = r.first});
    isGettingNextLesson.toggle();
  }

  Future _getFavoriteTutor() async {
    final HomeService homeService = Get.find();
    var res = await homeService.getAllTutor(isFavorite: true);
    res.fold((l) => {}, (r) => {favoriteTutor.addAll(r)});
    isGettingFavoriteTutor.toggle();
  }

  Future<void> refreshData() async {
    nextLesson.value = null;
    favoriteTutor.clear();
    isGettingNextLesson.value = true;
    isGettingFavoriteTutor.value = true;
    _getNextLesson();
    _getFavoriteTutor();
  }

  Future<void> likeTutor(Tutor tutor) async {
    final HomeService homeService = Get.find();
    await homeService.addTutorToFavoriteList(tutor.userId ?? '');
  }
}

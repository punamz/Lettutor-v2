import 'package:get/get.dart';
import 'package:lettutor/src/domain/model/course.dart';
import 'package:lettutor/src/domain/service/home_service.dart';

class CourseController extends GetxController {
  final RxBool isGettingData = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool canLoadMore = true.obs;
  final RxList<Course> courses = <Course>[].obs;
  int page = 1;
  int perPage = 10;

  @override
  void onInit() {
    _getCourse(page);
    super.onInit();
  }

  Future<void> _getCourse(int page) async {
    final HomeService homeService = Get.find();
    var res = await homeService.getAllCourses(page: page);
    res.fold(
      (l) => {canLoadMore.value = false},
      (r) => {
        if (r.isEmpty) canLoadMore.value = false,
        courses.addAll(r),
      },
    );
    isGettingData.value = false;
  }

  Future loadMoreCourse() async {
    if (isLoadingMore.value) return;
    isLoadingMore.toggle();
    await _getCourse(++page);
    isLoadingMore.toggle();
  }
}

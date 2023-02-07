import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/domain/model/schedule.dart';
import 'package:lettutor/src/domain/model/tutor.dart';
import 'package:lettutor/src/domain/service/home_service.dart';

class TutorDetailController extends GetxController {
  final Tutor tutor = Get.arguments;
  final RxBool isLike = true.obs;
  final RxBool isAnnoying = false.obs;
  final RxBool isFake = false.obs;
  final RxBool isInappropriate = false.obs;
  final TextEditingController reportController = TextEditingController();
  final List<Schedule> schedules = [];
  final noteController = TextEditingController();
  final RxBool isGotSchedule = true.obs;
  @override
  void dispose() {
    reportController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> getSchedule() async {
    final HomeService homeService = Get.find();
    var res = await homeService.getAllSchedule(tutor.userId ?? '');
    res.fold(
      (l) => {},
      (r) => {schedules.addAll(r)},
    );
    isGotSchedule.value = false;
  }

  Future<void> reportTutor() async {
    if (!isAnnoying.value ||
        !isFake.value ||
        !isInappropriate.value ||
        reportController.text.isEmpty) {
      Util.showSnackBar(
        "Please help us understand what's happening",
        title: 'Report Tutor',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      return;
    }
    Util.showLoading();
    String content = '';
    if (isAnnoying.value) content += 'This tutor is annoying me\n';
    if (isFake.value) content += 'This profile is pretending be someone or is fake\n';
    if (isInappropriate.value) content += 'Inappropriate profile photo\n';
    content += reportController.text;
    final HomeService homeService = Get.find();
    var res = await homeService.reportTutor(tutor.userId ?? '', content);
    res.fold(
      (l) => {
        Util.hideLoading(),
        Util.showSnackBar(
          l,
          title: 'Report Tutor',
          backgroundColor: Get.theme.colorScheme.error,
          textColor: Get.theme.colorScheme.onError,
        ),
      },
      (r) => {
        Util.hideLoading(),
        Get.back(), //back to close dialog
        Util.showSnackBar(
          r,
          title: 'Report Tutor',
          backgroundColor: Get.theme.colorScheme.primary,
          textColor: Get.theme.colorScheme.onPrimary,
        ),
      },
    );
  }

  Future<void> bookSchedule(Schedule schedule) async {
    Util.showLoading();
    final HomeService homeService = Get.find();
    Either<String, String> res = await homeService.bookAClass(
        scheduleDetailId: schedule.id ?? '', note: noteController.text);
    res.fold(
      (l) => {
        Util.hideLoading(),
        Util.showSnackBar(
          l,
          title: 'Booking a class',
          backgroundColor: Get.theme.colorScheme.error,
          textColor: Get.theme.colorScheme.onError,
        ),
      },
      (r) => {
        Util.hideLoading(),
        Util.showSnackBar(
          r,
          title: 'Booking a class',
          backgroundColor: Get.theme.colorScheme.primary,
          textColor: Get.theme.colorScheme.onPrimary,
        ),
      },
    );
  }

  Future<void> likeTutor() async {
    final HomeService homeService = Get.find();
    homeService.addTutorToFavoriteList(tutor.userId ?? '');
    isLike.toggle();
  }
}

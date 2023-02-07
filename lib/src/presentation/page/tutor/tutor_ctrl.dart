import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/enum_value.dart';
import 'package:lettutor/src/domain/model/tutor.dart';
import 'package:lettutor/src/domain/service/home_service.dart';

class TutorController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final Rx<Specialty> specialty = Specialty.all.obs;
  final RxBool isGettingData = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool canLoadMore = true.obs;
  final RxList<Tutor> tutors = <Tutor>[].obs;
  int page = 1;
  Timer? _debounce;
  @override
  void onInit() {
    debounce(specialty, (callback) => _getTutor(page), time: const Duration(milliseconds: 500));

    _getTutor(page);
    super.onInit();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future _getTutor(int page) async {
    final HomeService homeService = Get.find();
    var res = await homeService.searchTutor(
      name: searchController.text,
      specialties: specialty.value,
      page: page,
    );
    res.fold(
      (l) => {canLoadMore.value = false},
      (r) => {
        if (r.isEmpty) canLoadMore.value = false,
        tutors.addAll(r),
      },
    );
    isGettingData.value = false;
  }

  Future<void> refreshData() async {
    page = 1;
    isGettingData.value = true;
    isLoadingMore.value = false;
    canLoadMore.value = true;
    tutors.clear();
    _getTutor(page);
  }

  Future loadMoreTutor() async {
    if (isLoadingMore.value) return;
    isLoadingMore.toggle();
    await _getTutor(++page);
    isLoadingMore.toggle();
  }

  void _resetData() {
    tutors.clear();
    isGettingData.value = true;
    canLoadMore.value = true;
    page = 1;
  }

  void selectSpecialty(Specialty spec) {
    _resetData();
    specialty.value = spec;
  }

  void onSearchChange(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _resetData();
      _getTutor(page);
    });
  }
}

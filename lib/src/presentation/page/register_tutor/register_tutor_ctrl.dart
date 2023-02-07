import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/config/enum_value.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/domain/service/home_service.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';

class RegisterTutorController extends GetxController {
  RxInt step = 0.obs;

  final Rx<StepState> profileStepState = StepState.editing.obs;
  final Rx<StepState> introductionStepState = StepState.indexed.obs;
  final Rx<StepState> approvalStepState = StepState.indexed.obs;

  final TextEditingController interestController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController introductionController = TextEditingController();
  final RxList<String?> languagesSelected = <String?>[].obs;
  final RxList<Specialty?> specialtiesSelected = <Specialty?>[].obs;
  final Rxn<Level> levelSelected = Rxn<Level>(null);
  final Rxn<XFile> videoSelected = Rxn<XFile>(null);

  void handleProfile() {
    /// check valid
    if (interestController.text.trim().isEmpty) {
      Util.showSnackBar(
        'Please enter your interests',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      profileStepState.value = StepState.error;
      return;
    }
    if (educationController.text.trim().isEmpty) {
      Util.showSnackBar(
        'Please enter your education',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      profileStepState.value = StepState.error;
      return;
    }
    if (experienceController.text.trim().isEmpty) {
      Util.showSnackBar(
        'Please enter your experience',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      profileStepState.value = StepState.error;
      return;
    }
    if (professionController.text.trim().isEmpty) {
      Util.showSnackBar(
        'Please enter your professional',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      profileStepState.value = StepState.error;
      return;
    }

    if (languagesSelected.isEmpty) {
      Util.showSnackBar(
        'Please enter your professional',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      profileStepState.value = StepState.error;
      return;
    }
    if (introductionController.text.trim().isEmpty) {
      Util.showSnackBar(
        'Please enter your bio',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      profileStepState.value = StepState.error;
      return;
    }
    if (levelSelected.value == null) {
      Util.showSnackBar(
        'Please select your target student',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      profileStepState.value = StepState.error;
      return;
    }
    if (specialtiesSelected.isEmpty) {
      Util.showSnackBar(
        'Please select your specialty',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      profileStepState.value = StepState.error;
      return;
    }

    profileStepState.value = StepState.complete;
    introductionStepState.value = StepState.editing;
    ++step;
  }

  Future<void> submit() async {
    /// check valid
    if (videoSelected.value == null) {
      Util.showSnackBar(
        'Please select one introduction video',
        backgroundColor: Get.theme.colorScheme.tertiary,
        textColor: Get.theme.colorScheme.onTertiary,
      );
      introductionStepState.value = StepState.error;
      return;
    }

    Util.showLoading();

    final Map<String, dynamic> param = {
      'name': Storage.instance.readString(Constant.fullName),
      'country': Storage.instance.readString(Constant.country),
      'birthday': (DateTime.tryParse(Storage.instance.readString(Constant.dayOfBirth)) ??
          DateTime.utc(2000)),
      'interests': interestController.text.trim(),
      'education': educationController.text.trim(),
      'experience': experienceController.text.trim(),
      'profession': professionController.text.trim(),
      'languages': languagesSelected.join(', '),
      'bio': introductionController.text.trim(),
      'targetStudent': levelSelected.value?.value,
      'specialties': specialtiesSelected.map((element) => element!.value).join(','),
    };
    final HomeService homeService = Get.find();
    final res = await homeService.registerTutor(
      param,
      videoSelected.value!.path,
      videoSelected.value?.name,
    );
    Util.hideLoading();
    res.fold(
      (l) => {
        Util.showSnackBar(
          l,
          backgroundColor: Get.theme.colorScheme.error,
          textColor: Get.theme.colorScheme.onError,
        )
      },
      (r) => {
        introductionStepState.value = StepState.complete,
        approvalStepState.value = StepState.complete,
        ++step,
      },
    );
  }
}

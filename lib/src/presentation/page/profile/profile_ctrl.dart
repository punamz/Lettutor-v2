import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/config/enum_value.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/config/raw_data.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/domain/service/authentication_service.dart';
import 'package:lettutor/src/domain/service/home_service.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';

class ProfileController extends GetxController {
  final RxnString country = RxnString(null);
  final Rxn<Level> level = Rxn<Level>(null);
  String email = Storage.instance.readString(Constant.email);
  RxString avatar = Storage.instance.readString(Constant.avatar).obs;

  Rx<DateTime> dayOfBirth =
      (DateTime.tryParse(Storage.instance.readString(Constant.dayOfBirth)) ?? DateTime.utc(2000))
          .obs;

  final TextEditingController nameController =
      TextEditingController(text: Storage.instance.readString(Constant.fullName));
  final TextEditingController phoneController =
      TextEditingController(text: Storage.instance.readString(Constant.soDT));

  @override
  void onInit() {
    String dbCountry = Storage.instance.readString(Constant.country).toLowerCase();
    country.value =
        dbCountry.isNotEmpty && countriesCode.map((e) => e.toLowerCase()).contains(dbCountry)
            ? countriesCode.firstWhere((element) => element.toLowerCase() == dbCountry)
            : null;
    String dbLevel = Storage.instance.readString(Constant.level).toLowerCase();
    level.value =
        dbLevel.isNotEmpty && Level.values.map((e) => e.value.toLowerCase()).contains(dbLevel)
            ? Level.values.firstWhere((element) => element.value.toLowerCase() == dbLevel)
            : null;
    super.onInit();
  }

  void _saveDataToLocal() {
    Storage.instance.writeString(Constant.soDT, phoneController.text);
    Storage.instance.writeString(Constant.fullName, nameController.text);
    Storage.instance.writeString(Constant.dayOfBirth, dayOfBirth.value.toIso8601String());
    Storage.instance.writeString(Constant.country, country.value);
    Storage.instance.writeString(Constant.level, level.value?.value);
  }

  void _saveAvatar(String avatar) {
    Storage.instance.writeString(Constant.avatar, avatar);
  }

  Future<void> changeAvatar(XFile file) async {
    Util.showLoading();
    final HomeService homeService = Get.find();

    Either<String, String> res = await homeService.uploadAvatar(file.path, file.name);
    res.fold(
      (l) => {
        Util.hideLoading(),
        Util.showSnackBar(
          l,
          backgroundColor: Get.theme.colorScheme.error,
          textColor: Get.theme.colorScheme.onError,
        ),
      },
      (r) => {
        _saveAvatar(r),
        avatar.value = r,
        Util.hideLoading(),
      },
    );
  }

  Future<void> updateInfo() async {
    Util.showLoading();
    Map<String, dynamic> param = {
      'name': nameController.text,
      'country': country.value,
      'phone': phoneController.text,
      'birthday': dayOfBirth.value.format('yyyy-MM-dd'),
      'level': level.value?.value,
    };
    final AuthenticationService authenticationService = Get.find();
    Either<String, bool> res = await authenticationService.updateProfile(param);
    res.fold(
      (l) => {
        Util.hideLoading(),
        Util.showSnackBar(
          l,
          backgroundColor: Get.theme.colorScheme.error,
          textColor: Get.theme.colorScheme.onError,
        ),
      },
      (r) => {
        _saveDataToLocal(),
        Util.hideLoading(),
        Util.showSnackBar(
          'Updated',
          backgroundColor: Get.theme.colorScheme.primary,
          textColor: Get.theme.colorScheme.onPrimary,
        ),
      },
    );
  }
}

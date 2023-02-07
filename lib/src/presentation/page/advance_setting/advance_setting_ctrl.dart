import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';

class AdvanceSettingController extends GetxController {
  RxString theme = Constant.systemTheme.obs;
  @override
  void onInit() {
    var themeSaved = Storage.instance.readString(Constant.theme);
    if (themeSaved.isNotEmpty) theme.value = themeSaved;
    super.onInit();
  }

  void changeTheme(String newTheme) {
    if (theme.value != newTheme) {
      theme.value = newTheme;
      Storage.instance.writeString(Constant.theme, newTheme);
      ThemeMode themeMode = newTheme == Constant.lightTheme
          ? ThemeMode.light
          : newTheme == Constant.darkTheme
              ? ThemeMode.dark
              : ThemeMode.system;
      Get.changeThemeMode(themeMode);
    }
  }
}

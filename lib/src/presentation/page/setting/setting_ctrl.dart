import 'package:get/get.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';

class SettingController extends GetxController {
  void clearLocalData() {
    Storage.instance.removeKey(Constant.avatar);
    Storage.instance.removeKey(Constant.jwtToken);
    Storage.instance.removeKey(Constant.fullName);
    Storage.instance.removeKey(Constant.email);
    Storage.instance.removeKey(Constant.soDT);
    Storage.instance.removeKey(Constant.userId);
    Storage.instance.removeKey(Constant.dayOfBirth);
    Storage.instance.removeKey(Constant.country);
    Storage.instance.removeKey(Constant.level);
  }
}

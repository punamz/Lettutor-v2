import 'package:get/get.dart';
import 'package:lettutor/src/domain/service/authentication_service.dart';
import 'package:lettutor/src/domain/service/home_service.dart';
import 'package:lettutor/src/infrastructure/repository/authentication_repository.dart';
import 'package:lettutor/src/infrastructure/repository/home_repository.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationService>(() => AuthenticationRepository(), fenix: true);
    Get.lazyPut<HomeService>(() => HomeRepository(), fenix: true);
  }
}

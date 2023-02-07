import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/core/global_binding.dart';
import 'package:lettutor/core/routers.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';
import 'package:lettutor/src/presentation/page/landing/landing_view.dart';
import 'package:lettutor/src/presentation/page/login/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Storage.getInstance(storeName: Constant.appName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  ThemeMode get themeMode {
    String theme = Storage.instance.readString(Constant.theme);
    switch (theme) {
      case Constant.lightTheme:
        return ThemeMode.light;
      case Constant.darkTheme:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String get initRouter {
    String userId = Storage.instance.readString(Constant.userId);
    return userId.isEmpty ? LoginView.routeName : LandingView.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constant.appName,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      getPages: routers,
      initialBinding: GlobalBinding(),
      initialRoute: initRouter,
    );
  }
}

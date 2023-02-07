import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lettutor/src/presentation/page/course/course_view.dart';
import 'package:lettutor/src/presentation/page/home/home_view.dart';
import 'package:lettutor/src/presentation/page/landing/landing_ctrl.dart';
import 'package:lettutor/src/presentation/page/setting/setting_view.dart';
import 'package:lettutor/src/presentation/page/tutor/tutor_view.dart';
import 'package:lettutor/src/presentation/page/upcoming/upcoming_view.dart';

class LandingView extends GetView<LandingController> {
  static const String routeName = '/HomeView';
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: const [
              HomeView(),
              UpcomingView(),
              TutorView(),
              CourseView(),
              SettingView(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.pageIndex.value,
            onDestinationSelected: (int index) => controller.pageIndex.value = index,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.access_time_rounded), label: 'Upcoming'),
              NavigationDestination(icon: Icon(Icons.people_alt_rounded), label: 'Tutor'),
              NavigationDestination(icon: Icon(Icons.book_rounded), label: 'Course'),
              NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Setting'),
            ],
          ),
        ),
      ),
    );
  }
}

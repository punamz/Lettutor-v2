import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';
import 'package:lettutor/src/presentation/page/home/child_widget/favorite_tutor_widget.dart';
import 'package:lettutor/src/presentation/page/home/child_widget/next_lesson_widget.dart';
import 'package:lettutor/src/presentation/page/home/home_ctrl.dart';
import 'package:lettutor/src/presentation/page/landing/landing_ctrl.dart';
import 'package:lettutor/src/presentation/page/profile/profile_view.dart';

class HomeView extends GetView<HomeController> {
  static const String routeName = '/HomeView';
  const HomeView({Key? key}) : super(key: key);

  void _onPressProfileBtn() {
    Get.toNamed(ProfileView.routeName);
  }

  void _onPressSeeAllButton() {
    // this is trick
    LandingController landingController = Get.find();
    landingController.pageIndex.value = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: _onPressProfileBtn,
              child: Storage.instance.readString(Constant.avatar).isEmpty
                  ? const Icon(Icons.account_circle_rounded, size: 30)
                  : Center(
                      child: AvatarWidget(
                        size: 30,
                        imageUrl: Storage.instance.readString(Constant.avatar),
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: ListView(
          children: [
            const NextLessonWidget(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Tutors',
                    style: context.textTheme.titleMedium?.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  GestureDetector(
                    onTap: _onPressSeeAllButton,
                    child: Text('See All >',
                        style: context.textTheme
                            .apply(bodyColor: context.theme.colorScheme.primary)
                            .titleMedium),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const FavoriteTutorWidget(),
          ],
        ),
      ),
    );
  }
}

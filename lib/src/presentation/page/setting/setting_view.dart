import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/src/infrastructure/get_storage/local_database.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';
import 'package:lettutor/src/presentation/page/advance_setting/advance_setting_view.dart';
import 'package:lettutor/src/presentation/page/booking_history/booking_history_view.dart';
import 'package:lettutor/src/presentation/page/feedback/feedback_view.dart';
import 'package:lettutor/src/presentation/page/login/login_view.dart';
import 'package:lettutor/src/presentation/page/profile/profile_view.dart';
import 'package:lettutor/src/presentation/page/session_history/session_history_view.dart';
import 'package:lettutor/src/presentation/page/setting/setting_ctrl.dart';

class SettingView extends GetView<SettingController> {
  static const String routeName = '/SettingView';
  const SettingView({Key? key}) : super(key: key);

  void _onPressProfileBtn() => Get.toNamed(ProfileView.routeName);

  void _onPressFeedbackBtn() => Get.toNamed(FeedbackView.routeName);

  void _onPressBookingHistoryBtn() => Get.toNamed(BookingHistoryView.routeName);

  void _onPressSessionHistoryBtn() => Get.toNamed(SessionHistoryView.routeName);

  void _onPressAdvanceSettingBtn() => Get.toNamed(AdvanceSettingView.routeName);

  void _onPressWebsiteBtn() {}

  void _onPressFacebookBtn() {}

  void _onPressLogoutBtn() {
    controller.clearLocalData();
    Get.offAndToNamed(LoginView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _onPressProfileBtn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Storage.instance.readString(Constant.avatar).isEmpty
                      ? const Icon(Icons.account_circle_rounded, size: 70)
                      : AvatarWidget(
                          size: 70,
                          imageUrl: Storage.instance.readString(Constant.avatar),
                        ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Storage.instance.readString(Constant.fullName),
                          style: context.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(Storage.instance.readString(Constant.email))
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _onPressFeedbackBtn,
              child: Row(
                children: const [
                  Icon(Icons.person_outline),
                  SizedBox(width: 20),
                  Expanded(child: Text('View Feedbacks')),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onPressBookingHistoryBtn,
              child: Row(
                children: const [
                  Icon(Icons.list_outlined),
                  SizedBox(width: 20),
                  Expanded(child: Text('Booking History')),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onPressSessionHistoryBtn,
              child: Row(
                children: const [
                  Icon(Icons.restore_outlined),
                  SizedBox(width: 20),
                  Expanded(child: Text('Session History')),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onPressAdvanceSettingBtn,
              child: Row(
                children: const [
                  Icon(Icons.settings_outlined),
                  SizedBox(width: 20),
                  Expanded(child: Text('Advance settings')),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _onPressWebsiteBtn,
              child: Row(
                children: const [
                  Icon(Icons.language_outlined),
                  SizedBox(width: 20),
                  Expanded(child: Text('Our Website')),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onPressFacebookBtn,
              child: Row(
                children: const [
                  Icon(Icons.facebook_outlined),
                  SizedBox(width: 20),
                  Expanded(child: Text('Facebook')),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _onPressLogoutBtn,
              style: ElevatedButton.styleFrom(
                foregroundColor: context.theme.colorScheme.onError,
                backgroundColor: context.theme.colorScheme.error,
              ),
              child: const Text('Logout'),
            ),
            const SizedBox(height: 40),
            Text('Version 1.0', style: context.textTheme.labelSmall, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}

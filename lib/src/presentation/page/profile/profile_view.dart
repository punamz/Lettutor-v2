import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';
import 'package:lettutor/src/presentation/page/profile/child_widget/contry_selection_widget.dart';
import 'package:lettutor/src/presentation/page/profile/child_widget/level_selection_widget.dart';
import 'package:lettutor/src/presentation/page/profile/profile_ctrl.dart';
import 'package:lettutor/src/presentation/page/register_tutor/register_tutor_view.dart';

class ProfileView extends GetView<ProfileController> {
  static const String routeName = '/ProfileView';

  const ProfileView({Key? key}) : super(key: key);

  Future<void> _onPressChangeAvatar() async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      controller.changeAvatar(image);
    }
  }

  Future<void> _selectDate() async {
    DateTime? dayPicked = await showDatePicker(
      context: Get.context!,
      initialDate: controller.dayOfBirth.value,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (dayPicked != null) {
      controller.dayOfBirth.value = dayPicked;
    }
  }

  void _onPressSaveBtn() => controller.updateInfo();

  void _onPressBecomeATutorBtn() => Get.toNamed(RegisterTutorView.routeName);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: ListView(
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Center(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: context.theme.colorScheme.primary, width: 2),
                          ),
                        ),
                      ),
                      Center(
                        child: Obx(() => AvatarWidget(
                              imageUrl: controller.avatar.value,
                              size: 100,
                            )),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: _onPressChangeAvatar,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              color: context.theme.colorScheme.secondaryContainer,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20,
                                  color: context.theme.colorScheme.onSecondaryContainer,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TextField(
                controller: controller.nameController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  border: InputBorder.none,
                  hintText: 'Name',
                ),
              ),
              Text(controller.email, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Text('Birthday', style: context.textTheme.titleMedium),
              GestureDetector(
                onTap: _selectDate,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: context.theme.colorScheme.secondary),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13),
                    child: Obx(() => Text(controller.dayOfBirth.value.format('yyyy-MM-dd'))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Phone number', style: context.textTheme.titleMedium),
              TextField(
                keyboardType: TextInputType.phone,
                controller: controller.phoneController,
                style: context.textTheme.bodyMedium,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 13),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  hintText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 20),
              Text('Country', style: context.textTheme.titleMedium),
              const CountrySelectionWidget(),
              const SizedBox(height: 20),
              Text('My level', style: context.textTheme.titleMedium),
              const LevelSelectionWidget(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _onPressSaveBtn,
                style: ElevatedButton.styleFrom(
                  foregroundColor: context.theme.colorScheme.onPrimary,
                  backgroundColor: context.theme.colorScheme.primary,
                ),
                child: const Text('Save'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onPressBecomeATutorBtn,
                child: const Text('Become a tutor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:lettutor/config/enum_value.dart';
import 'package:lettutor/config/image_assets.dart';
import 'package:lettutor/config/raw_data.dart';
import 'package:lettutor/src/presentation/page/register_tutor/child_widget/custom_text_field_widget.dart';
import 'package:lettutor/src/presentation/page/register_tutor/register_tutor_ctrl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CompleteProfileWidget extends GetView<RegisterTutorController> {
  const CompleteProfileWidget({Key? key}) : super(key: key);

  // todo: select avatar;
  void _onSelectAvatar() {}
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ImageAssets.profile, width: 75, fit: BoxFit.cover),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set up your tutor profile',
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Your tutor profile is your chance to market yourself to students on Tutoring.'
                      ' You can make edits later on your profile settings page.',
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text('CV', style: context.textTheme.titleLarge),
                const Expanded(child: Divider()),
              ],
            ),
          ),
          const SizedBox(height: 5),
          const Text("Students will view this information on your profile to decide "
              "if you're a good fit for them."),
          const SizedBox(height: 10),
          CustomTextFieldWidget(
            label: 'Interests',
            controller: controller.interestController,
            hintText: "Interests, hobbies, memorable life experiences,"
                " or anything else you'd like to share!",
            height: 90,
          ),
          const SizedBox(height: 10),
          CustomTextFieldWidget(
            label: 'Education',
            controller: controller.educationController,
            hintText: 'Example: "Bachelor of Arts in English from Cambly University; '
                'Certified yoga instructor, Second Language Acquisition and Teaching (SLAT) certificate '
                'from Cambly University"',
            height: 90,
          ),
          const SizedBox(height: 10),
          CustomTextFieldWidget(
            label: 'Experience',
            controller: controller.experienceController,
            height: 90,
          ),
          const SizedBox(height: 10),
          CustomTextFieldWidget(
            label: 'Profession',
            controller: controller.professionController,
            height: 90,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text('Languages I speak', style: context.textTheme.titleLarge),
                const Expanded(child: Divider()),
              ],
            ),
          ),
          Obx(() => MultiSelectBottomSheetField<String?>(
                initialChildSize: 0.7,
                maxChildSize: 0.95,
                buttonText: const Text("Languages"),
                title: const Text("Languages"),
                searchable: true,
                items: languages.map((e) => MultiSelectItem(e, e)).toList(),
                onConfirm: (values) => controller.languagesSelected.value = values,
                chipDisplay: MultiSelectChipDisplay(
                  items: controller.languagesSelected.map((e) => MultiSelectItem(e, e!)).toList(),
                  chipColor: context.theme.colorScheme.primaryContainer,
                  textStyle: TextStyle(color: context.theme.colorScheme.onPrimaryContainer),
                  onTap: (item) => controller.languagesSelected.remove(item),
                ),
              )),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text('Who I teach', style: context.textTheme.titleLarge),
                const Expanded(child: Divider()),
              ],
            ),
          ),
          CustomTextFieldWidget(
            label: 'Introduction',
            controller: controller.introductionController,
            hintText: 'Example: "I was a doctor for 35 years and can help you practice business or '
                'medical English. I also enjoy teaching beginners as I am very patient and '
                'always speak slowly and clearly."',
            height: 90,
          ),
          const SizedBox(height: 10),
          Text('I am best at teaching students who are', style: context.textTheme.titleMedium),
          ...List.generate(
            Level.values.length,
            (index) => Row(
              children: [
                Obx(() => Radio<Level>(
                      value: Level.values[index],
                      groupValue: controller.levelSelected.value,
                      onChanged: (value) => controller.levelSelected.value = value,
                    )),
                Text(Level.values[index].value),
              ],
            ),
          ),
          Obx(() => MultiSelectBottomSheetField<Specialty?>(
                initialChildSize: 0.7,
                maxChildSize: 0.95,
                buttonText: const Text("My specialties are"),
                searchable: true,
                title: const Text('Specialties'),
                items: Specialty.values.map((e) => MultiSelectItem(e, e.description)).toList(),
                onConfirm: (values) => controller.specialtiesSelected.value = values,
                chipDisplay: MultiSelectChipDisplay(
                  items: controller.specialtiesSelected
                      .map((e) => MultiSelectItem(e, e!.description))
                      .toList(),
                  chipColor: context.theme.colorScheme.primaryContainer,
                  textStyle: TextStyle(color: context.theme.colorScheme.onPrimaryContainer),
                  onTap: (item) => controller.specialtiesSelected.remove(item),
                ),
              )),
        ],
      ),
    );
  }
}

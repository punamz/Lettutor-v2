import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/enum_value.dart';
import 'package:lettutor/src/presentation/page/profile/profile_ctrl.dart';

class LevelSelectionWidget extends GetView<ProfileController> {
  const LevelSelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colorScheme.secondary),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Obx(
            () => DropdownButton<Level>(
                underline: const SizedBox.shrink(),
                isExpanded: true,
                value: controller.level.value,
                hint: Text('Please select your level',
                    style: context.textTheme
                        .apply(bodyColor: context.theme.colorScheme.onSurfaceVariant)
                        .bodyMedium),
                onChanged: (newValue) {
                  controller.level.value = newValue;
                },
                items: Level.values
                    .map((level) => DropdownMenuItem<Level>(
                          value: level,
                          child: Text(level.value, style: context.textTheme.bodyMedium),
                        ))
                    .toList()),
          )),
    );
  }
}

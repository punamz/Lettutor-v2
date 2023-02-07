import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/raw_data.dart';
import 'package:lettutor/src/presentation/page/profile/profile_ctrl.dart';

class CountrySelectionWidget extends GetView<ProfileController> {
  const CountrySelectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: context.theme.colorScheme.secondary),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Obx(() => DropdownButton<String>(
              underline: const SizedBox.shrink(),
              isExpanded: true,
              value: controller.country.value,
              hint: Text(
                'Please select your country',
                style: context.textTheme
                    .apply(bodyColor: context.theme.colorScheme.onSurfaceVariant)
                    .bodyMedium,
              ),
              onChanged: (newValue) => controller.country.value = newValue,
              items: List.generate(
                countriesCode.length,
                (index) => DropdownMenuItem<String>(
                  value: countriesCode[index],
                  child: Text(
                    '${countriesName[index]} (${countriesCode[index]})',
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

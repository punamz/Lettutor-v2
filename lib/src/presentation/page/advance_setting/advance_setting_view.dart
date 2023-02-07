import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/constant.dart';
import 'package:lettutor/src/presentation/page/advance_setting/advance_setting_ctrl.dart';

class AdvanceSettingView extends GetView<AdvanceSettingController> {
  static const String routeName = '/AdvanceSettingView';
  const AdvanceSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advance setting')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              children: [
                Expanded(child: Text('App theme', style: context.textTheme.titleMedium)),
                Obx(() => DropdownButton<String>(
                      underline: const SizedBox.shrink(),
                      value: controller.theme.value,
                      items: [Constant.lightTheme, Constant.darkTheme, Constant.systemTheme]
                          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) controller.changeTheme(value);
                      },
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

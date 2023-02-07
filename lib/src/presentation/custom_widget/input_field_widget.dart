import 'package:flutter/material.dart';
import 'package:lettutor/src/presentation/custom_widget/custom_text_field.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final String? errorText;
  final bool isPassword;
  const InputFieldWidget({
    Key? key,
    required this.controller,
    required this.title,
    this.isPassword = false,
    this.hintText,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 5),
        CustomTextField(
          controller: controller,
          errorText: errorText,
          isPassword: isPassword,
          hintText: hintText,
        ),
      ],
    );
  }
}

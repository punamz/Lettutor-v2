import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String label;
  final String? hintText;
  final double height;
  final TextEditingController controller;
  const CustomTextFieldWidget(
      {Key? key,
      required this.label,
      required this.controller,
      this.hintText,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.titleMedium),
        SizedBox(
          height: height,
          child: TextField(
            controller: controller,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14),
              hintMaxLines: 4,
              hintText: hintText,
              hintStyle:
                  context.textTheme.apply(bodyColor: context.theme.colorScheme.outline).bodyMedium,
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        )
      ],
    );
  }
}

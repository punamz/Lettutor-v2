import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButtonWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPress;

  const ActionButtonWidget({
    Key? key,
    required this.icon,
    required this.onPress,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          Icon(icon),
          Text(
            label,
            style: context.textTheme.apply(bodyColor: context.theme.colorScheme.primary).labelLarge,
          ),
        ],
      ),
    );
  }
}

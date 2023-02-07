import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomWrap extends StatelessWidget {
  final List<String> labels;
  const CustomWrap({Key? key, required this.labels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 5,
      children: List<Widget>.generate(
        labels.length,
        (index) => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: context.theme.colorScheme.secondaryContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              labels[index],
              textAlign: TextAlign.center,
              style: context.textTheme
                  .apply(bodyColor: context.theme.colorScheme.onSecondaryContainer)
                  .labelMedium,
            ),
          ),
        ),
      ),
    );
  }
}

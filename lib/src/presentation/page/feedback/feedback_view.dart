import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/page/feedback/feedback_ctrl.dart';

class FeedbackView extends GetView<FeedbackController> {
  static const String routeName = '/FeedbackView';
  const FeedbackView({Key? key}) : super(key: key);

  //todo: build feedbacks layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedbacks')),
    );
  }
}

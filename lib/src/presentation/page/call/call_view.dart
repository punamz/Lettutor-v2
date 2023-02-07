import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/page/call/call_ctrl.dart';
import 'package:lettutor/src/presentation/page/call/child_widget/time_count_down_widget.dart';
import 'package:lettutor/src/presentation/page/call/child_widget/video_call_widget.dart';

class CallView extends GetView<CallController> {
  static const String routeName = '/CallView';
  const CallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: const [
          Positioned.fill(child: VideoCallWidget()),
          Align(alignment: Alignment.center, child: TimeCountDownWidget())
        ],
      ),
    );
  }
}

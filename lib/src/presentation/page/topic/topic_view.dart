import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/domain/model/topic.dart';
import 'package:lettutor/src/presentation/page/topic/topic_ctrl.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TopicView extends GetView<TopicController> {
  static const String routeName = '/TopicView';
  const TopicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Topics')),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.topics.length,
              itemBuilder: (context, index) {
                final Topic topic = controller.topics[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Obx(
                    () => ChoiceChip(
                      label: Text(topic.name ?? ''),
                      selected: controller.currentTopic.value == topic,
                      onSelected: (value) {
                        if (value) controller.onSelectTopic(topic);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Obx(() {
            final String src = controller.currentTopic.value?.nameFile ?? '';
            return Expanded(child: SfPdfViewer.network(src));
          }),
        ],
      ),
    );
  }
}

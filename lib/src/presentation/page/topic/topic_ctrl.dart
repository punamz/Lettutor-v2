import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/src/domain/model/topic.dart';

class TopicController extends GetxController {
  final List<Topic> topics = Get.arguments;
  final Rxn<Topic> currentTopic = Rxn<Topic>();

  @override
  void onInit() {
    if (topics.isListNotNullOrEmpty()) currentTopic.value = topics.first;
    super.onInit();
  }

  void onSelectTopic(Topic topic) {
    currentTopic.value = topic;
  }
}

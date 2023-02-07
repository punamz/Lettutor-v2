import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/core/utils.dart';
import 'package:lettutor/src/presentation/page/course_detail/course_detail_ctrl.dart';
import 'package:lettutor/src/presentation/page/topic/topic_view.dart';

class CourseDetailView extends GetView<CourseDetailController> {
  static const String routeName = '/CourseDetailView';
  const CourseDetailView({Key? key}) : super(key: key);

  void _onPressDiscoverBtn() {
    if (controller.course.topics.isListNotNullOrEmpty()) {
      Get.toNamed(TopicView.routeName, arguments: controller.course.topics);
    } else {
      Util.showSnackBar('This course does not has topic right now');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ListView(
          children: [
            SizedBox(
              height: 250,
              child: ExtendedImage.network(
                controller.course.imageUrl ?? '',
                fit: BoxFit.cover,
                loadStateChanged: (state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.failed:
                      return const SizedBox.shrink();
                    default:
                      return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(controller.course.name ?? '', style: context.textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(controller.course.description ?? ''),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _onPressDiscoverBtn, child: const Text('Discover')),
            const SizedBox(height: 20),
            Text('OverView', style: context.textTheme.titleLarge),
            const SizedBox(height: 10),
            Row(children: [
              Icon(Icons.help_outline_outlined, color: context.theme.colorScheme.error, size: 20),
              const SizedBox(width: 5),
              Text('Why take this course', style: context.textTheme.titleMedium),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(controller.course.reason ?? ''),
            ),
            const SizedBox(height: 10),
            Row(children: [
              Icon(Icons.help_outline_outlined, color: context.theme.colorScheme.error, size: 20),
              const SizedBox(width: 5),
              Text('What will you be able to do', style: context.textTheme.titleMedium),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(controller.course.purpose ?? ''),
            ),
            const SizedBox(height: 20),
            Text('Experience level', style: context.textTheme.titleLarge),
            const SizedBox(height: 5),
            Row(children: [
              const SizedBox(width: 10),
              Icon(Icons.group_add_rounded, color: context.theme.colorScheme.primary, size: 20),
              const SizedBox(width: 5),
              Text('${controller.course.level}'),
            ]),
            const SizedBox(height: 20),
            Text('Course length', style: context.textTheme.titleLarge),
            const SizedBox(height: 5),
            Row(children: [
              const SizedBox(width: 10),
              Icon(Icons.book_rounded, color: context.theme.colorScheme.primary, size: 20),
              const SizedBox(width: 5),
              Text('${controller.course.level}'),
            ]),
            const SizedBox(height: 20),
            Text('List topic', style: context.textTheme.titleLarge),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  controller.course.topics?.length ?? 0,
                  (index) => Text('${index + 1}. ${controller.course.topics![index].name}'),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/custom_widget/listview_loadmore.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:lettutor/src/presentation/page/course/child_widget/course_card_widget.dart';
import 'package:lettutor/src/presentation/page/course/course_ctrl.dart';

class CourseView extends GetView<CourseController> {
  static const String routeName = '/CourseView';
  const CourseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course')),
      body: Obx(
        () => controller.isGettingData.value
            ? const Center(child: LoadingWidget())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Obx(
                  () => controller.courses.isNotEmpty
                      ? Obx(() => ListViewLoadMoreWidget(
                            itemCount: controller.courses.length,
                            itemBuilder: (context, index) =>
                                CourseCardWidget(course: controller.courses[index]),
                            funcLoadMore: controller.loadMoreCourse,
                            showLoading: controller.isLoadingMore.stream,
                            canLoadMore: controller.canLoadMore.stream,
                          ))
                      : Center(
                          child: Text(
                            'Empty data\nThere is no course right now',
                            style: context.textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
      ),
    );
  }
}

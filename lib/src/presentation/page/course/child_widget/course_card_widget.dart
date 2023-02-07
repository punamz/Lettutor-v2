import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/domain/model/course.dart';
import 'package:lettutor/src/presentation/page/course_detail/course_detail_view.dart';

class CourseCardWidget extends StatelessWidget {
  final Course course;
  const CourseCardWidget({Key? key, required this.course}) : super(key: key);
  void _onPressCourseCard() {
    Get.toNamed(CourseDetailView.routeName, arguments: course);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressCourseCard,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: ExtendedImage.network(
                  course.imageUrl ?? '',
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
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.name ?? '', style: context.textTheme.headlineSmall),
                  const SizedBox(height: 10),
                  Text(course.description ?? ''),
                  const SizedBox(height: 10),
                  Text('${course.topics?.length} Lesson', style: context.textTheme.titleMedium),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

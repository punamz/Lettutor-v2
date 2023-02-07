import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/src/domain/model/review.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';
import 'package:lettutor/src/presentation/custom_widget/star_rating_widget.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_ctrl.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewDialog extends GetView<TutorDetailController> {
  const ReviewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Others review'),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      content: controller.tutor.feedbacks.isListNotNullOrEmpty()
          ? SizedBox(
              height: context.height * 0.5,
              width: context.width,
              child: ListView.separated(
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Review review = controller.tutor.feedbacks![index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AvatarWidget(size: 40, imageUrl: review.avatar ?? ''),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(review.name ?? '', style: context.textTheme.titleMedium),
                                  const SizedBox(width: 10),
                                  Text(
                                    timeago.format(review.time ?? DateTime.now()),
                                    style: context.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              StarRatingWidget(size: 15, rating: review.rating?.toDouble()),
                              const SizedBox(height: 10),
                              Text(review.content ?? '')
                            ],
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: controller.tutor.feedbacks!.length),
            )
          : const Text('No reviews yet'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';
import 'package:lettutor/src/presentation/custom_widget/custom_wrap.dart';
import 'package:lettutor/src/presentation/custom_widget/video_widget.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/child_widget/action_button_widget.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/child_widget/booking_dialog.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/child_widget/report_dialog.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/child_widget/review_dialog.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_ctrl.dart';

class TutorDetailView extends GetView<TutorDetailController> {
  static const String routeName = '/TutorDetailView';
  const TutorDetailView({Key? key}) : super(key: key);

  void _onPressBookingBtn() {
    if (controller.isGotSchedule.value) controller.getSchedule();
    Get.dialog(const BookingDialog());
  }

  void _onPressLikeBtn() {
    controller.likeTutor();
  }

  void _onPressReportBtn() {
    Get.dialog(const ReportDialog());
  }

  void _onPressReviewBtn() {
    Get.dialog(const ReviewDialog());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: controller.tutor.isLike);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            if (controller.tutor.video != null)
              SizedBox(
                height: context.width * 0.5,
                child: VideoWidget(videoUrl: controller.tutor.video!),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        AvatarWidget(size: 100, imageUrl: controller.tutor.avatar ?? ''),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.tutor.name ?? '',
                                  style: context.textTheme.titleMedium),
                              const SizedBox(height: 5),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    if (controller.tutor.rating != null)
                                      TextSpan(text: controller.tutor.rating!.toStringAsFixed(1)),
                                    const WidgetSpan(
                                      child:
                                          Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              if (controller.tutor.country != null)
                                Image.asset(
                                  'icons/flags/png/${controller.tutor.country!.toLowerCase()}.png',
                                  package: 'country_icons',
                                  height: 12,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const SizedBox.shrink(),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: _onPressBookingBtn, child: const Text('Booking')),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() => ActionButtonWidget(
                              icon: controller.isLike.value
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              label: 'Favorite',
                              onPress: _onPressLikeBtn,
                            )),
                        ActionButtonWidget(
                          icon: Icons.report_gmailerrorred_rounded,
                          label: 'Report',
                          onPress: _onPressReportBtn,
                        ),
                        ActionButtonWidget(
                          icon: Icons.star_border_rounded,
                          label: 'Reviews',
                          onPress: _onPressReviewBtn,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(controller.tutor.bio ?? ''),
                    const SizedBox(height: 20),
                    Text('Languages', style: context.textTheme.titleMedium),
                    const SizedBox(height: 10),
                    CustomWrap(labels: controller.tutor.languages ?? []),
                    const SizedBox(height: 20),
                    Text('Specialties', style: context.textTheme.titleMedium),
                    const SizedBox(height: 10),
                    CustomWrap(labels: controller.tutor.specialties ?? []),
                    const SizedBox(height: 20),
                    Text('Interests', style: context.textTheme.titleMedium),
                    const SizedBox(height: 10),
                    Text(controller.tutor.interests ?? ''),
                    const SizedBox(height: 20),
                    Text('Teaching experience', style: context.textTheme.titleMedium),
                    const SizedBox(height: 10),
                    Text(controller.tutor.experience ?? ''),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

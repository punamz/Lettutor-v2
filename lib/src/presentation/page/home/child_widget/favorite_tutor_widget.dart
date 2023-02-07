import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:lettutor/src/presentation/page/home/child_widget/tutor_card_widget.dart';
import 'package:lettutor/src/presentation/page/home/home_ctrl.dart';

class FavoriteTutorWidget extends GetView<HomeController> {
  const FavoriteTutorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isGettingFavoriteTutor.value
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Obx(
                () => controller.favoriteTutor.isListNotNullOrEmpty()
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.favoriteTutor.length,
                        itemBuilder: (context, index) => TutorCardWidget(
                          onPressLikeBtn: () =>
                              controller.likeTutor(controller.favoriteTutor[index]),
                          tutor: controller.favoriteTutor[index],
                          onChangeFavorite: (value) {
                            controller.favoriteTutor[index].isLike = value;
                            controller.favoriteTutor.refresh();
                          },
                        ),
                      )
                    : Center(
                        child: Text(
                          'Oops!!!\nThere is no teacher right now',
                          style: context.textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
    );
  }
}

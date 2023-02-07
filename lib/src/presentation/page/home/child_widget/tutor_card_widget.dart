import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/domain/model/tutor.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';
import 'package:lettutor/src/presentation/custom_widget/custom_wrap.dart';
import 'package:lettutor/src/presentation/custom_widget/star_rating_widget.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_view.dart';

class TutorCardWidget extends StatelessWidget {
  final Tutor tutor;
  final void Function() onPressLikeBtn;
  final void Function(bool) onChangeFavorite;
  TutorCardWidget(
      {Key? key, required this.tutor, required this.onPressLikeBtn, required this.onChangeFavorite})
      : super(key: key) {
    _like.value = tutor.isLike ?? false;
  }

  final RxBool _like = true.obs;
  void _onPressLikeBtn() {
    _like.toggle();
    onPressLikeBtn.call();
  }

  Future<void> _onPressTutorCard() async {
    var result = await Get.toNamed(TutorDetailView.routeName, arguments: tutor);
    if (result != null) onChangeFavorite(result);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressTutorCard,
      child: Card(
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 6,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AvatarWidget(size: 50, imageUrl: tutor.avatar ?? ''),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tutor.name ?? '', style: context.textTheme.titleMedium),
                            StarRatingWidget(size: 15, rating: tutor.rating),
                            Expanded(
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: CustomWrap(labels: tutor.specialties ?? [])),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 10),
                            child: GestureDetector(
                              onTap: _onPressLikeBtn,
                              child: Obx(
                                () => _like.value
                                    ? const Icon(Icons.favorite, color: Colors.red, size: 24)
                                    : const Icon(Icons.favorite_border,
                                        color: Colors.red, size: 24),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Text(
                    tutor.bio ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/domain/model/tutor.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';
import 'package:lettutor/src/presentation/custom_widget/custom_wrap.dart';
import 'package:lettutor/src/presentation/page/tutor_detail/tutor_detail_view.dart';

class TutorCardWidget extends StatelessWidget {
  final Tutor tutor;

  const TutorCardWidget({Key? key, required this.tutor}) : super(key: key);

  void _onPressTutorCard() {
    Get.toNamed(TutorDetailView.routeName, arguments: tutor);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: GestureDetector(
        onTap: _onPressTutorCard,
        child: Card(
          child: SizedBox(
            height: 180,
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
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 10),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  if (tutor.rating != null)
                                    TextSpan(text: tutor.rating?.toStringAsFixed(1)),
                                  const WidgetSpan(
                                    child: Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                                  )
                                ],
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
      ),
    );
  }
}

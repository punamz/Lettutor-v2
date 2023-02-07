import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/config/extension.dart';
import 'package:lettutor/src/domain/model/booking.dart';
import 'package:lettutor/src/presentation/custom_widget/avatar_widget.dart';

class SessionCardWidget extends StatelessWidget {
  final Booking booking;
  const SessionCardWidget({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AvatarWidget(size: 50, imageUrl: booking.tutorAvatar ?? ''),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(booking.tutorName ?? '', style: context.textTheme.titleMedium),
                  const SizedBox(height: 5),
                  Text('${booking.date.format('yyyy-MM-dd')} ${booking.time}'),
                ],
              ),
              ExpansionTile(
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                title: const Text('Request for lesson'),
                children: [if (booking.request != null) Text(booking.request!)],
              ),
              ExpansionTile(
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                title: const Text('Tutor review'),
                children: [if (booking.tutorReview != null) Text(booking.tutorReview!)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

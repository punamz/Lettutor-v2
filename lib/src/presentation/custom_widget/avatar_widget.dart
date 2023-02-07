import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final double size;
  final String imageUrl;
  const AvatarWidget({Key? key, required this.size, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: ExtendedImage.network(
        imageUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.failed:
              return Icon(Icons.account_circle_rounded, size: size);
            default:
              return null;
          }
        },
      ),
    );
  }
}

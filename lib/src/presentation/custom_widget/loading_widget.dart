import 'package:flutter/material.dart';
import 'package:lettutor/config/image_assets.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Lottie.asset(AnimationAssets.loading, height: 150));
  }
}

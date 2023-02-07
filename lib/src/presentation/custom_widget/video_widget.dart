import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor/src/presentation/custom_widget/loading_widget.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);
  final String videoUrl;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController videoPlayerController;
  ChewieController? _chewieController;
  final RxBool isInitialize = true.obs;

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    await videoPlayerController.initialize();
    _createChewieController();
    isInitialize.value = false;
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(
        () => isInitialize.value
            ? const Center(child: SizedBox(height: 80, child: LoadingWidget()))
            : Chewie(controller: _chewieController!),
      ),
    );
  }
}

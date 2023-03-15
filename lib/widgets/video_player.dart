import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class videoPlayerWidget extends StatefulWidget {

  final String url;
  videoPlayerWidget(this.url);

  @override
  State<videoPlayerWidget> createState() => _videoPlayerWidgetState();
}

class _videoPlayerWidgetState extends State<videoPlayerWidget> {

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool initialize = false;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url);
    videoPlayerController.initialize().then((value){
      chewieController = ChewieController(videoPlayerController: videoPlayerController,
      autoPlay: true, looping: false);
      initialize = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: initialize ? Chewie(controller: chewieController):
        Center(child: CircularProgressIndicator(),),
    );
  }
}

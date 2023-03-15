import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {

  final String url;
  AudioPlayerWidget(this.url);

  @override
  State<AudioPlayerWidget> createState() => _videoPlayerWidgetState();
}

class _videoPlayerWidgetState extends State<AudioPlayerWidget> {

  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration();
  Duration position = Duration();
  bool playing = false;

  @override
  void initState() {
    handleAudio();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 75,
              width: 65,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/music.png'),
            ),
            SizedBox(height: 40,),
            Slider.adaptive(
              min: 0.0,
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
              onChanged: (double value) {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => audioPlayer.seek(Duration(seconds: position.inSeconds - 5)),
                  icon: Icon(Icons.fast_rewind, color: Colors.white, size: 30,),
                ),
                IconButton(
                  onPressed: () => handleAudio(),
                  icon: Icon( playing ? Icons.pause_circle_filled:
                    Icons.play_circle_fill, color: Colors.white, size: 50,),
                ),
                IconButton(
                  onPressed: () => audioPlayer.seek(Duration(seconds: position.inSeconds + 5)),
                  icon: Icon(
                    Icons.fast_forward, color: Colors.white, size: 30,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleAudio() async {
    if (playing) {
        await audioPlayer.pause();
        setState(() => playing = false);
    }
    else {
      await audioPlayer.play(UrlSource(widget.url));
      setState(() => playing = true);
    }

    audioPlayer.onDurationChanged.listen((Duration dur) {
      if(mounted) setState(() => duration = dur);
    });

    audioPlayer.onPositionChanged.listen((Duration dur) {
      if(mounted) setState(() => position = dur);
    });
  }
}
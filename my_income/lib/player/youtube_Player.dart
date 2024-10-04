import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FirstPlayer extends StatefulWidget {
  final String id;
  const FirstPlayer({super.key, required this.id});

  @override
  State<FirstPlayer> createState() => _FirstPlayerState();
}

class _FirstPlayerState extends State<FirstPlayer> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    var videoId = YoutubePlayer.convertUrlToId(widget.id);
    controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(autoPlay: false));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        controller: controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}

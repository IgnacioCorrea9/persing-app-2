import 'dart:async';

import 'package:flutter/material.dart';
import 'package:persing/core/colors.dart';
import 'package:persing/providers/publicacion.dart';
import 'package:persing/providers/recompensa.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wakelock/wakelock.dart';

enum VideoStatus { paused, playing }

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  final String sector;
  final String cardId;
  final String postId;
  VideoWidget({
    Key? key,
    required this.videoUrl,
    required this.sector,
    required this.cardId,
    required this.postId,
  });
  @override
  _VideoWidgetState createState() =>
      _VideoWidgetState(this.videoUrl, this.sector, key, this.cardId);
}

class _VideoWidgetState extends State<VideoWidget> {
  String? videoUrl;
  String? sector;
  Key? key;
  late String cardId;
  late VideoStatus status;
  late bool visible;
  late Timer _timer;

  late Stopwatch sw = Stopwatch();
  _VideoWidgetState(this.videoUrl, this.sector, this.key, this.cardId);
  late VideoPlayerController _controller;
  // ignore: unused_field
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    startTimer();
    if (videoUrl != null) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl!),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false));
      _initializeVideoPlayerFuture = _controller.initialize();
      _controller.addListener(() {
        checkVideo();
      });
    }
    super.initState();
  }

  bool flag = true;

  void checkVideo() {
    if (_controller.value.position.inSeconds >=
            (_controller.value.duration.inSeconds * 0.75).toInt() &&
        flag) {
      Provider.of<Publicacion>(context, listen: false).updateVtr(
        widget.postId,
      );
      Provider.of<Recompensa>(context, listen: false).saveWatchedTime(
        widget.postId,
        widget.sector,
        _controller.value.duration.inSeconds.toDouble(),
      );
      Future.delayed(
        Duration(
          seconds: (_controller.value.duration.inSeconds * 0.1).toInt(),
        ),
        () => Wakelock.disable(),
      );
      flag = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();

    setVisibility(true);
    super.dispose();
  }

  void startWatchTime() {
    if (videoUrl != null) {
      status = VideoStatus.playing;
      sw.start();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(
        const Duration(milliseconds: 100), (Timer timer) async {});
  }

  void pauseWatchTime() {
    if (videoUrl != null) {
      status = VideoStatus.paused;
      sw.stop();
    }
  }

  void stopWatchTime() {
    if (mounted) {
      if (videoUrl != null) {
        status = VideoStatus.paused;
        sw.stop();
        final elapsed =
            double.parse((sw.elapsedMilliseconds / 1000).toStringAsFixed(2));
        sw.reset();
        Provider.of<Recompensa>(context, listen: false).saveWatchedTime(
          widget.postId,
          sector!,
          elapsed,
        );
        _controller.pause();
        _controller.seekTo(Duration(minutes: 0, seconds: 0));
      }
    }
  }

  void togglePlay() {
    if (status == VideoStatus.playing && visible) {
      setState(() {
        _controller.pause();
        status = VideoStatus.paused;
        this.pauseWatchTime();
      });
    } else if (status == VideoStatus.paused && visible) {
      setState(() {
        _controller.play();
        status = VideoStatus.playing;
        this.startWatchTime();
      });
    }
  }

  void setVisibility(value) {
    if (!value) {
      visible = false;
      stopWatchTime();
    } else {
      visible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return VisibilityDetector(
            onVisibilityChanged: (info) async {
              int visiblePercentage = (info.visibleFraction * 100).floor();
              if (visiblePercentage >= 80) {
                setVisibility(true);
              } else if (visiblePercentage < 40) {
                if (mounted) {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    }
                  });
                }
                setVisibility(false);
              }
            },
            key: Key('visibility-' + '${widget.videoUrl}'),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: GestureDetector(
                onTap: () {
                  if (_controller.value.isPlaying) {
                    setState(() {
                      Wakelock.disable();
                      _controller.pause();
                      pauseWatchTime();
                    });
                  } else {
                    setState(() {
                      Wakelock.enable();
                      _controller.play();
                      startWatchTime();
                      startTimer();
                    });
                    // If the video is paused, play it.
                  }
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    VideoPlayer(_controller),
                    if (!_controller.value.isPlaying)
                      Center(
                        child: Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: size.height * 0.12),
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                backgroundColor: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  VideoPlayerController _videoPlayerController;
  VoidCallback _listen;
  @override
  void initState() {
    super.initState();
    _listen = () {
      setState(() {});
    };
  }

  @override
  void deactivate() {
    _videoPlayerController?.setVolume(0.0);
    _videoPlayerController.removeListener(_listen);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: _videoPlayerController == null
                    ? Container()
                    : VideoPlayer(_videoPlayerController),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapPlay,
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  void _onTapPlay() {
    String url = 'http://video.pearvideo.com/mp4/short/20181128/cont-1483207-13297781-hd.mp4';

    if (_videoPlayerController == null) {
      _videoPlayerController = VideoPlayerController.network(url)
        ..addListener(_listen)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController
          ..setVolume(0)
          ..pause();
      } else {
        _videoPlayerController
          ..setVolume(1.0)
          ..play();
      }
    }
  }
}

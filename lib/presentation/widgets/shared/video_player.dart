
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerAsset extends StatefulWidget {
  const VideoPlayerAsset({
    super.key, 
    required this.url,
  });

  final String url;

  @override
  State<VideoPlayerAsset> createState() => _VideoPlayerAssetState();
}

class _VideoPlayerAssetState extends State<VideoPlayerAsset> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(
      widget.url
    ))..initialize().then((_){
      setState(() {});
      _controller.play();
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            height: double.infinity,
            width: double.infinity,
            child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: 9.0,
                  child: VideoPlayer(_controller),
                )
              : Container(),
          ),
      
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: Center(
                child: IconButton.filled(
                  iconSize: 40,
                  onPressed: (){
                    // print(_controller.value.isPlaying );
                    setState(() {
                      _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                    });
                  }, 
                  icon: Icon(
                    _controller.value.isPlaying ? (Icons.pause) : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}
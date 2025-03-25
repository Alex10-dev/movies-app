
import 'dart:async';

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
  late bool showVideoPlayerUI = false;
  Timer? _hidePlayerUITimer;
  late bool _isCompleted = false;
  late bool _isPlaying = false;
  late double _volume = 1.0;
  late double _volumeBeforeMute = 1.0;
  late int _duration = 0;
  late String _videoTime = '00:00';
  late double _videoProgress = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(
      widget.url
    ))..initialize().then((_){
      setState(() {});
      _controller.setVolume(0.7);
      _controller.play();
      _duration = _controller.value.position.inSeconds;
    });

    _controller.addListener(() {
      setState(() {
        if( _controller.value.position == _controller.value.duration ) {
          _isCompleted = _controller.value.isCompleted;
        } else {
          _isCompleted = false;
        }
        _isPlaying = _controller.value.isPlaying;
        _volume = _controller.value.volume;
        _duration = _controller.value.position.inSeconds;
        _videoTime = formatVideoTime(_controller.value.position.inSeconds, _controller.value.duration.inSeconds);
        calculateVideoProgress();
      });
    });

  }

  // Pausar video cuando la pantalla ya no es la activa
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!ModalRoute.of(context)!.isCurrent) {
      _controller.pause(); 
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleVideoPlayerUI(){
    
    if( showVideoPlayerUI ) {
      _hidePlayerUITimer?.cancel();
      showVideoPlayerUI = !showVideoPlayerUI;
      setState(() {});
    } else {
      setState(() {
        showVideoPlayerUI =  true;
      });
      hideVideoPlayerUI();
    }
  }

  void hideVideoPlayerUI() {
    _hidePlayerUITimer?.cancel();
    _hidePlayerUITimer = Timer(
      const Duration(seconds: 4), (){
        if( mounted ) {
          setState(() {
            showVideoPlayerUI = false;
          });
        }
      }
    );
  }

  void playOrStopVideo() {
    setState(() {
      if( _isPlaying && !_isCompleted ) {
        _controller.pause();
      } else {
        _controller.play();
      }
      hideVideoPlayerUI();
    });
  }

  void muteVolume() {
    _volumeBeforeMute = _volume;
    _controller.setVolume(0.0);
  }

  void unMuteVolume() {
    _controller.setVolume( _volumeBeforeMute );
  }

  void volumeButtonControl() {
    setState(() {
      if( _volume == 0 ) {
        unMuteVolume();
      } else {
        muteVolume();
      }
      hideVideoPlayerUI();
    });
  }

  String formatVideoTime( int currentTime, int totalTime ) {

    /*final int currentMinutes = _controller.value.position.inSeconds ~/ 60;
    final int currentSeconds = _controller.value.position.inSeconds % 60;
    final int totalMinutes = _controller.value.duration.inSeconds ~/ 60;
    final int totalSeconds = _controller.value.duration.inSeconds % 60;*/

    final int currentMinutes = currentTime ~/ 60;
    final int currentSeconds = currentTime % 60;
    final int totalMinutes = totalTime ~/ 60;
    final int totalSeconds = totalTime % 60;

    final String stringCurrentSeconds = currentSeconds < 10 ? '0$currentSeconds' : '$currentSeconds';
    final String stringtotalSeconds = totalSeconds < 10 ? '0$totalSeconds' : '$totalSeconds';

    return '$currentMinutes:$stringCurrentSeconds / $totalMinutes:$stringtotalSeconds';

  }

  void calculateVideoProgress() {
    _videoProgress = (100 * _controller.value.position.inSeconds) / _controller.value.duration.inSeconds;
  }

  int calculateVideoTimeByProgress( double progress ) {
    return ((progress * _controller.value.duration.inSeconds) ~/ 100);
  }

  void updateVideoTimeByProgress( double progress ) {
    final int newCurrentTime = calculateVideoTimeByProgress(progress);
    _controller.seekTo(Duration(seconds: newCurrentTime));
  }

  void onChangeSliderValue( double value ) {
    
    if((value - _videoProgress).abs() > 0.5) {
      setState(() {
        _videoProgress = value;
        final newTime = calculateVideoTimeByProgress(value);
        _videoTime = formatVideoTime(newTime, _controller.value.duration.inSeconds);
      });
    }
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
                  aspectRatio: 16.0/9.0,
                  child: VideoPlayer(_controller),
                )
              : Container(),
          ),
      
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                toggleVideoPlayerUI();
              },
              child: showVideoPlayerUI 
                ? _VideoPlayerControls(
                  time: _videoTime,
                  progress: _videoProgress,
                    playButtonIcon: ( _isPlaying )
                      ? const Icon(Icons.pause_outlined, color: Colors.white) 
                      : const Icon(Icons.play_arrow_rounded, color: Colors.white),
                    volumeButtonIcon: ( _volume > 0)
                      ? const Icon(Icons.volume_up_rounded, color: Colors.white,)
                      : const Icon(Icons.volume_off_rounded, color: Colors.white,),
                    playButtonFunction: playOrStopVideo,
                    volumneButtonFunction: volumeButtonControl,
                    onChangeSliderStartFunction: () {
                        _hidePlayerUITimer?.cancel();
                        _controller.pause();
                    },
                    onChangeSliderFunction: (p0) => onChangeSliderValue(p0),
                    onChangeSlideEndFunction: (p0) {
                        updateVideoTimeByProgress(p0);
                        _controller.play();
                        hideVideoPlayerUI();
                    },
                  )
                : Container( color: Colors.transparent )
            ),
          ),
          Text( _duration.toString() ),
        ]
      ),
    );
  }
}

class _VideoPlayerControls extends StatelessWidget {
  const _VideoPlayerControls({
    required this.playButtonFunction, 
    required this.playButtonIcon, 
    required this.volumneButtonFunction, 
    required this.volumeButtonIcon, 
    required this.time, 
    required this.progress, 
    required this.onChangeSliderFunction, 
    required this.onChangeSlideEndFunction, 
    required this.onChangeSliderStartFunction,
  }) : super();

  final VoidCallback volumneButtonFunction;
  final VoidCallback playButtonFunction;
  final void Function( double ) onChangeSliderFunction;
  final Function( double ) onChangeSlideEndFunction;
  final VoidCallback onChangeSliderStartFunction;

  final Icon playButtonIcon;
  final Icon volumeButtonIcon;
  final String time;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: IconButton(
                iconSize: 40,
                onPressed: (){
                  playButtonFunction();
                }, 
                icon: playButtonIcon
              ),
            ),
          ),
          Container(
            height: 40,
            color: Colors.black45,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    volumneButtonFunction();
                  }, 
                  icon: volumeButtonIcon,
                ),
                Expanded(
                  child: Slider(
                    inactiveColor: Colors.grey,
                    value: progress, 
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChangeStart: (value) {
                      onChangeSliderStartFunction();
                    },
                    onChanged:(value) {
                      onChangeSliderFunction( value );
                    },
                    onChangeEnd: (value) {
                      onChangeSlideEndFunction( value );
                    },
                  ),
                ),
                Text(
                  time, 
                  style: const TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}
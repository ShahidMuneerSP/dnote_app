import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class WidgetVideoPlayer extends StatefulWidget {
  WidgetVideoPlayer({
    Key? key,
    required this.videoController,
    required this.orientation,
  }) : super(key: key);
  Orientation orientation;
  VideoPlayerController videoController;

  @override
  State<WidgetVideoPlayer> createState() => _WidgetVideoPlayerState();
}

class _WidgetVideoPlayerState extends State<WidgetVideoPlayer> {
  bool isVideoLoading = true;
  bool isVideoPlay = false;
  bool isControlsShown = false;
  bool isFinished = false;
  bool isError = false;

  ///current volume of the video
  final double _volume = 100;
  double _playbackSpeed = 1.0;

  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (widget.videoController.value.isBuffering) {
        isVideoLoading = true;
        isVideoPlay = false;
      } else {
        isVideoLoading = false;
      }

      if (widget.videoController.value.isPlaying) {
        isVideoPlay = true;
      } else {
        isVideoPlay = false;
      }

      if (widget.videoController.value.hasError) {
        isError = true;
      } else {
        isError = false;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ///landscape
    if (widget.orientation == Orientation.landscape) {
      return Container(
        color: Colors.black,
        child: Center(
          child: AspectRatio(
            aspectRatio: widget.videoController.value.aspectRatio,
            child: Visibility(
              visible: !isError,
              replacement: const Center(
                child: Text(
                  "Video not found",
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  ///player
                  Container(
                      color: Colors.black,
                      child: VideoPlayer(widget.videoController)),

                  ///tap to show controls
                  Stack(
                    children: <Widget>[
                      Container(
                        color: isControlsShown ? Colors.black12 : null,
                      ),

                      ///tap to show controls and double tap to seek forward and backward 10 sec
                      Row(
                        children: [
                          ///single tap to show controls and double tap to backward 10 sec on left portion
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                isControlsShown = true;
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    if (isControlsShown)
                                      isControlsShown = false;
                                  },
                                );
                              },
                              onDoubleTap: () {
                                var val = widget.videoController.value.position;
                                widget.videoController.seekTo(
                                  val - const Duration(seconds: 10),
                                );
                              },
                            ),
                          ),

                          /// single tap to show controls on middle potion
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                isControlsShown = true;
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    if (isControlsShown)
                                      isControlsShown = false;
                                  },
                                );
                              },
                            ),
                          ),

                          ///single tap to show controls and double tap to forward 10 sec on right portion
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                isControlsShown = true;
                                Future.delayed(
                                  const Duration(seconds: 2),
                                  () {
                                    if (isControlsShown)
                                      isControlsShown = false;
                                  },
                                );
                              },
                              onDoubleTap: () {
                                var val = widget.videoController.value.position;
                                widget.videoController.seekTo(
                                  val + const Duration(seconds: 10),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      ///play and pause video
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 50.h),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 50),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: !isControlsShown
                                ? const SizedBox.shrink()
                                : IconButton(
                                    onPressed: () {
                                      if (isFinished) {
                                        widget.videoController.seekTo(
                                          const Duration(
                                            microseconds: 0,
                                          ),
                                        );
                                        isControlsShown = false;
                                        widget.videoController.play();
                                      } else {
                                        widget.videoController.value.isPlaying
                                            ? widget.videoController.pause()
                                            : widget.videoController.play();
                                      }
                                    },
                                    icon: Icon(
                                      isFinished
                                          ? Icons.replay
                                          : widget.videoController.value
                                                  .isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                      color: Colors.white,
                                      size:
                                          MediaQuery.of(context).orientation ==
                                                  Orientation.portrait
                                              ? 50.0.w
                                              : 110.h,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ///progressbar of the playing video
                      VideoProgressIndicator(
                        widget.videoController,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          bufferedColor: Colors.white.withOpacity(0.8),
                          playedColor: Colors.red.shade700.withOpacity(0.8),
                        ),
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      ),

                      ///other controls (mute, adjust speed, adjust landscape and portrait mode)
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1),
                        reverseDuration: const Duration(seconds: 1),
                        child: !isControlsShown
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ///playback speed
                                  IconButton(
                                    icon: const Icon(
                                      Icons.speed,
                                      color: Colors.white,
                                      // size: 50.0.w,
                                    ),
                                    onPressed: () {
                                      bottomSheetForPlaybackSpeed();
                                    },
                                  ),

                                  ///mute and unmute
                                  IconButton(
                                    icon: Icon(
                                      widget.videoController.value.volume == 0
                                          ? Icons.volume_off
                                          : Icons.volume_up,
                                      color: Colors.white,
                                      // size: 50.0.w,
                                    ),
                                    onPressed: () {
                                      if (widget.videoController.value.volume ==
                                          0) {
                                        widget.videoController
                                            .setVolume(_volume);
                                      } else {
                                        //mute
                                        widget.videoController.setVolume(0);
                                      }
                                    },
                                  ),

                                  ///Adjust landscape and portrait mode
                                  IconButton(
                                    icon: const Icon(
                                      Icons.fullscreen,
                                      color: Colors.white,
                                      // size: 50.0.w,
                                    ),
                                    onPressed: () {
                                      SystemChrome.setPreferredOrientations(
                                        [DeviceOrientation.portraitUp],
                                      );
                                    },
                                  ),
                                ],
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    ///portrait
    return Visibility(
      visible: !isVideoLoading,
      replacement: Container(
        color: Colors.black,
        height: 250.h,
        width: double.infinity,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      child: Container(
        color: Colors.black,
        child: AspectRatio(
          aspectRatio: widget.videoController.value.isInitialized
              ? widget.videoController.value.aspectRatio
              : 1.7777777777777777,
          child: Visibility(
            visible: !isError,
            replacement: const Center(
              child: Text(
                "Video not found",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ///player
                VideoPlayer(
                  widget.videoController,
                ),

                ///tap to show controls
                Stack(
                  children: <Widget>[
                    Container(
                      color: isControlsShown ? Colors.black12 : null,
                    ),

                    ///tap to show controls and double tap to seek forward and backward 10 sec
                    Row(
                      children: [
                        ///single tap to show controls and double tap to backward 10 sec on left portion
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              isControlsShown = true;

                              Future.delayed(
                                const Duration(seconds: 2),
                                () {
                                  if (isControlsShown) isControlsShown = false;
                                },
                              );
                            },
                            onDoubleTap: () {
                              var val = widget.videoController.value.position;
                              widget.videoController.seekTo(
                                val - const Duration(seconds: 10),
                              );
                            },
                          ),
                        ),

                        /// single tap to show controls on middle potion
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              isControlsShown = true;
                              Future.delayed(
                                const Duration(seconds: 2),
                                () {
                                  if (isControlsShown) isControlsShown = false;
                                },
                              );
                            },
                          ),
                        ),

                        ///single tap to show controls and double tap to forward 10 sec on right portion
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              isControlsShown = true;
                              Future.delayed(
                                const Duration(seconds: 2),
                                () {
                                  if (isControlsShown) isControlsShown = false;
                                },
                              );
                            },
                            onDoubleTap: () {
                              var val = widget.videoController.value.position;
                              widget.videoController.seekTo(
                                val + const Duration(seconds: 10),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    ///play and pause video

                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 50.h),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 50),
                          reverseDuration: const Duration(milliseconds: 200),
                          child: !isControlsShown
                              ? const SizedBox.shrink()
                              : IconButton(
                                  onPressed: () {
                                    if (isFinished) {
                                      widget.videoController.seekTo(
                                        const Duration(
                                          microseconds: 0,
                                        ),
                                      );
                                      isControlsShown = false;
                                      widget.videoController.play();
                                    } else {
                                      widget.videoController.value.isPlaying
                                          ? widget.videoController.pause()
                                          : widget.videoController.play();
                                    }
                                  },
                                  icon: Icon(
                                    isFinished
                                        ? Icons.replay
                                        : widget.videoController.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                    color: Colors.white,
                                    size: MediaQuery.of(context).orientation ==
                                            Orientation.portrait
                                        ? 50.0.w
                                        : 110.h,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ///progressbar of the playing video
                    VideoProgressIndicator(
                      widget.videoController,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        bufferedColor: Colors.white.withOpacity(0.8),
                        playedColor: Colors.red.shade700.withOpacity(0.8),
                      ),
                      padding: EdgeInsets.only(top: 20.h),
                    ),

                    ///other controls (mute, adjust speed, adjust landscape and portrait mode)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1),
                      reverseDuration: const Duration(seconds: 1),
                      child: !isControlsShown
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ///playback speed
                                IconButton(
                                  icon: const Icon(
                                    Icons.speed,
                                    color: Colors.white,
                                    // size: 50.0.w,
                                  ),
                                  onPressed: () {
                                    bottomSheetForPlaybackSpeed();
                                  },
                                ),

                                ///mute and unmute
                                IconButton(
                                  icon: Icon(
                                    widget.videoController.value.volume == 0
                                        ? Icons.volume_off
                                        : Icons.volume_up,
                                    color: Colors.white,
                                    // size: 50.0.w,
                                  ),
                                  onPressed: () {
                                    if (widget.videoController.value.volume ==
                                        0) {
                                      ///unmute
                                      widget.videoController.setVolume(_volume);
                                    } else {
                                      //mute
                                      widget.videoController.setVolume(0);
                                    }
                                  },
                                ),

                                ///Adjust landscape and portrait mode
                                IconButton(
                                  icon: const Icon(
                                    Icons.fullscreen,
                                    color: Colors.white,
                                    // size: 50.0.w,
                                  ),
                                  onPressed: () {
                                    SystemChrome.setPreferredOrientations(
                                        [DeviceOrientation.landscapeLeft]);
                                  },
                                ),
                              ],
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bottomSheetForPlaybackSpeed() {
    List<double> _items = [
      0.25,
      0.5,
      0.75,
      1,
      1.25,
      1.5,
      1.75,
      2,
    ];

    return Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Column(
            children: List.generate(
              _items.length,
              (index) => InkWell(
                onTap: () {
                  _playbackSpeed = _items[index];
                  Get.back();
                  widget.videoController.play();
                  setState(() {});
                },
                child: Container(
                  color: _playbackSpeed == _items[index]
                      ? Colors.black12
                      : Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 10.h
                        : 15.h,
                  ),
                  child: Center(
                    child: Text(
                      _items[index].toString() + 'x',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? null
                            : 15.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}

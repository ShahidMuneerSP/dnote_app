import 'dart:developer';

import 'package:dnote_2_0/Controller/youtube_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../Theme/theme.dart';

import '../../apis/videos/show_videos_api.dart';
import '../../models/subject_model.dart';

import 'view_models/decrypt_url.dart';
import 'widgets/widget_video_player.dart';

///
///Youtube player screen
///

YoutubePlayerScreenController youtubeScreenController =
    YoutubePlayerScreenController();

class YoutubePlayerScreen extends StatefulWidget {
  final List<Topics> model;
  final Subjects dataModel;
  final int index;

  const YoutubePlayerScreen(
      {Key? key,
      required this.model,
      required this.index,
      required this.dataModel})
      : super(key: key);

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

bool playArea = false;

String? topicTitle;

Map<dynamic, dynamic>? datas;

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  Map<String, dynamic>? dataModel;

  int _selectedVideoIndex = 0;

  String decryptedUrl = "";

  ///ext_video_player: ^0.1.2 controller
  VideoPlayerController extVideoPlayerController =
      VideoPlayerController.network("");

  ///current playback speed
  double _playbackSpeed = 1.0;

  ///check if show controls
  bool isControlsShown = true;

  ///check if the video is finished playing
  bool isFinished = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    youtubeScreenController.isVideoLoading(true);
    Future.delayed(
      const Duration(seconds: 2),
      () => youtubeScreenController.isVideoLoading(false),
    );
    log(widget.model[0].scribe?.first ?? "");
    dataModel = await showVideosApi(widget.model[0].scribe?.first ?? "");
    final encrypted = dataModel?['url'];

    if (encrypted != null) {
      decryptedUrl = "";
      decryptedUrl = decryptUrl(encrypted);

      log(decryptedUrl);

      youtubeScreenController.topicTitle.value =
          widget.model[0].topicName ?? "";

      youtubeScreenController.isVideoPlay(true);

      extVideoPlayerController = VideoPlayerController.network(
        "http://$decryptedUrl",
      )..initialize().then((value) {
          setState(() {
            extVideoPlayerController.setLooping(true);
          });
        });

      extVideoPlayerController.play();

      if (extVideoPlayerController.value.isPlaying) {
        setState(() {
          isControlsShown = false;
        });
      }
    } else {
      youtubeScreenController.isVideoPlay(false);
      extVideoPlayerController = VideoPlayerController.network(
        "",
      )..initialize().then((value) {
          setState(() {});
        });

      extVideoPlayerController.play();
      if (extVideoPlayerController.value.isPlaying) {
        setState(() {
          isControlsShown = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              "assets/images/rm222batch2-mind-03 1.png",
            ),
          ),
        ),
        child: OrientationBuilder(
          builder: (context, orientation) {
            ///hide notification bar to play video in landscape mode
            if (MediaQuery.of(context).orientation == Orientation.landscape) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            } else {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            }
            return orientation == Orientation.portrait
                ? SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => youtubeScreenController.isVideoLoading.value
                              ? Container(
                                  width: double.maxFinite,
                                  height: 250.h,
                                  color: Colors.black,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : WidgetVideoPlayer(
                                  orientation: orientation,
                                  videoController: extVideoPlayerController,
                                ),
                        ),
                        topicsList(),
                      ],
                    ),
                  )

                ///in landscape mode
                : WidgetVideoPlayer(
                    orientation: orientation,
                    videoController: extVideoPlayerController,
                  );
          },
        ),
      ),
    );
  }

  topicsList() {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 15.w,
              left: 15.w,
              bottom: 10.w,
              right: 10.w,
            ),
            width: MediaQuery.of(context).size.width,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  youtubeScreenController.isVideoLoading.value
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(
                            color: AppTheme.appBlue,
                            strokeWidth: 4.r,
                          ),
                        )
                      : Text(
                          youtubeScreenController.topicTitle.value,
                          // snapshot.data.docs[selectedTopicNameIndex]['topicName'],
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppTheme.appBlue,
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 6.w,
                    ),
                    child: Text(
                      widget.dataModel.chapters?[widget.index].chapterName ??
                          "",
                      style: TextStyle(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.w),
                    child: IconAndTitle(
                      iconPath: 'assets/svgs/video_icon.svg',
                      title: 'videos',
                      // title: '${snapshot.data.docs.length} Videos',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 12.w,
                      left: 4.w,
                    ),
                    child: Text(
                      'Videos',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.appBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.model.length,
              // itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                // var intialVideoTile =
                //     snapshot.data.docs[0]['topicName'];
                return GestureDetector(
                  onTap: () async {
                    decryptedUrl = "";
                    setState(() {
                      _selectedVideoIndex = index;
                    });
                    // if (isUserActive || index == 0) {
                    extVideoPlayerController.pause();

                    youtubeScreenController.isVideoLoading(true);
                    try {
                      dataModel = await showVideosApi(
                          widget.model[index].scribe?.first ?? "");

                      // ignore: unnecessary_null_comparison
                      if (dataModel?['url'] != null) {
                        decryptedUrl = decryptUrl(dataModel?['url']);
                        youtubeScreenController.topicTitle.value =
                            widget.model[index].topicName ?? "";
                        // youtubeScreenController.isVideoPlay(true);
                        extVideoPlayerController =
                            VideoPlayerController.network(
                          "http://$decryptedUrl",
                        )..initialize().then((value) {
                                setState(() {
                                  extVideoPlayerController.setLooping(true);
                                });
                              });

                        youtubeScreenController.isVideoLoading(false);

                        extVideoPlayerController.play();

                        if (extVideoPlayerController.value.isPlaying) {
                          setState(() {
                            isControlsShown = false;
                          });
                        }
                      } else {
                        youtubeScreenController.isVideoPlay(false);
                        extVideoPlayerController =
                            VideoPlayerController.network(
                          "",
                        )..initialize().then((value) {
                                setState(() {});
                              });

                        // extVideoPlayerController.addListener(() {});

                        extVideoPlayerController.play();
                        if (extVideoPlayerController.value.isPlaying) {
                          setState(() {
                            isControlsShown = false;
                          });
                        }
                      }
                    } catch (e) {
                      log(e.toString());
                    } finally {
                      youtubeScreenController.isVideoLoading(false);
                      youtubeScreenController.isVideoPlay(false);
                      extVideoPlayerController.pause();
                    }
                  },
                  child: Container(
                    color: _selectedVideoIndex == index
                        ? AppTheme.appBlue
                        : Colors.white,
                    margin: EdgeInsets.only(
                      top: 10.w,
                    ),
                    padding: EdgeInsets.only(
                      top: 10.w,
                      left: 15.w,
                      bottom: 10.w,
                      right: 8.w,
                    ),
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: 90.w,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: 3.w,
                          ),
                          child: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: _selectedVideoIndex == index
                                ? Colors.white
                                : AppTheme.appBlue,
                            child: Icon(
                              // index == selectedTopicNameIndex
                              // ? Icons.pause
                              // :
                              Icons.play_arrow,
                              color: _selectedVideoIndex == index
                                  ? AppTheme.appBlue
                                  : AppTheme.appWhite,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                            ),
                            child: Text(
                              widget.model[index].topicName ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                color: _selectedVideoIndex == index
                                    ? AppTheme.appWhite
                                    : Colors.black,
                              ),
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
    // });
  }

  showAndHideControls() {
    if (isControlsShown) {
      setState(() {
        isControlsShown = false;
      });
    } else {
      ///if video finished
      if (isFinished) {
        setState(() {
          isControlsShown = true;
        });
      } else {
        setState(() {
          isControlsShown = true;
        });
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isControlsShown = false;
          });
        });
      }
    }
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
                  extVideoPlayerController.setPlaybackSpeed(_items[index]);
                  _playbackSpeed = _items[index];
                  Get.back();
                  extVideoPlayerController.play();
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

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    extVideoPlayerController.dispose();
  }
}
//Playing video title name , chapter name and total number of videos

class PlayingTopicTitle extends StatelessWidget {
  PlayingTopicTitle({
    Key? key,
  }) : super(key: key);

  // var introVideoTitle =
  //     FirebaseFirestore.instance.doc('$_dbPath/topics/1/topicName');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15.w,
        left: 15.w,
        bottom: 10.w,
        right: 10.w,
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppTheme.appBlue,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 6.w,
            ),
            child: Text(
              'Motions and measurement of distance ',
              style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.w),
            child: IconAndTitle(
              iconPath: 'assets/svgs/video_icon.svg',
              title: '10 Videos',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 12.w,
              left: 15.w,
            ),
            child: Text(
              'Videos',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.appBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Icon and text

class IconAndTitle extends StatelessWidget {
  IconAndTitle({Key? key, required this.iconPath, required this.title})
      : super(key: key);

  String? iconPath;
  String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath!,
          color: AppTheme.appLightGrey,
        ),
        Text(
          title!,
          style: const TextStyle(
            color: AppTheme.appLightGrey,
          ),
        )
      ],
    );
  }
}

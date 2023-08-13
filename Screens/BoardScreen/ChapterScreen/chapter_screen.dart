import 'package:dnote_2_0/Screens/HomeScreen/home.dart';
import 'package:dnote_2_0/Screens/splash/splash_screen.dart';
import 'package:dnote_2_0/Theme/theme.dart';
import 'package:dnote_2_0/models/subject_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../HomeScreen/dialogs_home_screen.dart';
import '../../TopicScreen/topic_screen.dart';



class ChapterScreen extends StatefulWidget {
  final String subjectName;
  final String subjectIcon;
  final int index;
  final Subjects model;

  const ChapterScreen(
      {Key? key,
      required this.subjectName,
      required this.subjectIcon,
      required this.index,
      required this.model})
      : super(key: key);
  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppTheme.appWhite,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      "assets/images/rm222batch2-mind-03 1.png",
                    ))),
            child: Column(
              children: [
                HeaderWidget(
                    subjectName: widget.subjectName,
                    subjectIcon: widget.subjectIcon,
                    index: widget.index),
                chapterListview(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  chapterListview() {
    // final classes = FirebaseFirestore.instance
    //     .collection("CBSE/Class10/subject/$_subjectIndex/chapters")
    //     .snapshots();

    // return StreamBuilder(
    //     stream: classes,
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    return Expanded(
      child: SizedBox(
        child: Obx(
          () => homeScreenController.data.isEmpty
              ? const Center(
                  child: Text(
                    "No Chapters..",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.model.chapters?.length,
                  // itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // final selectedChapterIndex = index + 1;
                        // final dBPath =
                        //     'CBSE/Class10/subject/$_subjectIndex/chapters/$selectedChapterIndex';
                        // final selectedChapterName =
                        //     snapshot.data.docs[index]['chapName'];
                        // print(dBPath.runtimeType);

                        if (index == 0 || isUserActive) {
                          Get.to(
                            YoutubePlayerScreen(
                              model: widget.model.chapters?[index].topics ?? [],
                              index: index,
                              dataModel: widget.model,
                            ),
                            // arguments: {
                            //   'dBPath': dBPath,
                            //   'chapterName': selectedChapterName,
                            // }
                          );
                        } else {
                          purchasePremiumDialog();
                        }
                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 30.w,
                          ),
                          width: 380.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppTheme.appWhite,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 7,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20.w,
                                    left: 20.w,
                                    right: 15.w,
                                    bottom: 20.w),
                                width: 60.w,
                                height: 80.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppTheme.appBlue,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: SvgPicture.asset(
                                    widget.subjectIcon,
                                    color: AppTheme.appWhite,
                                  ),
                                ),
                              ),
                              Container(
                                width: 270.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.model.chapters?[index]
                                              .chapterName ??
                                          "",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Visibility(
                                      visible: index == 0 || isUserActive,
                                      replacement: Icon(
                                        Icons.lock,
                                        size: 25.sp,
                                      ),
                                      child: Icon(
                                        Icons.chevron_right,
                                        size: 30.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
    // });
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.subjectName,
    required this.subjectIcon,
    required this.index,
  }) : super(key: key);

  final String subjectName;
  final String subjectIcon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.appWhite,
                AppTheme.appBlue.withOpacity(.5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                iconSize: 35,
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 60.w,
                  left: 30.w,
                ),
                child: Text(
                  subjectName,
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30.w,
                  top: 10.w,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/video_icon.svg',
                      width: 25,
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                          '${homeScreenController.data[index].chapters!.length} Chapters'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0.w,
          bottom: 0,
          child: SvgPicture.asset(
            subjectIcon,
            width: 200.w,
            height: 200.w,
            color: AppTheme.appBlue,
          ),
        )
      ],
    );
  }
}

//chapter container card which contains

// class ChapterContainerWidget extends StatelessWidget {
//   const ChapterContainerWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.separated(
//         separatorBuilder: (context, index) => SizedBox(),
//         itemCount: chapter.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Get.to(
//                 YoutubePlayerScreen(),
//               );
//             },
//             child: Container(
//               margin: EdgeInsets.only(
//                 top: 22.w,
//                 right: 29.w,
//                 left: 29.w,
//               ),
//               // width: 300.w,
//               // height: 240.w,
//               // color: AppTheme.appBlue,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   10.r,
//                 ),
//                 color: AppTheme.appWhite,
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 7,
//                     spreadRadius: 1,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10.r),
//                       topLeft: Radius.circular(10.r),
//                     ),
//                     child: Image.network(
//                       // 'https://cdnapisec.kaltura.com/p/2172211/thumbnail/entry_id/1_2v9fkpul/def_height/500/def_width/500/',
//                       chapter[index].image!,
//                       fit: BoxFit.fill,
//                       width: 370.w,
//                       height: 170.w,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       chapter[index].title!,
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                   ),

//                   // Quiz outlined button
//                   GestureDetector(
//                     onTap: () {
//                       Get.to(QuizScreen());
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 4.w,
//                         horizontal: 4.w,
//                       ),
//                       margin: EdgeInsets.only(left: 8.w, bottom: 8.w),
//                       width: 80.w,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.r),
//                         border: Border.all(
//                           color: AppTheme.appBlue,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           SvgPicture.asset('assets/svgs/quiz_icon.svg'),
//                           const Text(
//                             'Quiz',
//                             style: TextStyle(color: AppTheme.appBlue),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// header widget with back button, subject name, chapter name, subject Icon, with lineargradient background

dataFrom() {}

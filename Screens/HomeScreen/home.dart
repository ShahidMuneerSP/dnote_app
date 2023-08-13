import 'dart:developer';

import 'package:dnote_2_0/Controller/homeScreenController.dart';

import 'package:dnote_2_0/Screens/splash/splash_screen.dart';
import 'package:dnote_2_0/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../BoardScreen/ChapterScreen/chapter_screen.dart';
import 'dialogs_home_screen.dart';

HomeScreenController homeScreenController = HomeScreenController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Query _ref;
  @override
  void initState() {
    homeScreenController.getData(
        finalSelectedClass ?? 0, finalSelectedBoard ?? 1);
    log(finalSelectedBoard.toString());
    log(finalSelectedClass.toString());

    homeScreenController.isActivated(isUserActive);
    // checkRooted();
    // getSubjectList();
    // purchasePremiumDialog();
    // Future.delayed(Duration(seconds: 0)).then((_) {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (builder) {
    //         return Container(
    //           height: 700.w,
    //           child: Column(
    //             children: const [
    //               Text("Select Class"),
    //               // ClassSelectionScreen(),
    //             ],
    //           ),
    //         );
    //       });
    // });
    // _ref = FirebaseDatabase.instance.ref().child('CBSE/0/Class9/1/');
    // .orderByChild('subjectName');
    super.initState();
  }

  // sharedData() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   int? value = sharedPreferences.getInt("isActivated");
  //   if (value == null) {
  //     homeScreenController.isActivated.value = 0;
  //   } else if (value == 1) {
  //     homeScreenController.isActivated.value = 1;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // sharedData();
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          body: Obx(
            () => Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/rm222batch2-mind-03 1.png",
                      ))),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(
                  vertical: 20.w,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StudentName(),

                      Heading(
                        title: 'Online Courses',
                      ),
                      GestureDetector(
                          onTap: () {
                            // Get.to(const BookTrailScreen());
                          },
                          child: const BannerContainer()),
                      Heading(
                        title: 'Subjects',
                      ),

                      homeScreenController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppTheme.appBlue,
                              ),
                            )
                          : homeScreenController.data.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No Subjects..",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                )
                              : subjectListview(),

                      // Container(
                      //   height: 300.w,
                      //   color: Colors.red,
                      //   child: FirebaseAnimatedList(
                      //       query: _ref,
                      //       itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      //           Animation<double> animation, int index) {
                      //         return CustomCard(
                      //           subjectName: snapshot.value.toString(),
                      //           // subjectName: '',
                      //           svgPicturePath: 'assets/svgs/physics_icon.svg',
                      //           onTap: () {
                      //             // Get.to(const ChapterScreen());
                      //             print(snapshot.value.toString());
                      //           },
                      //         );
                      //       }),
                      // )

                      // CustomCard(
                      //   subjectName: 'physics',
                      //   svgPicturePath: 'assets/svgs/physics_icon.svg',
                      //   onTap: () {
                      //     // Get.to(const ChapterScreen());
                      //     _ref.onValue.listen((event) {
                      //       final data = event.snapshot.value;
                      //       print(data);
                      //     });
                      //   },
                      // ),
                      // CustomCard(
                      //   subjectName: 'Chemistry',
                      //   svgPicturePath: 'assets/svgs/chemistry_icon.svg',
                      //   onTap: () {
                      //     Get.to(const ChapterScreen());
                      //   },
                      // ),
                      // CustomCard(
                      //   subjectName: 'Biology',
                      //   svgPicturePath: 'assets/svgs/biology_icon.svg',
                      //   onTap: () {
                      //     Get.to(const ChapterScreen());
                      //   },
                      // ),
                      // CustomCard(
                      //   subjectName: 'Mathematics',
                      //   svgPicturePath: 'assets/svgs/maths_icon.svg',
                      //   onTap: () {
                      //     Get.to(const ChapterScreen());
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  subjectListview() {
    // final classes = FirebaseFirestore.instance
    //     .collection("CBSE/Class10/subject")
    //     .snapshots();

    // return StreamBuilder(
    //     stream: classes,
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: homeScreenController.data.length,
        itemBuilder: (context, index) {
          return CustomCard(
              svgPicturePath: homeScreenController.data[index].subjectName ==
                      "CHEMISTRY"
                  ? "assets/svgs/chemistry_icon.svg"
                  : homeScreenController.data[index].subjectName == "BIOLOGY"
                      ? "assets/svgs/biology_icon.svg"
                      : homeScreenController.data[index].subjectName ==
                              "PHYSICS"
                          ? "assets/svgs/physics_icon.svg"
                          : homeScreenController.data[index].subjectName ==
                                  "MATHEMATICS"
                              ? "assets/svgs/maths_icon.svg"
                              : "assets/svgs/physics_icon.svg",
              subjectName: homeScreenController.data[index].subjectName,
              onTap: () {
                final subjectName =
                    homeScreenController.data[index].subjectName ?? "";

                // final selectedSubject =
                //     snapshot.data.docs[index]['subjectName'];
                final subjectIcon = homeScreenController
                            .data[index].subjectName ==
                        "CHEMISTRY"
                    ? "assets/svgs/chemistry_icon.svg"
                    : homeScreenController.data[index].subjectName == "BIOLOGY"
                        ? "assets/svgs/biology_icon.svg"
                        : homeScreenController.data[index].subjectName ==
                                "PHYSICS"
                            ? "assets/svgs/physics_icon.svg"
                            : homeScreenController.data[index].subjectName ==
                                    "MATHEMATICS"
                                ? "assets/svgs/maths_icon.svg"
                                : "assets/svgs/physics_icon.svg";
                // print(index + 1);
                Get.to(
                  ChapterScreen(
                    subjectName: subjectName,
                    subjectIcon: subjectIcon,
                    index: index,
                    model: homeScreenController.data[index],
                  ),
                );
              });
        },
      ),
    );
    // });
  }
}

//signed student name ,get premium button and logout button
class StudentName extends StatelessWidget {
  const StudentName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20.w,
            bottom: 20.w,
          ),
          child: Text(
            'Hi, $finalUserName',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 17, color: AppTheme.appBlue),
          ),
        ),
        Spacer(),
        Obx(
          () => !homeScreenController.isActivated.value
              ? //get premium button
              TextButton(
                  onPressed: () {
                    purchasePremiumDialog();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppTheme.appBlue,
                    ),
                    padding: EdgeInsets.only(
                      left: 15.w,
                      right: 15.w,
                      top: 10.h,
                      bottom: 10.h,
                    ),
                    child: Text(
                      'Get Premium',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
        //logout button
        // IconButton(
        //     onPressed: () {
        //       showDialog(
        //           context: context,
        //           builder: (BuildContext ctx) {
        //             return AlertDialog(
        //               title: const Text("Logout"),
        //               content: const Text('Are you sure?'),
        //               actions: [
        //                 TextButton(
        //                     onPressed: () async {
        //                       Get.back();
        //                     },
        //                     child: const Text(
        //                       'Cancel',
        //                       style: TextStyle(color: AppTheme.appBlue),
        //                     )),
        //                 TextButton(
        //                     onPressed: () async {
        //                       SharedPreferences prefs =
        //                           await SharedPreferences.getInstance();
        //                       await prefs.remove("phoneNumber");
        //                       await prefs.remove("userName");
        //                       await prefs.remove("schoolName");
        //                       await prefs.remove("address");
        //                       await prefs.remove("selectedClass");
        //                       await prefs.remove("selectedBoard");
        //                       await prefs.setInt("isActivated", 0);

        //                       Get.offAll(const LoginScreen());
        //                     },
        //                     child: const Text(
        //                       'Confirm',
        //                       style: TextStyle(color: AppTheme.appBlue),
        //                     ))
        //               ],
        //             );
        //           });
        //     },
        //     icon: const Icon(
        //       Icons.logout,
        //       color: Colors.black54,
        //     )),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  VoidCallback? onTap;
  String? svgPicturePath;
  String? subjectName;

  CustomCard({
    Key? key,
    required this.onTap,
    this.svgPicturePath,
    this.subjectName,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: 30.w,
          ),
          width: double.maxFinite,
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
                    top: 20.w, left: 20.w, right: 15.w, bottom: 20.w),
                width: 60.w,
                height: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppTheme.appBlue,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: SvgPicture.asset(
                    svgPicturePath!,
                    // "assets/svgs/chemistry_icon.svg",
                    color: AppTheme.appWhite,
                  ),
                ),
              ),
              Container(
                width: 210.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subjectName ?? "",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 30.sp,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//online class ad banner
class BannerContainer extends StatelessWidget {
  const BannerContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: 10.w,
        ),
        // width: 350.w,
        height: 200.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.r,
          ),
        ),
        // color: Colors.red,
        child: const ClipRRect(
          child: Image(
            image: AssetImage(
              'assets/images/banner.png',
            ),
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

//Heading only
class Heading extends StatelessWidget {
  String? title;
  Heading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.w,
      ),
      child: Text(
        title!,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.appGrey),
      ),
    );
  }
}
// Future getSubjectList() async {
//   final sharedPrefs = await SharedPreferences.getInstance();

//   final userClass = sharedPrefs.getString('USER_CLASS');
//   final userBoard = sharedPrefs.getString('USER_BOARD');

//   print(userClass);
//   print(userBoard);
// }

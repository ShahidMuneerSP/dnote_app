import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HomeScreen/home.dart';
import '../LoginScreen/login.dart';
import 'view_models/get_permissions.dart';

String? finalUserName;
String? finalPhoneNumber;
String? finalSchoolName;
String? finalAddress;
String? finalUid;
int? finalSelectedClass;
int? finalSelectedBoard;
bool isUserActive = false;

///splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  ///animation
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    ///handle permissions
    // getPermissions();

    getValidationData().whenComplete(() async {
      Timer(
          const Duration(seconds: 4),
          () => Get.offAll(finalPhoneNumber == null
              ? const LoginScreen()
              : const HomeScreen()));
    });

    ///animation
    // Create an AnimationController
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final obtainUserName = sharedPreferences.getString("userName");
    final obtainphoneNumber = sharedPreferences.getString("phoneNumber");
    final obtainSchoolName = sharedPreferences.getString("schoolName");
    final obtainAddress = sharedPreferences.getString("address");
    final obtainSelectedClass = sharedPreferences.getInt("selectedClass");
    final obtainSelectedBoard = sharedPreferences.getInt("selectedBoard");
    final obtainUid = sharedPreferences.getString("uid");
    final isActive = sharedPreferences.getBool("isUserActive");

    if (isActive != null) isUserActive = isActive;

    finalUserName = obtainUserName;
    finalPhoneNumber = obtainphoneNumber;
    finalSchoolName = obtainSchoolName;
    finalAddress = obtainAddress;
    finalSelectedClass = obtainSelectedClass;
    finalSelectedBoard = obtainSelectedBoard;
    finalUid = obtainUid;
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 2.0),
                    end: Offset.zero,
                  ).animate(_animationController),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/logos/vidya logo.png",
                          width: 170.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200.h,
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(_animationController),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "In Association With",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Image.asset(
                        "assets/logos/logo_dnote.png",
                        width: 200.r,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // child: Stack(
          //   children: [
          //     Align(
          //       alignment: Alignment.center,
          // child: FadeTransition(
          //   opacity: _fadeAnimation,
          //   child: SlideTransition(
          //     position: Tween<Offset>(
          //       begin: Offset(0.0, 2.0),
          //       end: Offset.zero,
          //     ).animate(_animationController),
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: [
          //           Image.asset(
          //             "assets/logos/vidya logo.png",
          //             width: 160.r,
          //           ),
          //           SizedBox(
          //             height: 50.h,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomCenter,
          // child: FadeTransition(
          //   opacity: _fadeAnimation,
          //   child: SlideTransition(
          //     position: Tween<Offset>(
          //       begin: Offset(0.0, 1.0),
          //       end: Offset.zero,
          //     ).animate(_animationController),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Text(
          //           "In Association With",
          //           style: TextStyle(
          //             fontSize: 10.sp,
          //             color: Colors.black87,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 15.h,
          //         ),
          //         Image.asset(
          //           "assets/logos/logo_dnote.png",
          //           width: 200.r,
          //         ),
          //         SizedBox(
          //           height: 150.h,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the animation controller to free up resources
    _animationController.dispose();
    super.dispose();
  }
}

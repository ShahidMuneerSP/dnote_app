import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_root_jailbreak/flutter_root_jailbreak.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';

//disable screenshot and screen video
Future<void> secureScreen() async {
  if (Platform.isAndroid) {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
}

//check if the phone is rooted
Future<void> checkRooted() async {
  bool isRooted = false;
  try {
    if (Platform.isAndroid) {
      isRooted = await FlutterRootJailbreak.isRooted;
    }
  } catch (e) {
    debugPrint("=====error: isRooted======");
  }
  print(
      '========================================================= : rooted : ' +
          isRooted.toString());
  if (isRooted) {
    Get.defaultDialog(
      barrierDismissible: false,
      title: 'Rooted..!',
      content: const Text(
          'Your Phone is Rooted, So you can\'t use this app on your device..'),
      contentPadding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 15.h,
        bottom: 10.h,
      ),
      titlePadding: EdgeInsets.only(top: 20.h),
      actions: [
        TextButton(
          onPressed: () {
            exit(0);
          },
          child: Text(
            'OK',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        ),
      ],
    );
  }
}

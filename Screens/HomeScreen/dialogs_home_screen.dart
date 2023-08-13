import 'package:dnote_2_0/Screens/HomeScreen/home.dart';
import 'package:dnote_2_0/Screens/PurchaseScreen/purchase_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../verification_screen.dart/verification_screen.dart';

purchasePremiumDialog() {
  Future.delayed(const Duration(seconds: 1), () {
    Get.defaultDialog(
        title: 'Get Premium?',
        content: const Text(
            'If you purchased our product go for premium. If not, choose demo lectures..'),
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
                Get.back();
              },
              child: Text(
                'USE DEMO',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )),
          TextButton(
              onPressed: () {
                // studentConfirmDialog();

                Get.back();
                Get.to(VerificationScreen(
                  homeScreenController: homeScreenController,
                ));
              },
              child: Text(
                'GET PREMIUM',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              )),
        ]);
  });
}

studentConfirmDialog() {
  Future.delayed(const Duration(seconds: 1), () {
    Get.defaultDialog(
        title: 'Get Premium..!',
        content: const Text('Are you a student at Hybrid Learning Centre?'),
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
              Get.off(VerificationScreen(
                homeScreenController: homeScreenController,
              ));
            },
            child: Text(
              'YES',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.off(const PurchaseScreen());
            },
            child: Text(
              'NO',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ]);
  });
}

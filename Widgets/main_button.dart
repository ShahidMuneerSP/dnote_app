import 'package:dnote_2_0/Theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainButton extends StatelessWidget {
  MainButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  VoidCallback? onTap;
  String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.w,
        ),
        width: 300.w,
        decoration: BoxDecoration(
          color: AppTheme.appBlue,
          borderRadius: BorderRadius.circular(
            20.r,
          ),
        ),
        child: Center(
          child: Text(
            title!,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

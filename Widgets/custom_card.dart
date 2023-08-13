import 'package:dnote_2_0/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: 30.w,
          ),
          width: 320.w,
          height: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppTheme.appWhite,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 7,
                spreadRadius: 1,
              ),
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
                      subjectName!,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassSelectionSheet extends StatefulWidget {
  const ClassSelectionSheet({Key? key}) : super(key: key);

  @override
  State<ClassSelectionSheet> createState() => _ClassSelectionSheetState();
}

class _ClassSelectionSheetState extends State<ClassSelectionSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 18.w,
            right: 18.w,
          ),
          child: Container(
            height: 400.h,
            child: GridView.builder(
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 15,
                childAspectRatio: (3 / 1),
              ),
              itemBuilder: (
                context,
                index,
              ) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.w, horizontal: 8.w),
                    width: 117.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                    child: Center(
                      child: Text(
                        // course[index].title,
                        's',
                        style: TextStyle(
                          fontSize: 11.sp,
                          //   color: course[index].isSelected == true
                          //       ? Colors.white
                          //       : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

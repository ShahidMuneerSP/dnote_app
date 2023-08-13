import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../DummyData/purchase_screen_dummy_data.dart';
import '../../Theme/theme.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.1),
            image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/images/rm222batch2-mind-03 1.png",
                )),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Courses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.black87,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              coursesListView(size)
            ],
          ),
        ),
      ),
    );
  }

  coursesListView(Size size) {
    final classes = FirebaseFirestore.instance
        .collection("CBSE/Class10/subject")
        .snapshots();
    return StreamBuilder(
        stream: classes,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: purchaseScreenData.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomCardNewWidget(
                    size: size,
                    className: purchaseScreenData[index]['courseName'],
                    bannerPath: purchaseScreenData[index]['bannerPath'],
                    price: purchaseScreenData[index]['price'],
                    description: purchaseScreenData[index]['description'],
                    onTap: () {});
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            ),
          );
        });
  }
}

// ignore: must_be_immutable
class CustomCardNewWidget extends StatelessWidget {
  VoidCallback? onTap;
  String? bannerPath;
  String? className;
  String? description;
  String? price;
  CustomCardNewWidget({
    required this.onTap,
    this.bannerPath,
    this.className,
    this.price,
    this.description,
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(bannerPath ??
                        'https://imgeng.jagran.com/images/2022/mar/svave1646279559095.jpg'))),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              className ?? 'Class Name',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Text(
              description ?? 'Description',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.appBlue,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      price ?? '5000',
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.appBlue,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                TextButton(
                  onPressed: onTap,
                  // onPressed: onTap,
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
                      'Purchase Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomCardWidget extends StatelessWidget {
  VoidCallback? onTap;
  String? bannerPath;
  String? className;
  String? description;
  String? price;
  CustomCardWidget({
    required this.onTap,
    this.bannerPath,
    this.className,
    this.price,
    this.description,
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 130,
            // width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(bannerPath ??
                        'https://imgeng.jagran.com/images/2022/mar/svave1646279559095.jpg'))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Text(
                  className ?? 'Class Name',
                  style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.appBlue),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 10.h, right: 10.w),
                  child: Container(
                    width: 210.w,
                    child: Text(
                      description ?? 'Description',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black54,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 25.h, left: 10.w),
                child: Row(
                  children: [
                    Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      price ?? '5000',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.h, bottom: 3.h),
                child: TextButton(
                    onPressed: onTap,
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
                        'Purchase Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
    // return ClipRRect(
    // borderRadius: BorderRadius.circular(10.0),
    // child: Container(
    //   child: Stack(children: [
    //     Material(
    //       child: Container(
    //         height: 200.h,
    //         width: size.width ,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.circular(10.0),
    //         ),
    //       ),
    //     ),
    // Positioned(
    //   top: 0,
    //   bottom: 0,
    //   child: Row(
    //     children: [
    // Card(
    //   shadowColor: Colors.grey.withOpacity(0.5),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   child: Container(
    //               height: 200.h,
    //               width: 150.w,
    //               decoration: BoxDecoration(
    //       //             borderRadius: BorderRadius.circular(10.0),
    //                   image: DecorationImage(
    //                       fit: BoxFit.fill,
    //                       image: NetworkImage(bannerPath ??
    //                           'https://imgeng.jagran.com/images/2022/mar/svave1646279559095.jpg'))),
    //             ),
    //       ),
    //     Container(
    //       height: 200.h,
    //       padding: EdgeInsets.all(5.w),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           SizedBox(
    //             height: 10.h,
    //           ),
    //           Text(
    //             className ?? 'Class Name',
    //             style: TextStyle(
    //               fontSize: 17.sp,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10.h,
    //           ),
    //           Container(
    //             width: 200.w,
    //             child: Text(
    //               description ?? 'Description',
    //               style: TextStyle(
    //                 fontSize: 15.sp,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //             ),
    //           ),
    //           Spacer(),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Row(
    //                 children: [
    //                   Text(
    //                     '₹',
    //                     style: TextStyle(
    //                       fontSize: 18.sp,
    //                       fontWeight: FontWeight.bold,
    //                       color: AppTheme.appBlue,
    //                     ),
    //                   ),
    //                   const SizedBox(width: 2),
    //                   Text(
    //                     price ?? '5000',
    //                     style: TextStyle(
    //                       fontSize: 18.sp,
    //                       fontWeight: FontWeight.bold,
    //                       color: AppTheme.appBlue,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(
    //                 width: 20.w,
    //               ),
    //               TextButton(
    //                 onPressed: onTap,
    //                 // onPressed: onTap,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10.r),
    //                     color: AppTheme.appBlue,
    //                   ),
    //                   padding: EdgeInsets.only(
    //                     left: 15.w,
    //                     right: 15.w,
    //                     top: 10.h,
    //                     bottom: 10.h,
    //                   ),
    //                   child: Text(
    //                     'Purchase Now',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 12.sp,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 5.w,
    //               )
    //             ],
    //           ),
    //         ],
    //         ),
    // ),
    //           ],
    //         ),
    //       )
    //     ]),
    //   ),
    // );
  }
}

// courseListView() {
//   final classes =
//       FirebaseFirestore.instance.collection("CBSE/Class10/subject").snapshots();

//   return StreamBuilder(
//       stream: classes,
//       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         return Expanded(
//           child: ListView.builder(
//             physics: BouncingScrollPhysics(),
//             itemCount: purchaseScreenData.length,
//             itemBuilder: (context, index) {
//               return CustomCard(
//                   // subjectName: snapshot.data.docs[index]['subjectName'],
//                   className: purchaseScreenData[index]['courseName'],
//                   bannerPath: purchaseScreenData[index]['bannerPath'],
//                   price: purchaseScreenData[index]['price'],
//                   description: purchaseScreenData[index]['description'],
//                   onTap: () {
//                     // final selectedSubject =
//                     // snapshot.data.docs[index]['subjectName'];
//                     // final subjectIcon = snapshot.data.docs[index]['iconPath'];
//                     // print(index + 1);
//                     // Get.to(ChapterScreen(), arguments: {
//                     //   'selectedsubject': selectedSubject,
//                     //   'subjectIcon': subjectIcon,
//                     //   'index': index + 1
//                     // });
//                   });
//             },
//           ),
//         );
//       });
// }

// class CustomCard extends StatelessWidget {
//   VoidCallback? onTap;
//   String? bannerPath;
//   String? className;
//   String? description;
//   String? price;

//   CustomCard({
//     Key? key,
//     required this.onTap,
//     this.bannerPath,
//     this.className,
//     this.price,
//     this.description,
//   }) : super(key: key);

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.only(
//         bottom: 20.w,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.r),
//         color: AppTheme.appWhite,
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 7,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           //  Stack(
//           //    children: [
//           //      Container(
//           //          child: Positioned.fill(
//           //            child: ClipRRect(
//           //              borderRadius: BorderRadius.circular(15.0),
//           //              child: Image.network(bannerPath??"https://imgeng.jagran.com/images/2022/mar/svave1646279559095.jpg")
//           //            ),
//           //          ),
//           //          ),
//           //    ],
//           //  ),
//           Positioned.fill(
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10.r),
//                 bottomLeft: Radius.circular(10.r),
//               ),
//               child: Image.network(
//                 bannerPath ??
//                     'https://imgeng.jagran.com/images/2022/mar/svave1646279559095.jpg',
//                 // height: 160.h,
//                 width: 150.w,
//                 // fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(12.w),
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     className ?? 'Class Name',
//                     style: TextStyle(
//                       fontSize: 17.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Container(
//                     width: 200.w,
//                     child: Text(
//                       description ?? 'Description',
//                       // overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             '₹',
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                               color: AppTheme.appBlue,
//                             ),
//                           ),
//                           const SizedBox(width: 2),
//                           Text(
//                             price ?? '5000',
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                               color: AppTheme.appBlue,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         width: 30.w,
//                       ),
//                       TextButton(
//                         onPressed: onTap,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.r),
//                             color: AppTheme.appBlue,
//                           ),
//                           padding: EdgeInsets.only(
//                             left: 15.w,
//                             right: 15.w,
//                             top: 10.h,
//                             bottom: 10.h,
//                           ),
//                           child: Text(
//                             'Purchase Now',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:dnote_2_0/models/boards_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Widgets/main_button.dart';
import '../../animations/animated_content.dart';
import '../../apis/boards/get_all_boards.dart';
import '../ClassSelectionScreen/classSelection.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;
  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  String? selectedBoard;

  List boardListItem = [];
  List<BoardsModel>? boardList = [];
  @override
  void initState() {
    getBoardData();
    super.initState();
  }

  getBoardData() async {
    boardList = await getAllBoards();
    boardListItem.clear();
    boardList?.forEach((element) {
      boardListItem.add(element.boardName.toString());
    });

    setState(() {});
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
              )),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.w,
                      bottom: 20.w,
                    ),
                    child: Text(
                      'Select Board',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 320.h,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      "assets/svgs/End of school-rafiki.svg",
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AnimatedContent(
                    show: true,
                    leftToRight: 0.0,
                    topToBottom: 5.0,
                    time: 2000,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0.r),
                        border: Border.all(color: Colors.grey),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            isExpanded: true,
                            hint: const Text("Select your board",
                                style: TextStyle(color: Colors.black)),
                            value: selectedBoard,
                            items: boardListItem.map((category) {
                              return DropdownMenuItem(
                                  value: category, child: Text(category));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBoard = value.toString();
                              });
                            }),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 70.w,
                    ),
                    child: MainButton(
                      onTap: () {
                        int boardId = 0;
                        boardList?.forEach((element) {
                          // ignore: unrelated_type_equality_checks
                          if (element.boardName == selectedBoard) {
                            boardId = element.id ?? 1;
                          }
                        });
                        print(boardId.toString());

                        if (boardId != null) {
                          Get.offAll(
                            ClassSelectionScreen(
                              boardId: boardId,
                              uid: widget.uid.toString(),
                            ),
                          );
                        } else {
                          Get.snackbar(
                            '',
                            'Select board',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.black,
                            colorText: Colors.white,
                          );
                        }
                      },
                      title: 'Submit',
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

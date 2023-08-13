import 'package:dnote_2_0/Controller/quizScreenController.dart';
import 'package:dnote_2_0/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../DummyData/dummy_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

QuizScreenController quizScreenController = QuizScreenController();
PageController pageController = PageController(
  initialPage: quizScreenController.currentIndex.toInt(),
);

List<Map<String, dynamic>> quizQuestions = [];

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 3;

  @override
  void initState() {
    super.initState();

    for (var value in quiz) {
      quizQuestions.add({
        'question': value,
        'isAttended': 0,
        'selectedOption': 0,
      });
    }
  }

  @override
  void dispose() {
    quizQuestions.clear();
    quizScreenController.updateCurrentIndex(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.appWhite,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              const appBar(),
              questionCount(quizScreenController.currentIndex.toInt()),
              const Divider(
                color: AppTheme.appBlue,
                thickness: 0.7,
              ),
              questionPageView(
                  quizScreenController.currentIndex.toInt(), quizQuestions),
            ],
          ),
        ),
      ),
    );
  }
}

class questionPageView extends StatelessWidget {
  questionPageView(this.currentIndex, this.quizQuestions1, {Key? key})
      : super(key: key);
  int currentIndex;
  List<Map<String, dynamic>> quizQuestions1;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        onPageChanged: quizScreenController.updateCurrentIndex,
        itemCount: quizQuestions.length,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemBuilder: (context, index) {
          var _data = quizQuestions[index]['question'];
          String? _question = _data.Question;
          List<String> _options = [
            'A.  ' + _data.op1.toString(),
            'B.  ' + _data.op2.toString(),
            'C.  ' + _data.op3.toString(),
            'D.  ' + _data.op4.toString(),
          ];
          String _ans = _data.ans.toString();
          int _ansOption = 0;

          if (_ans == _data.op1) {
            _ansOption = 1;
          } else if (_ans == _data.op2) {
            _ansOption = 2;
          } else if (_ans == _data.op3) {
            _ansOption = 3;
          } else if (_ans == _data.op4) {
            _ansOption = 4;
          }

          return Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  quiz[index].id.toString() + '.',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  _question!,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                optionsView(_options, _ansOption, currentIndex),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 80.w,
                          width: 80.w,
                          child: TextButton(
                            onPressed: () {
                              if (currentIndex != 0) {
                                pageController.jumpToPage(currentIndex - 1);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(18.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: index == 0
                                      ? Colors.black26
                                      : AppTheme.appBlue,
                                ),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  color: index == 0
                                      ? Colors.black26
                                      : AppTheme.appBlue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80.w,
                          width: 80.w,
                          child: TextButton(
                            onPressed: () {
                              if (currentIndex != quiz.length - 1) {
                                pageController.jumpToPage(currentIndex + 1);
                              }

                              print(
                                  '++++++++++++++++++++++++++++++++++++++ : ' +
                                      quizQuestions.length.toString());
                            },
                            child: Container(
                              padding: EdgeInsets.all(18.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: index == quizQuestions.length - 1
                                      ? Colors.black26
                                      : AppTheme.appBlue,
                                ),
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: index == quizQuestions.length - 1
                                      ? Colors.black26
                                      : AppTheme.appBlue,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class optionsView extends StatefulWidget {
  optionsView(this.options, this._ansOption, this.currentIndex, {Key? key})
      : super(key: key);
  List<String> options;
  final int _ansOption;
  int currentIndex;

  @override
  State<optionsView> createState() => _optionsViewState();
}

class _optionsViewState extends State<optionsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          widget.options.length,
          (index) => GestureDetector(
            onTap: () {
              if (quizQuestions[widget.currentIndex]['isAttended'] == 0) {
                index == widget._ansOption - 1
                    ? quizQuestions[widget.currentIndex]['isAttended'] = 1
                    : quizQuestions[widget.currentIndex]['isAttended'] = 2;

                quizQuestions[widget.currentIndex]['selectedOption'] =
                    index + 1;
              }

              quizScreenController.updateCurrentIndex(widget.currentIndex);
              setState(() {});
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                  left: 25.w, right: 15.w, top: 18.h, bottom: 18.h),
              margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
              decoration: BoxDecoration(
                border: quizQuestions[widget.currentIndex]['selectedOption'] ==
                        0
                    ? Border.all(color: Colors.black12, width: 1)
                    : quizQuestions[widget.currentIndex]['selectedOption'] ==
                            index + 1
                        ? widget._ansOption == index + 1
                            ? Border.all(color: Colors.green.shade900, width: 2)
                            : Border.all(color: Colors.red.shade900, width: 2)
                        : widget._ansOption == index + 1
                            ? Border.all(color: Colors.green.shade900, width: 2)
                            : Border.all(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Text(
                widget.options[index],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class questionCount extends StatelessWidget {
  questionCount(this.currentIndex, {Key? key}) : super(key: key);

  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 10.w, right: 10.w, top: 30.h, bottom: 10.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(
            quiz.length,
            (index) {
              int isAttended = quizQuestions[index]['isAttended'];

              return Container(
                height: 40.w,
                width: 40.w,
                margin: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  border: isAttended != 0
                      ? Border.all(color: AppTheme.appBlue, width: 1.5)
                      : null,
                  borderRadius: BorderRadius.circular(100.r),
                  color: currentIndex == index
                      ? AppTheme.appBlue
                      : AppTheme.appWhite,
                ),
                child: currentIndex == index
                    ? Center(
                        child: Text(
                          quiz[index].id.toString(),
                          style: TextStyle(
                            color: currentIndex == index
                                ? AppTheme.appWhite
                                : AppTheme.appBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      )
                    : isAttended == 0
                        ? Center(
                            child: Text(
                              quiz[index].id.toString(),
                              style: TextStyle(
                                color: currentIndex == index
                                    ? AppTheme.appWhite
                                    : AppTheme.appBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          )
                        : Center(
                            child: SvgPicture.asset(
                              'assets/svgs/checked.svg',
                              color: currentIndex == index
                                  ? AppTheme.appWhite
                                  : AppTheme.appBlue,
                            ),
                          ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class appBar extends StatelessWidget {
  const appBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          TextButton(
            onPressed: () {
              quizScreenController.updateCurrentIndex(5);
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 8.h, bottom: 8.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.appBlue,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  color: AppTheme.appBlue,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

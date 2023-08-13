import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dnote_2_0/Controller/classSelectionScreenController.dart';
import 'package:dnote_2_0/Screens/HomeScreen/home.dart';
import 'package:dnote_2_0/Screens/OtpScreen/otp.dart';
import 'package:dnote_2_0/Screens/splash/splash_screen.dart';
import 'package:dnote_2_0/Theme/theme.dart';
import 'package:dnote_2_0/Widgets/main_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:dnote_2_0/Controller/userController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apis/user/create_user_api.dart';

ClassSelectionScreenController classSelectionScreenController =
    ClassSelectionScreenController();
String? classesDataId;
int? selectedClassIndex;
int? selectedBoardIndex;
String? selectedClassName;
bool? isSelected;

TextEditingController schoolNameController = TextEditingController();
final Mycontroller controller = Get.put(Mycontroller());

class ClassSelectionScreen extends StatefulWidget {
  const ClassSelectionScreen(
      {Key? key, required this.uid, required this.boardId})
      : super(key: key);
  final String uid;
  final int boardId;
  @override
  State<ClassSelectionScreen> createState() => _ClassSelectionScreenState();
}

class _ClassSelectionScreenState extends State<ClassSelectionScreen> {
  late DatabaseReference userDetails;
  @override
  void initState() {
    super.initState();
    print('init methiod');
    print(widget.boardId);

    print(classSelectionScreenController.data.length);
    classSelectionScreenController.getData(widget.boardId);
    // classSelectionScreenController.getBoardData();
    userDetails = FirebaseDatabase.instance.ref().child('users');
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
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _selectClassText(),
                    classGridview(),
                    //submit button
                    Padding(
                      padding: EdgeInsets.only(
                        top: 100.w,
                      ),
                      child: MainButton(
                        onTap: () async {
                          if (selectedBoardIndex != null &&
                              selectedClassIndex != null) {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            await sharedPreferences.setString(
                                "userName", userName ?? "");
                            await sharedPreferences.setString(
                                "phoneNumber", phoneNumber ?? "");
                            await sharedPreferences.setString(
                                "address", address ?? "");
                            await sharedPreferences.setString(
                                "schoolName", schoolName ?? "");
                            await sharedPreferences.setString(
                                "uid", widget.uid.toString());
                            await sharedPreferences.setInt(
                                "selectedClass", selectedClassIndex ?? 0);
                            await sharedPreferences.setInt(
                                "selectedBoard", selectedBoardIndex ?? 0);

                            log("value is");
                            final value =
                                sharedPreferences.getInt("selectedClass");
                            final newValue =
                                sharedPreferences.getInt("selectedBoard");
                            log(value.toString());
                            log(newValue.toString());

                            log(userName.toString());
                            log(phoneNumber.toString());
                            log(address.toString());
                            log(schoolName.toString());
                            log(selectedClassIndex.toString());
                            log(selectedBoardIndex.toString());
                            finalUserName = userName;
                            finalPhoneNumber = phoneNumber;
                            finalAddress = address;
                            finalSchoolName = schoolName;
                            finalUid = widget.uid;
                            finalSelectedClass = selectedClassIndex;
                            finalSelectedBoard = selectedBoardIndex;

                            // setFullUserDetailToDB();
                            // log(setFullUserDetailToDB().toString());
                            addClassAndBoard();
                            bool data = await createUsersApi(
                                finalUserName.toString(),
                                finalPhoneNumber.toString(),
                                finalAddress.toString(),
                                selectedClassName.toString(),
                                finalSchoolName.toString(),
                                widget.boardId.toString());
                            log(data.toString());
                            print(data.toString());
                            if (data == true) {
                              print("User Created Successfully");
                              Get.offAll(
                                const HomeScreen(),
                                // arguments: [
                                //   {'selectedClass': '$selectedClassIndex'},
                                // ],
                              );
                            } else {
                              Get.snackbar(
                                '',
                                'Select class',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.black,
                                colorText: Colors.white,
                              );
                            }
                          }
                        },
                        title: 'Submit',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // ),
      // ),
    );
  }

  Future<void> addClassAndBoard() {
    CollectionReference classAndBoard =
        FirebaseFirestore.instance.collection('users');

    return classAndBoard
        .add({'class': selectedClassIndex, 'board': selectedBoardIndex})
        .then((value) => print("select class"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // Future<void> addUserDetails() {
  //   final userDB = FirebaseDatabase.instance.ref('users');

  //   return userDB.ref.set({
  //     'name': '',
  //     'phoneNumber': '',
  //     'location': '',
  //     'schoolName': schoolNameController.text,
  //     'class': selectedClassIndex,
  //     'board': selectedBoardIndex
  //   });
  // }

  classGridview() {
    // final classes =
    //     FirebaseFirestore.instance.collection("classes").snapshots();
    // return
    //  StreamBuilder(
    //     stream: classes,
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //       if (!snapshot.hasData) {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }

    return SizedBox(
      height: 600.h,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),

        itemCount: classSelectionScreenController.data.length,
        // itemCount: snapshot.data.docs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 150,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                print(classSelectionScreenController.data[index].className
                    .toString());
                selectedClassName =
                    classSelectionScreenController.data[index].className ?? "";
                selectedBoardIndex =
                    classSelectionScreenController.data[index].boardsId;
                print(selectedClassIndex);
                selectedClassIndex =
                    classSelectionScreenController.data[index].id;
              });
            },
            child: Container(
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color:

                    // ignore: unrelated_type_equality_checks
                    selectedClassIndex ==
                            classSelectionScreenController.data[index].id
                        ? AppTheme.appBlue
                        : const Color.fromARGB(255, 232, 226, 226),
                // : const Color.fromARGB(255, 204, 194, 194),
                borderRadius: BorderRadius.circular(20),
              ),
              child: classSelectionScreenController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.appBlue,
                      ),
                    )
                  : classSelectionScreenController.data.isEmpty
                      ? const Center(
                          child: Text(
                            "Classes not found!!",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      : Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "CLASS",
                                style: TextStyle(
                                    color: selectedClassIndex ==
                                            classSelectionScreenController
                                                .data[index].id
                                        ? Colors.white
                                        : AppTheme.appBlue,
                                    fontSize: 18.sp),
                              ),
                              const Spacer(),
                              Text(
                                classSelectionScreenController
                                        .data[index].className ??
                                    "",
                                style: TextStyle(
                                    fontSize: 35.sp,
                                    color: selectedClassIndex ==
                                            classSelectionScreenController
                                                .data[index].id
                                        ? Colors.white
                                        : AppTheme.appBlue,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              Text("Science & Maths",
                                  style: TextStyle(
                                      color: selectedClassIndex ==
                                              classSelectionScreenController
                                                  .data[index].id
                                          ? Colors.white
                                          : AppTheme.appBlue,
                                      fontSize: 18.sp)),
                              SizedBox(
                                height: 5.h,
                              )
                            ],
                          ),
                        ),
            ),
          );
        },
      ),
    );
    // });
  }

  Padding _selectClassText() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.w,
        bottom: 20.w,
      ),
      child: Text(
        'Select your class',
        style: TextStyle(
            color: Colors.black, fontSize: 22.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  // schoolNameInputField() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       top: 20.h,
  //       left: 28.w,
  //       right: 28.w,
  //     ),
  //     child: TextFormField(
  //       controller: schoolNameController,

  //       validator: (val) {
  //         if (val!.isNotEmpty && val.length > 2) {
  //           return null;
  //         } else if (val.length < 2 && val.isNotEmpty) {
  //           return 'Name must be more than 2 letters';
  //         } else {
  //           return 'Enter the valid name';
  //         }
  //       },
  //       autovalidateMode: AutovalidateMode.onUserInteraction,

  //       decoration: const InputDecoration(
  //         prefixIcon: Icon(
  //           MdiIcons.officeBuilding,
  //           color: AppTheme.appBlue,
  //         ),
  //         floatingLabelBehavior: FloatingLabelBehavior.auto,
  //         labelText: 'School Name',
  //         labelStyle: TextStyle(color: Colors.black54),
  //         border: OutlineInputBorder(),
  //       ),
  //       keyboardType: TextInputType.name,
  //       textInputAction: TextInputAction.done,
  //       // obscureText: ,
  //     ),
  //   );
  // }

  // getClassesFromFB() {
  //   CollectionReference classes =
  //       FirebaseFirestore.instance.collection('classes');

  //   return FutureBuilder<DocumentSnapshot>(
  //     future: classes.doc(classesDataId).get(),
  //     builder:
  //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text("Something went wrong");
  //       }

  //       if (snapshot.hasData && !snapshot.data!.exists) {
  //         return Text("Document does not exist");
  //       }

  //       if (snapshot.connectionState == ConnectionState.done) {
  //         Map<String, dynamic> data =
  //             snapshot.data!.data() as Map<String, dynamic>;
  //         return Text("classes: ${data['class']}");
  //         // print("classes: ${data['class']}");
  //       }

  //       return Text("loading");
  //     },
  //   );
  // }

  // Future<void> setClassDetails() async {
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   sharedPrefs.setString('USER_CLASS', '$selectedClassIndex');
  //   sharedPrefs.setString('USER_BOARD', '$selectedBoardIndex');
  // }

  // Future setFullUserDetailToDB() async {
  //   setClassDetails();
  //   final sharedPrefs = await SharedPreferences.getInstance();
  //   final username = sharedPrefs.getString('USER_NAME');
  //   final userPhoneNumber = sharedPrefs.getString('USER_PHONE_NUMBER');
  //   final userLocation = sharedPrefs.getString('USER_LOCATION');
  //   final userSchoolName = sharedPrefs.getString('USER_SCHOOL_NAME');
  //   final userClass = sharedPrefs.getString('USER_CLASS');
  //   final userBoard = sharedPrefs.getString('USER_BOARD');
  //   // print(userClass);
  //   print(username);
  //   print(userPhoneNumber);
  //   print(userLocation);
  //   print(userSchoolName);
  //   print(userClass);
  //   print(userBoard);
  //   DatabaseReference userDetails =
  //       FirebaseDatabase.instance.ref().child('test');
  // userDetails.set('userClass').then((value) {
  //   print('hello');
  //   Get.to(HomeScreen());
  // });

  // await userDetails.push().set({
  //   "name": username,
  //   "phoneNumber": userPhoneNumber,
  //   "location": userLocation,
  //   "schoolName": userSchoolName,
  //   "class": userClass,
  //   "board": userBoard,
  // }).then((value) {
  //   print('hello');
  //   Get.to(const HomeScreen());
  // });

  // await userDetails.set({W
  //   'name': username,
  //   'phoneNumber': userPhoneNumber,
  //   'address': userLocation,
  //   'schoolName': userSchoolName,
  //   'class': userClass,
  //   'board': userBoard,
  // });
  // }
}

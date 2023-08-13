// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:dnote_2_0/Controller/userController.dart';
import 'package:dnote_2_0/Screens/ClassSelectionScreen/classSelection.dart';
import 'package:dnote_2_0/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:dnote_2_0/Widgets/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../BoardScreen/boardScreen.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
dynamic dataFromLogin = Get.arguments;

String? phoneNumber = dataFromLogin[0]['phoneNumber'];
String? userName = dataFromLogin[1]['userName'];
String? address = dataFromLogin[3]['address'];
String? schoolName = dataFromLogin[2]['schoolName'];
bool codeSent = false;
String? verifyId;
bool isLoading = false;
final GlobalKey<FormState> otpKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
TextEditingController otpController = TextEditingController();
final Mycontroller controller = Get.put(Mycontroller());
final FocusNode _pinPutFocusNode = FocusNode();
// CollectionReference users = FirebaseFirestore.instance.collection('users');
String? userPhoneNumber;

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    super.initState();
    userPhoneNumber = widget.phoneNumber;

    listenOtp();
  }

  listenOtp() async {
    await verifyCredential();

    // Initialize the Telephony plugin.
    // Telephony telephony = Telephony.instance;

    // bool? permissionsGranted = await telephony.requestSmsPermissions;

    // if (permissionsGranted!) {
    //   log("listening..");
    //   // Listen for incoming SMS messages.
    //   telephony.listenIncomingSms(
    //     onNewMessage: (SmsMessage message) {
    //       // Print the sender number, the SMS text, and the timestamp when SMS is received.
    //       log(message.address ?? "No address");
    //       log(message.body ?? "No body");
    //       print(message.date);
    //     },
    //     listenInBackground: false,
    //   );
    // }

    // Request SMS permission
    // final status = await Permission.sms.request();

    // if (status.isGranted) {
    //   String? otp = await listeningSms(telephony);

    //   if (otp != null) {
    //     otpController.text = otp;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/rm222batch2-mind-03 1.png",
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.w, top: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.chevron_left_sharp,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    const _TitleText(),
                    _OtpDescription(
                      phoneNumber: userPhoneNumber ?? "",
                    ),
                    const _OtpField(),
                    const OnSubmitButton()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future verifyCredential() async {
    // await auth.setSettings(forceRecaptchaFlow: false);
    //  await auth.setSettings(forceRecaptchaFlow: true);
    log(userPhoneNumber.toString());
    await auth.verifyPhoneNumber(
        phoneNumber: "+91$userPhoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              log("Done !!", name: "verificationCompleted");
            } else {
              log("Failed!!", name: "verificationCompleted");
            }
          }).catchError((e) {
            print('Something Went Wrong: ${e.toString()}');
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString());
          Get.snackbar('', '${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          log("code sent");
          setState(() {
            codeSent = true;
            verifyId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verifyId = verificationId;
          log(verifyId.toString());
        },
        timeout: const Duration(seconds: 60));
  }
}

class OnSubmitButton extends StatefulWidget {
  const OnSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  State<OnSubmitButton> createState() => _OnSubmitButtonState();
}

class _OnSubmitButtonState extends State<OnSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 100.w,
      ),
      child: MainButton(
        onTap: () async {
          try {
            await FirebaseAuth.instance
                .signInWithCredential(
              PhoneAuthProvider.credential(
                verificationId: verifyId ?? "",
                smsCode: otpController.text,
              ),
            )
                .then((value) async {
              if (value.user != null) {
                log("value is");
                log(value.user.toString());
                log((value.user?.uid).toString());
                log((value.user?.phoneNumber).toString());

                addUser();

                log(addUser().toString());

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                       BoardScreen(
                        uid: value.user!.uid.toString(), 
                      )
                      //  ClassSelectionScreen(
                      //   uid: value.user!.uid.toString(),
                      // ),
                    ),
                    (route) => false);
              }
            });
          } catch (e) {
            Get.snackbar('Invalid OTP', '$e');
          }
        },
        title: 'Submit',
      ),
    );
  }

  addUser() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();

    return users
        .add({
          "uid": uid,
          'displayName': userName,
          'phoneNumber': phoneNumber,
          'address': address,
          'schoolName': schoolName
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

class _OtpField extends StatelessWidget {
  const _OtpField({
    Key? key,
  }) : super(key: key);

  otpBoxDecoration() {
    return BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  selectedOtpBoxDecoration() {
    return BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(
        color: AppTheme.appBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 50.w,
      ),
      // color: Colors.red,
      width: MediaQuery.of(context).size.width * .8,
      child: Form(
        key: otpKey,
        child: PinPut(
          focusNode: _pinPutFocusNode,
          controller: otpController,
          fieldsCount: 6,
          eachFieldWidth: 50.w,
          eachFieldHeight: 70.w,
          withCursor: true,
          followingFieldDecoration: otpBoxDecoration(),
          submittedFieldDecoration: selectedOtpBoxDecoration(),
          selectedFieldDecoration: selectedOtpBoxDecoration(),
          validator: (value) {
            if (value!.isNotEmpty && value.length > 2) {
              return null;
            } else if (value.length < 6 && value.isNotEmpty) {
              Get.snackbar(
                '',
                'Enter valid number',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.black,
                colorText: Colors.white,
              );
            }
          },
        ),
      ),
    );
  }

  // Future<void> addUser() {
  //   // Call the user's CollectionReference to add a new user
  //   final users = FirebaseFirestore.instance.collection('users');
  //   log(users.toString());

  //   return users
  //       .add({
  //         'userName': userName,
  //         'phoneNumber': phoneNumber,
  //         'address': address,
  //         'schoolName': schoolName
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
}

class _OtpDescription extends StatelessWidget {
  final String phoneNumber;
  const _OtpDescription({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'We sent your code to your registered\n $phoneNumber',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
      maxLines: 2,
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 100.w,
        bottom: 20.w,
      ),
      child: const Center(
        child: Text(
          'OTP Verification',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dnote_2_0/Controller/homeScreenController.dart';
import 'package:dnote_2_0/Screens/HomeScreen/home.dart';
import 'package:dnote_2_0/Screens/splash/splash_screen.dart';
import 'package:dnote_2_0/Theme/theme.dart';
import 'package:dnote_2_0/Widgets/activation_success_dialog.dart';
import 'package:dnote_2_0/Widgets/main_button.dart';
import 'package:dnote_2_0/Widgets/open_failure_dialog.dart';
import 'package:dnote_2_0/Widgets/open_success_dialog.dart';
import 'package:dnote_2_0/apis/active_user/check_license_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/verificationScreenController.dart';
import '../../Widgets/custom_progress_indicator.dart';
import '../../apis/active_user/create_user_api.dart';
import 'view_models/convert_to_uppercase.dart';
import 'package:platform_device_id/platform_device_id.dart';

//page Copntroller
VerificationScreenController verificationScreenController =
    VerificationScreenController();
final GlobalKey<FormState> licenseKey = GlobalKey<FormState>();
TextEditingController licensekey1Controller = TextEditingController();
TextEditingController licensekey2Controller = TextEditingController();
TextEditingController licensekey3Controller = TextEditingController();
TextEditingController licensekey4Controller = TextEditingController();
FocusNode licenseKeyFocusNode = FocusNode();

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key, required this.homeScreenController})
      : super(key: key);
  final HomeScreenController homeScreenController;
  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String imei = '';

  @override
  void initState() {
    initPlatformState();
    // getDeviceID();
    super.initState();
  }

  // Future<void> getDeviceID() async {
  //   String? id;
  //   try {
  //     id = await PlatformDeviceId.getDeviceId;

  //   } catch (e) {
  //     id = 'Failed to get device ID: $e';
  //   }
  //   setState(() {
  //     imei = id ?? "";
  //     print("id:$imei");
  //   });
  // }

  Future<void> initPlatformState() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('id:${androidInfo.id}');
        setState(() {
          imei = androidInfo.id.toString();
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('id:${iosInfo.identifierForVendor}');
        setState(() {
          imei = iosInfo.identifierForVendor.toString();
        });
      }
    } catch (e) {
      print('Failed to get device ID: $e');
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/rm222batch2-mind-03 1.png",
              )),
        ),
        child: Form(
          key: licenseKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "License Key",
                    style: TextStyle(
                        fontSize: 30.sp,
                        color: AppTheme.appBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Enter the 16 digit License Key",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              //licensekey box
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textFieldOtp(context, true, false, licensekey1Controller),
                  _textFieldOtp(context, false, false, licensekey2Controller),
                  _textFieldOtp(context, false, false, licensekey3Controller),
                  _textFieldOtp(context, false, true, licensekey4Controller),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Note: License key can only be used once",
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 80.h,
              ),
              //submit button
              MainButton(
                  onTap: () async {
                    if (licenseKey.currentState!.validate()) {
                      CustomProgressIndicator.openProgress();
                      String licenseKeys = licensekey1Controller.text +
                          licensekey2Controller.text +
                          licensekey3Controller.text +
                          licensekey4Controller.text;
                      Map<String, dynamic>? data =
                          await checkLicensApi(licenseKeys);
                      print("licenceKeyData:$data");
                      if (data != null) {
                        if (data.containsKey("message") &&
                            data.containsValue(
                                "user with this License Key already exist")) {
                          CustomProgressIndicator.closeProgress();
                          openSuccessDialog(context,
                              "user with this License Key already exist");
                        } else if (data.containsKey("message") &&
                            data.containsValue("Ready to Activate")) {
                          int activeClassId = data['license_id']['class_id'];
                          String licenseId = data['license_id']['license_keys'];

                          print("username:$finalUserName");
                          print("imei:$imei");
                          print("licensekey:$licenseId");
                          print("activeClass:$activeClassId");
                          print("phoneNumber:$finalPhoneNumber");

                          createUserApi(
                              userName: finalUserName.toString(),
                              imei: imei.toString(),
                              licenseKey: licenseId.toString(),
                              activeClass: activeClassId.toString(),
                              phoneNumber: finalPhoneNumber.toString());

                          CustomProgressIndicator.closeProgress();
                          activationSuccessDialog(
                              context, "Activated Successfully");
                          homeScreenController.getData(
                              activeClassId, finalSelectedBoard ?? 1);

                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setInt("isActivated", 1);
                          sharedPreferences.setBool("isUserActive", true);
                          isUserActive = true;
                          homeScreenController.isActivated(true);
                        }
                      } else {
                        CustomProgressIndicator.closeProgress();
                        openFailureDialog(context, "Invalid License key");
                      }
                    }
                  },
                  title: "Submit")
            ],
          ),
        ),
      )),
    );
  }

  _textFieldOtp(BuildContext context, bool first, last,
      TextEditingController controller) {
    return Container(
      width: 85.w,
      height: 85.h,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 4 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          keyboardType: TextInputType.name,
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [UpperCaseTextFormatter()],
          maxLength: 4,
          decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.w, color: Colors.black12),
                  borderRadius: BorderRadius.circular(12.r)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2.w, color: AppTheme.appBlue),
                  borderRadius: BorderRadius.circular(12.r))),
        ),
      ),
    );
  }
}

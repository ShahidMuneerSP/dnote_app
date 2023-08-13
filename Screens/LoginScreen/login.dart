import 'package:dnote_2_0/Controller/userController.dart';
import 'package:dnote_2_0/Theme/theme.dart';
import 'package:dnote_2_0/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:dnote_2_0/Screens/OtpScreen/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';

final Mycontroller controller = Get.put(Mycontroller());

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController phoneNumberController = TextEditingController();
  bool codeSent = false;
  String? verifyId;
  String? phoneNumber;
  TextEditingController usernameController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();

  TextEditingController addressInputController = TextEditingController();
  bool numberValidate = false;
  bool nameValidate = false;
  bool schoolNameValidate = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 300.h,
                      width: double.infinity,
                      child: SvgPicture.asset(
                        'assets/svgs/Teaching-rafiki (1).svg',
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                    //username textfield
                    nameInputField(),
                    //phone number textfield
                    phoneInputField(),
                    //school name textfield
                    schoolNameInputField(),
                    //address textfield
                    addressInputField(),
                    //submit button
                    Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: MainButton(
                            onTap: () async {
                              if (!formKey.currentState!.validate()) {
                                print('sphoneNumber');
                                formKey.currentState!.save();
                                return;
                              }

                              if (isLoading = false) {
                                setState(() async {
                                  isLoading = true;

                                  await Future.delayed(
                                      const Duration(seconds: 3));
                                  isLoading = false;
                                });
                              }

                              await Future.delayed(const Duration(seconds: 0));
                              Get.to(
                                  OtpScreen(
                                      phoneNumber: phoneNumberController.text),
                                  arguments: [
                                    {'phoneNumber': '$phoneNumber'},
                                    {'userName': usernameController.text},
                                    {'schoolName': schoolNameController.text},
                                    {'address': addressInputController.text},
                                  ]);

                              print(verifyId);
                            },
                            title: 'Submit')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // user name field

  nameInputField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.w,
        left: 28.w,
        right: 28.w,
      ),
      child: TextFormField(
          controller: usernameController,
          validator: (val) {
            if (val!.isNotEmpty && val.length > 2) {
              return null;
            } else if (val.length < 2 && val.isNotEmpty) {
              return 'Name must be more than 2 letters';
            } else {
              return 'Enter the valid name';
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              MdiIcons.account,
              color: AppTheme.appBlue,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Name',
            labelStyle: TextStyle(color: Colors.black54),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next),
    );
  }

//user phone number field

  phoneInputField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 28.w,
        right: 28.w,
      ),
      child: IntlPhoneField(
          controller: phoneNumberController,
          validator: (val) {
            if (val?.number != '' && val?.number.length == 10) {
              return null;
            } else {
              return 'Enter valid number';
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialCountryCode: 'IN',
          disableLengthCheck: true,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38),
            ),
          ),
          onChanged: (phone) {
            setState(() {
              phoneNumber = phone.completeNumber;
              print(phone.completeNumber);
            });
          },
          onCountryChanged: (country) {
            print('Country changed to: ' + country.name);
          },
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next),
    );
  }

//user school Name
  schoolNameInputField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.w,
        left: 28.w,
        right: 28.w,
      ),
      child: TextFormField(
          controller: schoolNameController,
          validator: (val) {
            if (val!.isNotEmpty && val.length > 2) {
              return null;
            } else if (val.length < 2 && val.isNotEmpty) {
              return 'Name must be more than 2 letters';
            } else {
              return 'Enter the valid name';
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              MdiIcons.school,
              color: AppTheme.appBlue,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'School name',
            labelStyle: TextStyle(color: Colors.black54),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next
          // obscureText: ,
          ),
    );
  }

//user address details

  addressInputField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 28.w,
        right: 28.w,
      ),
      child: TextFormField(
        controller: addressInputController,

        validator: (val) {
          if (val!.isNotEmpty && val.length > 2) {
            return null;
          } else if (val.length < 2 && val.isNotEmpty) {
            return 'Name must be more than 2 letters';
          } else {
            return 'Enter the valid name';
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 3,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.home,
            color: AppTheme.appBlue,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: 'Address',
          labelStyle: TextStyle(color: Colors.black54),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
        // obscureText: ,
      ),
    );
  }

  // Future<void> setUserLoginPageDetails() async {
  //   SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  //   await sharedPrefs.setString('USER_NAME', usernameController.text);
  //   await sharedPrefs.setString('USER_PHONE_NUMBER', '$phoneNumber');
  //   await sharedPrefs.setString('USER_LOCATION', addressInputController.text);
  //   await sharedPrefs.setString('USER_SCHOOL_NAME', schoolNameController.text);
  // }

}

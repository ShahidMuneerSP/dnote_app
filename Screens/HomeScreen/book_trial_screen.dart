import 'package:dnote_2_0/Theme/theme.dart';
import 'package:dnote_2_0/Widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:dnote_2_0/Screens/OtpScreen/otp.dart';

class BookTrailScreen extends StatefulWidget {
  const BookTrailScreen({Key? key}) : super(key: key);

  @override
  State<BookTrailScreen> createState() => _BookTrailScreenState();
}

class _BookTrailScreenState extends State<BookTrailScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController boardController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/images/rm222batch2-mind-03 1.png",
                )),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                    SizedBox(
                      height: 30.h,
                    ),
                    //username textfield
                    nameInputField(),
                    //class textfield
                    classInputField(),
                    //board textfield
                    boardInputField(),
                    //school name textfield
                    schoolNameInputField(),
                    //phone number textfield
                    phoneInputField(),

                    //submit button
                    Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: 50.h),
                          child: MainButton(
                              onTap: () async {
                                if (!formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  return;
                                }

                                await Future.delayed(
                                    const Duration(seconds: 0));
                              },
                              title: 'Submit')),
                    ),
                    SizedBox(
                      height: 200.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // board field
  boardInputField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 30.w,
        left: 28.w,
        right: 28.w,
      ),
      child: TextFormField(
          controller: boardController,
          validator: (val) {
            if (val!.isNotEmpty) {
              return null;
            } else {
              return 'Enter the board';
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.book,
              color: AppTheme.appBlue,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Board',
            labelStyle: TextStyle(color: Colors.black54),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next),
    );
  }

  // class field
  classInputField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 30.w,
        left: 28.w,
        right: 28.w,
      ),
      child: TextFormField(
          controller: classController,
          validator: (val) {
            if (val!.isNotEmpty) {
              return null;
            } else {
              return 'Enter the class';
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.account_balance,
              color: AppTheme.appBlue,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Class',
            labelStyle: TextStyle(color: Colors.black54),
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next),
    );
  }
  // user name field

  nameInputField() {
    return Padding(
      padding: EdgeInsets.only(
        top: 30.w,
        left: 28.w,
        right: 28.w,
      ),
      child: TextFormField(
          controller: nameController,
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
        top: 30.h,
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
        top: 30.w,
        left: 28.w,
        right: 28.w,
      ),
      child: TextFormField(
          controller: schoolController,
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
}

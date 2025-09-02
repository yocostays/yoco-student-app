import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/custom_dateform_field.dart';
import 'package:yoco_stay_student/app/core/values/custom_dropdowm.dart';
import 'package:yoco_stay_student/app/core/values/custom_phonenumber.dart';
import 'package:yoco_stay_student/app/core/values/custom_textformfield.dart';
import 'package:yoco_stay_student/app/module/onboarding/auth_controller.dart';
import 'package:yoco_stay_student/app/module/onboarding/widget/custom_hostal_dropdown.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/globals.dart' as globals;

class Register extends StatefulWidget {
  final ScrollController scrollController;
  final double height;
  const Register({
    super.key,
    required this.scrollController,
    required this.height,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthController authController = Get.put(AuthController());
  bool isChecked = false; // Initialized with a default value
  bool selfDeclear = false;
  bool Agreement = false;

  String? selectedItem;
  String? selectedBloodGroup;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authController.GetHostalList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        final adjustedHeight = widget.height - bottomInset;

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30.h),
              SizedBox(
                // height: widget.height,
                height: adjustedHeight == globals.globalheight * 0.6
                    ? globals.globalheight * 0.6
                    : adjustedHeight,
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.StudentName,
                          hintTextColor: AppColor.textblack,
                          hintText: "Student Name*",
                          prefixIcon: FeatherIcons.user,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the student name';
                            }
                            return null;
                          },
                        ),
                        // CustomTextFormField(
                        //   controller: authController.Email,
                        //   hintTextColor: AppColor.textblack,
                        //   hintText: "Email*",
                        //   prefixIcon: FeatherIcons.mail,
                        //   onchange: (value) {
                        //     final words = value!.trim().split(RegExp(r'\s+'));
                        //     if (words.length > 30) {
                        //       return 'Please limit to 30 words';
                        //     }
                        //     return null;
                        //   },
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Please enter Email';
                        //     }

                        //     String emailPattern =
                        //         r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                        //     RegExp regExp = RegExp(emailPattern);

                        //     if (!regExp.hasMatch(value)) {
                        //       return 'Please enter a valid email address';
                        //     }
                        //     return null;
                        //   },
                        // ),
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.Email,
                          hintTextColor: AppColor.textblack,
                          hintText: "Email*",
                          prefixIcon: FeatherIcons.mail,
                          onchange: (value) {
                            return null;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            if (value.length > 30) {
                              // Display a warning or limit the input
                              print('Please limit to 30 characters');
                            }
                            String emailPattern =
                                r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                            RegExp regExp = RegExp(emailPattern);

                            if (!regExp.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          // numberkeyboard: true,
                          controller: authController.EnrollmentNumber,
                          hintTextColor: AppColor.textblack,
                          hintText: "Enrolment No./Reg. No.*",
                          prefixIcon: FeatherIcons.userPlus,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Enrolment No.';
                            }
                            return null;
                          },
                        ),
                        CustomDateFormField(
                          ontap: () async {
                            FocusScope.of(context).unfocus();
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                authController.Dob = selectedDate;
                                authController.DOB.text =
                                    DateFormat('dd-MM-yyyy')
                                        .format(selectedDate);
                              });
                            }
                          },
                          hintText: 'Date of Birth*',
                          controller: authController.DOB,
                          onDateSelected: (DateTime date) {
                            authController.DOB.text = "$date";
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter DOB';
                            }
                            return null;
                          },
                        ),
                        CustomPhoneNumberField(
                          maxnumber: 10,
                          phoneController: authController.MobileNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 10) {
                              return 'Phone number must be exactly 10 digits';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.FatherName,
                          hintTextColor: AppColor.textblack,
                          hintText: "Father Name*",
                          prefixIcon: FeatherIcons.user,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Father Name';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 10,
                          controller: authController.FatherMobile,
                          hintTextColor: AppColor.textblack,
                          hintText: "Father Mobile No.*",
                          prefixIcon: FeatherIcons.phone,
                          numberkeyboard: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Father Name.';
                            } else if (value.length < 10) {
                              return 'Phone number must be exactly 10 digits';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.FatherEmail,
                          hintTextColor: AppColor.textblack,
                          hintText: "Father Email",
                          prefixIcon: FeatherIcons.mail,
                          validator: (value) {
                            String emailPattern =
                                r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                            RegExp regExp = RegExp(emailPattern);

                            if (value!.isNotEmpty) {
                              if (!regExp.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                            }

                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.MotherName,
                          hintTextColor: AppColor.textblack,
                          hintText: "Mother Name*",
                          prefixIcon: FeatherIcons.user,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Mother Name';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 10,
                          controller: authController.MotherMobile,
                          hintTextColor: AppColor.textblack,
                          hintText: "Mother Mobile No.*",
                          prefixIcon: FeatherIcons.phone,
                          numberkeyboard: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Mother Mobile Number';
                            } else if (value.length < 10) {
                              return 'Phone number must be exactly 10 digits';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.MotherEmail,
                          hintTextColor: AppColor.textblack,
                          hintText: "Mother Email",
                          prefixIcon: FeatherIcons.mail,
                          validator: (value) {
                            String emailPattern =
                                r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                            RegExp regExp = RegExp(emailPattern);

                            if (value!.isNotEmpty) {
                              if (!regExp.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          // numberkeyboard: true,
                          controller: authController.Aadharpassport,
                          hintTextColor: AppColor.textblack,
                          hintText: "Aadhar/Passport No.*",
                          prefixIcon: FeatherIcons.creditCard,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Aadhar/Password';
                            }
                            return null;
                          },
                        ),
                        CustomDropdownFormField(
                          hintText: "Blood Group*",
                          prefixIcon: FeatherIcons.pieChart,
                          items: const [
                            "A+",
                            "A-",
                            "B+",
                            "B-",
                            "AB+",
                            "AB-",
                            "O+",
                            "O-"
                          ],
                          selectedItem: authController.BloodGroup.text.isEmpty
                              ? null
                              : authController.BloodGroup.text,
                          onChanged: (value) {
                            setState(() {
                              authController.BloodGroup.text = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Choose Your Blood Group';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.CourseName,
                          hintTextColor: AppColor.textblack,
                          hintText: "Course Name*",
                          prefixIcon: FeatherIcons.book,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Course Name';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.Acadmicyear,
                          numberkeyboard: true,
                          hintTextColor: AppColor.textblack,
                          hintText: "Academic Year*",
                          prefixIcon: FeatherIcons.calendar,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Academic year';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          numberkeyboard: true,
                          controller: authController.Semester,
                          hintTextColor: AppColor.textblack,
                          hintText: "Semester*",
                          prefixIcon: FeatherIcons.calendar,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Semester.';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 10,
                          controller: authController.GuardianNumber,
                          hintTextColor: AppColor.textblack,
                          hintText: "Guardian Contact No.*",
                          prefixIcon: FeatherIcons.phone,
                          numberkeyboard: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Guardian Contact No';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          maxlength: 30,
                          controller: authController.Category,
                          hintTextColor: AppColor.textblack,
                          hintText: "Category*",
                          prefixIcon: FeatherIcons.grid,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Category';
                            }
                            return null;
                          },
                        ),
                        CustomHostelFormField(
                          hintText: "Hostel Preference*",
                          prefixIcon: FeatherIcons.home,
                          items: authController.hosteldata,
                          selectedItem:
                              authController.Hotelperfrence.text.isEmpty
                                  ? null
                                  : authController.Hotelperfrence.text,
                          onChanged: (value) {
                            authController.Hotelperfrence.text = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a hostel preference';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          controller: authController.permanentAddress,
                          hintTextColor: AppColor.textblack,
                          hintText: "Permanent Address*",
                          prefixIcon: FeatherIcons.mapPin,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Permanent Address';
                            }
                            return null;
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: selfDeclear,
                              onChanged: (value) {
                                setState(() {
                                  selfDeclear = value!;
                                });
                              },
                              activeColor: AppColor.primary,
                            ),
                            SizedBox(
                              width: 280.w,
                              child: Text(
                                "I hereby declare that the information furnished above is true, complete and correct*",
                                style: AppTextTheme.textTheme.displayLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.textblack,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: Agreement,
                              onChanged: (value) {
                                setState(() {
                                  Agreement = value!;
                                });
                              },
                              activeColor: AppColor.primary,
                            ),
                            SizedBox(
                                width: 280.w,
                                child: RichText(
                                  text: TextSpan(
                                      text: "I Agree all",
                                      style: AppTextTheme.textTheme.displayLarge
                                          ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.textblack,
                                        fontSize: 14,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Terms & Conditions*',
                                          style: AppTextTheme
                                              .textTheme.displayLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.textprimary,
                                            fontSize: 14,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // Handle the tap event here
                                              print(
                                                  "Terms & Conditions clicked");
                                            },
                                        ),
                                      ]),
                                )
                                //  Text(
                                //   "I Agree all Terms & Conditions",
                                //   style: AppTextTheme.textTheme.displayLarge?.copyWith(
                                //     fontWeight: FontWeight.w700,
                                //     color: AppColor.textblack,
                                //     fontSize: 13,
                                //   ),
                                // ),
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => authController.RegisterLoader.value == true
                    ? Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          size: 50,
                          color: AppColor.primary,
                        ),
                      )
                    : CustomButton(
                        BoxColor: AppColor.secondary,
                        textcolor: AppColor.textblack,
                        fontsize: 16,
                        height: 40.h,
                        ontap: () {
                          if (_formKey.currentState!.validate()) {
                            // Get.to(DashboardPage()),

                            Agreement == true && selfDeclear == true
                                ? {
                                    authController.UserRegistration(),
                                  }
                                : {
                                    Fluttertoast.showToast(
                                        msg: "Checked SelfDeaclear, Agreement",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 5,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0),
                                  };
                          } else {
                            // print('Please fill all required fields');
                            Fluttertoast.showToast(
                                msg: "Please fill all required fields",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        Title: "Send for Registration",
                      ),
              ),

              // SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}

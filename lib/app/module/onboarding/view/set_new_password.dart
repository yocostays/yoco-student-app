import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/custom_textformfield.dart';
import 'package:yoco_stay_student/app/module/onboarding/auth_controller.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class SetNewPasswordPage extends StatefulWidget {
  const SetNewPasswordPage({super.key});

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const int initialTime = 5 * 60; // 5 minutes in seconds
  late int _remainingTime;
  Timer? _timer;
  bool _resendAvailable = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = initialTime;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _resendAvailable = true; // Show "Resend" when time is up
        });
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  void _resendCode() {
    setState(() {
      _remainingTime = initialTime;
      _resendAvailable = false;
      _startTimer();
    });
    // Call resend OTP API or logic here
    print("Resend OTP logic triggered");
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightpurple2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              padding: EdgeInsets.only(top: 45.h, bottom: 5.h),
              child: Image.asset("assets/images/login.png"),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: Container(
                width: double.infinity.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.r),
                  ),
                  color: AppColor.white,
                ),
                padding: EdgeInsets.all(15.h),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Otp.';
                            }
                            return null;
                          },
                          hintTextColor: AppColor.textblack,
                          hintText: "Code",
                          prefixIcon: Icons.email_outlined,
                          controller: authController.Otp,
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => CustomTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                            hintTextColor: AppColor.textblack,
                            hintText: "New Password",
                            obscureText: authController.Showpassword.value,
                            prefixIcon: FeatherIcons.lock,
                            suffixIcon: authController.Showpassword.value
                                ? FeatherIcons.eye
                                : FeatherIcons.eyeOff,
                            onSuffixIconPressed: () {
                              authController.Showpassword.value == true
                                  ? authController.Showpassword(false)
                                  : authController.Showpassword(true);
                            },
                            controller: authController.newpassword,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => CustomTextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                            hintTextColor: AppColor.textblack,
                            hintText: "Confirm Password",
                            obscureText: authController.Showpassword.value,
                            prefixIcon: FeatherIcons.lock,
                            suffixIcon: authController.Showpassword.value
                                ? FeatherIcons.eye
                                : FeatherIcons.eyeOff,
                            onSuffixIconPressed: () {
                              authController.Showpassword.value == true
                                  ? authController.Showpassword(false)
                                  : authController.Showpassword(true);
                            },
                            controller: authController.Confirmpassword,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        InkWell(
                          onTap: () async {
                            _resendAvailable
                                ? {
                                    await authController.ResendOtp(),
                                    _resendCode()
                                  }
                                : 0;
                          },
                          child: Text(
                            _resendAvailable
                                ? "Resend"
                                : _formatTime(_remainingTime),
                            style: AppTextTheme.textTheme.displayLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.primary),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => authController.setnewPasswordLoader == true
                              ? const Loader()
                              : CustomButton(
                                  BoxColor: AppColor.secondary,
                                  textcolor: AppColor.textblack,
                                  fontsize: 16,
                                  height: 40.h,
                                  ontap: () async {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      await authController.NewPasswordSet();
                                      _timer!.cancel();
                                    }
                                  },
                                  Title: "Next",
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

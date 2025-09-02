import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/Storage/get_storage.dart';
import 'dart:async';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/onboarding/auth_controller.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/login_signup.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/skipable_screen.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = AuthController();
  double _imageOpacity = 0.0;
  double _imageVisibleOpacity = 1.0;
  double _buttonOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Initial animation to make the image visible
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _imageOpacity = 1.0;
      });

      // After the image has fully appeared, reduce its opacity
      Timer(const Duration(milliseconds: 1500), () async {
        setState(() {
          _imageVisibleOpacity = 0.2;
        });

        Timer(const Duration(milliseconds: 200), () async {
          String? Token = TokenStorage.getToken();
          print("token save : $Token");

          Token == null
              ? {
                  if (TokenStorage.getLoged() == "Loged")
                    {
                      Get.to(const LoginSignUp()),
                    }
                  else
                    {
                      setState(() {
                        authController.Registerbuttonshow(true);
                      }),
                    }
                }
              : authController.TokenValiditycheck();
        });

        // After the image fades out, fade in the button
        Timer(const Duration(milliseconds: 500), () {
          setState(() {
            _buttonOpacity = 1.0;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          Positioned(
            top: 100.h,
            left: 0.w,
            right: 0.w,
            child: SizedBox(
              width: 200.w,
              height: 200.w,
              child: Image.asset(
                "assets/images/whitelogo.png",
                // scale: ,
              ),
            ),
          ),
          Positioned(
            bottom: 0.h,
            left: 0.w,
            right: 0.w,
            child: AnimatedOpacity(
              opacity: _imageOpacity,
              duration: const Duration(seconds: 2),
              child: Opacity(
                opacity: _imageVisibleOpacity,
                child: Image.asset("assets/images/splash.png"),
              ),
            ),
          ),
          Positioned(
            bottom: 35.h,
            left: 20.w,
            right: 20.w,
            child: AnimatedOpacity(
                opacity: _buttonOpacity,
                duration: const Duration(seconds: 1),
                child: Obx(
                  () => authController.Registerbuttonshow.value == false
                      ? Container()
                      : CustomButton(
                          ontap: () {
                            Get.to(const SkipableScreen());
                          },
                          Title: "Get Started",
                          BoxColor: AppColor.secondary,
                          textcolor: AppColor.textblack,
                          height: 40.h,
                          fontsize: 18,
                        ),
                )),
          ),
        ],
      ),
    );
  }
}

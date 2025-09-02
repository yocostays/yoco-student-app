import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/custom_textformfield.dart';
import 'package:yoco_stay_student/app/module/onboarding/auth_controller.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class ForgetPasswordPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightpurple2,
      body: Column(
        children: [
          Container(
            height: 400,
            padding: EdgeInsets.only(top: 45.h, bottom: 5.h),
            child: Image.asset("assets/images/login.png"),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
              width: double.infinity.w,
              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     color: AppColor.midpurple,
                //     blurRadius: 1.h,
                //     spreadRadius: 0.h,
                //   ),
                // ],
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
                      // Container(
                      //   height: 45.h,
                      //   margin: EdgeInsets.only(top: 10),
                      //   decoration: BoxDecoration(
                      //     color: AppColor.lightpurple2,
                      //     borderRadius: BorderRadius.circular(40.r),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black.withOpacity(0.2),
                      //         spreadRadius: 1,
                      //         blurRadius: 2,
                      //         offset: Offset(0, 2),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Yoco ID cannot be empty';
                          }
                          return null;
                        },
                        hintTextColor: AppColor.textblack,
                        hintText: "Yoco ID",
                        prefixIcon: Icons.email_outlined,
                        controller: authController.UserId,
                      ),

                      SizedBox(
                        height: 40.h,
                      ),
                      Obx(
                        () => authController.forgetpassLoader == true
                            ? const Loader()
                            : CustomButton(
                                BoxColor: AppColor.secondary,
                                textcolor: AppColor.textblack,
                                fontsize: 16,
                                height: 40.h,
                                ontap: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    await authController.ForgetPasswordOtp();
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
    );
  }
}

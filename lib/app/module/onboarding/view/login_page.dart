import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/custom_textformfield.dart';
import 'package:yoco_stay_student/app/module/onboarding/auth_controller.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/forget_password.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class Login extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final bool isChecked;
  final ValueChanged<bool?> onCheckedChanged;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Login({
    required this.isChecked,
    required this.onCheckedChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30.h),
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
                hintText: "Password",
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
                controller: authController.Password,
              ),
            ),
            SizedBox(height: 10.h),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: authController.rememberme.value,
                        activeColor: AppColor.primary,
                        onChanged: (bool? value) {
                          authController.rememberme.value == true
                              ? authController.rememberme(false)
                              : authController.rememberme(true);
                        },
                      ),
                      Text(
                        "Remember me",
                        style: AppTextTheme.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColor.textblack),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => ForgetPasswordPage());
                    },
                    child: Text(
                      "Forget Password?",
                      style: AppTextTheme.textTheme.displayLarge?.copyWith(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => authController.LoginLoader == true
                  ? const Loader()
                  : CustomButton(
                      BoxColor: AppColor.secondary,
                      textcolor: AppColor.textblack,
                      fontsize: 16,
                      height: 40.h,
                      ontap: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await authController.Loginauth();
                        }
                      },
                      Title: "Login",
                    ),
            )
          ],
        ),
      ),
    );
  }
}

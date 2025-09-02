// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final int? maxlength;
  final TextEditingController? controller;
  final bool obscureText;
  final Color? hintTextColor;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onchange;
  final IconData? suffixIcon;
  final bool? numberkeyboard;
  final VoidCallback? onSuffixIconPressed;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.maxlength,
    this.controller,
    this.obscureText = false,
    this.hintTextColor,
    this.validator,
    this.onchange,
    this.suffixIcon,
    this.numberkeyboard,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: onchange ?? (value) {},
          maxLength: maxlength,
          keyboardType: numberkeyboard == true
              ? TextInputType.number
              : TextInputType.text,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: AppTextTheme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w700, color: AppColor.textblack),
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: AppColor.primary,
              size: 20.h,
            ),
            hintText: hintText,
            hintStyle: AppTextTheme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: hintTextColor ?? AppColor.textprimary),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(color: AppColor.grey3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(color: AppColor.primary),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon, color: AppColor.primary),
                    onPressed: onSuffixIconPressed,
                  )
                : null,
            counterText: '',
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}

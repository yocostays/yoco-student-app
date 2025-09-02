// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class CustomDateFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextEditingController internalcontroller = TextEditingController();
  final FormFieldValidator<String>? validator;
  final Function(DateTime)? onDateSelected;
  final Function() ontap;

  CustomDateFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.onDateSelected,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: validator,
          readOnly: true,
          style: AppTextTheme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.w700, color: AppColor.textblack),
          onTap: ontap,
          //  () async {
          //   FocusScope.of(context).unfocus();
          //   DateTime? selectedDate = await showDatePicker(
          //     context: context,
          //     initialDate: DateTime.now(),
          //     firstDate: DateTime(1900),
          //     lastDate: DateTime(2101),
          //   );
          //   if (selectedDate != null) {}
          // },
          decoration: InputDecoration(
            suffixIcon: const Icon(
              FeatherIcons.calendar,
              color: AppColor.primary,
            ),
            hintText: hintText,
            hintStyle: AppTextTheme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w700, color: AppColor.textblack),
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
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}

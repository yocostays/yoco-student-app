import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final Color? backgroundColor;
  final Color? borderColor;

  const CustomDropdownFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.items,
    required this.onChanged,
    this.selectedItem,
    this.validator,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: selectedItem,
          validator: validator,
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: AppTextTheme.textTheme.displayLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColor.textblack),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: AppColor.primary,
              size: 20.h,
            ),
            hintText: hintText,
            hintStyle: AppTextTheme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w700, color: AppColor.textblack),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            fillColor:
                backgroundColor ?? Colors.transparent, // Background color
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(
                  color: borderColor ?? AppColor.grey3), // Border color
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(
                  color: borderColor ?? AppColor.primary), // Border color
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

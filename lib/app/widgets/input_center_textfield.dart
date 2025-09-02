// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';

class InputCenterTextfield extends StatelessWidget {
  final Function(String) onchange;
  final String title;
  final String hint;
  final TextEditingController Controller;
  const InputCenterTextfield({
    super.key,
    required this.onchange,
    required this.title,
    required this.hint,
    required this.Controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColor.textgrey,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: Container(
              height: 32.h, // Adjust height as needed
              decoration: BoxDecoration(
                color: AppColor.secondary.withOpacity(0.2), // Background color
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
              child: Center(
                child: TextField(
                  controller: Controller,
                  onChanged: onchange,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(
                            color: AppColor.textgrey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15), // Adjust padding
                  ),
                  style: const TextStyle(
                    color: Color(0xFF1D1B3B),
                    fontSize: 14, // Adjust font size as needed
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

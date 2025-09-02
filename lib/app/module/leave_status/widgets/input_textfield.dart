import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';

class LeaveDescriotion extends StatelessWidget {
  final bool leave;
  const LeaveDescriotion({
    super.key,
    required this.controller,
    required this.leave,
  });
  final LeaveController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leave == true ? "DESCRIPTION" : "REASON",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.textgrey, fontWeight: FontWeight.w700),
              ),
              Text(
                "${controller.Textlength.value}/100",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.textgrey, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        TextField(
          controller: controller.discription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.textblack, fontWeight: FontWeight.w700),
          maxLength: 100,
          maxLines: null,
          onChanged: (value) {
            print("${value.length}");
            controller.Textlength.value = value.length;
          },
          decoration: InputDecoration(
            counterText: "",
            labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColor.textblack, fontWeight: FontWeight.w700),
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColor.textgrey, fontWeight: FontWeight.w700),
            hintText: 'Type here...',
            filled: true,
            fillColor: const Color(0xFFFFF4D8), // Background color
            contentPadding: const EdgeInsets.symmetric(
                vertical: 11.0,
                horizontal: 20.0), // Padding inside the text field
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
              borderSide: BorderSide.none, // No border
            ),
          ),
        ),
      ],
    );
  }
}

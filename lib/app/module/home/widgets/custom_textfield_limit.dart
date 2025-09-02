import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/controller/suggation_controller.dart';

class SuggationWriteDescriotion extends StatelessWidget {
  const SuggationWriteDescriotion({
    super.key,
    required this.controller,
  });

  final SuggationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  "SUGGESTIONS",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textgrey, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(
                  "${controller.Textlength.value}/100",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textgrey, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
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
        ),
      ],
    );
  }
}

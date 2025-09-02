// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';

class Ev_Slot_Custom_textfield extends StatelessWidget {
  final String? hint;
  final TextEditingController TextController;
  final Widget? perfixiconwidget;
  final bool? textfiled;
  final bool? textcenter;
  final TextStyle? textstyle;
  final TextStyle? hinttextstyle;

  const Ev_Slot_Custom_textfield({
    super.key,
    required this.hint,
    required this.TextController,
    this.perfixiconwidget,
    this.textfiled,
    this.textcenter,
    this.textstyle,
    this.hinttextstyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: textstyle ??
          Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.textblack, fontWeight: FontWeight.w700),
      textAlign: textcenter == false ? TextAlign.left : TextAlign.center,
      enabled: textfiled ?? true,
      controller: TextController,
      maxLength: 100,
      maxLines: null,
      decoration: InputDecoration(
        prefixIcon: perfixiconwidget,
        counterText: "",
        labelStyle: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColor.black, fontWeight: FontWeight.w700),
        hintStyle: hinttextstyle ??
            Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColor.black, fontWeight: FontWeight.w700),
        hintText: hint ?? '',
        filled: true,
        fillColor: const Color(0xFFFFF4D8), // Background color
        contentPadding: const EdgeInsets.symmetric(
            vertical: 11.0, horizontal: 20.0), // Padding inside the text field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
          borderSide: BorderSide.none, // No border
        ),
      ),
    );
  }
}

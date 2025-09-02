import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class inputtextwidgets extends StatefulWidget {
  inputtextwidgets(
      {super.key,
      required this.controller,
      this.hinttextstyle,
      this.lable,
      this.hint,
      this.notshowlimit});

  final TextEditingController controller;
  final TextStyle? hinttextstyle;
  final String? lable;
  final String? hint;
  bool? notshowlimit = false;

  @override
  State<inputtextwidgets> createState() => _inputtextwidgetsState();
}

class _inputtextwidgetsState extends State<inputtextwidgets> {
  int intputext = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(
                widget.lable ?? "DESCRIPTION*",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.textgrey, fontWeight: FontWeight.w700),
              ),
            ),
            widget.notshowlimit == true
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Text(
                      "$intputext/100",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColor.textgrey,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColor.textblack, fontWeight: FontWeight.w700),
            maxLength: 100,
            maxLines: null,
            onChanged: (value) {
              setState(() {
                intputext = value.length;
              });
            },
            decoration: InputDecoration(
              counterText: "",
              labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.textblack, fontWeight: FontWeight.w700),
              hintStyle: widget.hinttextstyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textgrey, fontWeight: FontWeight.w700),
              hintText: widget.hint ?? 'Type here...',
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

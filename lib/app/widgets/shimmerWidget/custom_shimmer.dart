// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';

class CustomShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? basecolor;
  final Color? highcolor;
  const CustomShimmer({
    super.key,
    this.height,
    this.width,
    this.basecolor,
    this.highcolor,
  });

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      height: height ?? 240.h,
      width: width ?? 323.w,
      radius: 12,
      millisecondsDelay: 1,
      // fadeTheme: FadeTheme.light,
      highlightColor: highcolor ?? AppColor.primary,
      baseColor: basecolor ?? AppColor.lightpurple,
    );
  }
}

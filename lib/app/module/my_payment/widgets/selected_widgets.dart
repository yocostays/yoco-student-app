import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class NotSelected extends StatelessWidget {
  const NotSelected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14.h,
      width: 14.w,
      decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.grey3, width: 2)),
    );
  }
}

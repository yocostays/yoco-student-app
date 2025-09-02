import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class Selectedwidgets extends StatelessWidget {
  const Selectedwidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14.h,
      width: 14.w,
      decoration: const BoxDecoration(
        color: AppColor.yellow3,
        shape: BoxShape.circle,
        // border: Border.all(
        //     color: AppColor.grey3, width: 2)
      ),
      child: const Icon(
        Icons.check,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}

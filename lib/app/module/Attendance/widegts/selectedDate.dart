import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class SelecteAttendenceDate extends StatelessWidget {
  const SelecteAttendenceDate({
    super.key,
    required DateTime focusedDay,
  }) : _focusedDay = focusedDay;

  final DateTime _focusedDay;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          DateFormat.yMMMM().format(_focusedDay),
          style: AppTextTheme.textTheme.displayLarge?.copyWith(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
              fontSize: 18.sp),
        ),
        SizedBox(
          width: 5.w,
        ),
        const Icon(
          FeatherIcons.calendar,
          size: 25,
          color: AppColor.secondary,
        )
      ],
    );
  }
}

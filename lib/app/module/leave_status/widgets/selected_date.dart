// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';

class selecteddate extends StatelessWidget {
  final String? date;
  const selecteddate({
    super.key,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                date ?? "",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: AppColor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                width: 2.w,
              ),
              const Icon(
                FeatherIcons.calendar,
                size: 15,
                color: AppColor.secondary,
              )
            ],
          ),
          Text(
            "Select date",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColor.grey3, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}

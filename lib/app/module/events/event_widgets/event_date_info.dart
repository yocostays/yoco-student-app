// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/icons.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class EventDateInfo extends StatelessWidget {
  bool? eventdetail = false;
  EventDateInfo({
    super.key,
    this.eventdetail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        eventdetail == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Year Party",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColor.textwhite, fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      AppIcon.share(color: AppColor.textwhite),
                      SizedBox(
                        width: 10.w,
                      ),
                      AppIcon.heart(color: AppColor.textwhite),
                    ],
                  ),
                ],
              )
            : Container(),
        eventdetail == true
            ? SizedBox(
                height: 13.h,
              )
            : Container(),
        Row(
          children: [
            AppIcon.calendar(
              color: AppColor.textwhite,
            ),
            SizedBox(
              width: 4.h,
            ),
            Text(
              Utils.formatDatebynd(DateTime(2024, 2, 22)),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.textwhite, fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 9.h,
        ),
        Row(
          children: [
            AppIcon.clock(
              color: AppColor.textwhite,
            ),
            SizedBox(
              width: 4.h,
            ),
            Text(
              "${DateFormat('hh:mm a').format(DateTime(2024, 2, 22, 20, 0))} Onwards",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.white, fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 9.h,
        ),
        Row(
          children: [
            AppIcon.mapPin(
              color: AppColor.textwhite,
            ),
            SizedBox(
              width: 4.h,
            ),
            Expanded(
              child: Text(
                "YOCO Hostel Common Areasasdadssadad",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.textwhite, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        SizedBox(
          height: 22.h,
        ),
        Text(
          "About",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.textwhite, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and Below register link attached ",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.textwhite, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

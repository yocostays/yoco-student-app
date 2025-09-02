// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/icons.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class EventTimeNameCard extends StatelessWidget {
  final Function()? paymentsectoion;
  const EventTimeNameCard({
    super.key,
    this.paymentsectoion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoute.eventdetailpage);
              },
              child: Image.asset(
                "assets/images/eventimage.png",
                // height: 113.h,
                // width: 113.w,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: paymentsectoion,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                height: 113.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        "New Year Party",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: AppColor.textprimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        AppIcon.calendar(
                          color: AppColor.primary,
                        ),
                        SizedBox(
                          width: 4.h,
                        ),
                        Text(
                          Utils.formatDatebynd(DateTime(2024, 2, 22)),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: AppColor.textprimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        AppIcon.clock(
                          color: AppColor.primary,
                        ),
                        SizedBox(
                          width: 4.h,
                        ),
                        Text(
                          "${DateFormat('hh:mm a').format(DateTime(2024, 2, 22, 20, 0))} Onwards",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: AppColor.textprimary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        AppIcon.mapPin(
                          color: AppColor.primary,
                        ),
                        SizedBox(
                          width: 4.h,
                        ),
                        Expanded(
                          child: Text(
                            "YOCO Hostel Common Areasasdadssadad",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color: AppColor.textprimary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_date_info.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: CustomAppBar(
          titlewidget: Text(
            "EVENTS DETAILS",
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColor.white, fontSize: 12),
          ),
          trailingwidget: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                width: 31.w,
                height: 31.h,
                decoration: BoxDecoration(
                  color: AppColor.belliconbackround,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(
                  CupertinoIcons.bell,
                  color: AppColor.white,
                ),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 330.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // border: Border.all(color: AppColor.white),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: Stack(
                    children: [
                      Image.asset(
                        width: double.infinity,
                        "assets/images/eventimage.png",
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 47.w,
                          height: 47.h,
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.r),
                                  // bottomRight: Radius.circular(10.r),
                                  topRight: Radius.circular(20.r))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Paid",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              // SizedBox(
              //   height: 5.h,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: EventDateInfo(
                  eventdetail: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

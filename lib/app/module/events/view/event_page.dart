import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/downloadDialog.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_date_info.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class EventPageDetail extends StatelessWidget {
  const EventPageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: CustomAppBar(
          titlewidget: Text(
            "NEW YEAR PARTY",
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColor.white, fontSize: 14),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 31.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: EventDateInfo(
                eventdetail: false,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: CustomButton(
                Textsize: 14,
                fontWeight: FontWeight.bold,
                Boderradius: 30.r,
                textcolor: AppColor.textblack,
                BoxColor: AppColor.yellow4,
                borderColor: AppColor.white.withOpacity(0.3),
                ontap: () {},
                Title: 'Pay Now',
                height: 42.h,
                width: 99.w,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: ScreenUtil.defaultSize.height / 1.69,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 38, vertical: 40),
                    child: GridView.count(
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 3,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const EventDialogBox();
                              },
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                                color: AppColor.lightgray,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const EventDialogBox();
                              },
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                                color: AppColor.lightgray,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const EventDialogBox();
                              },
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                                color: AppColor.lightgray,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const EventDialogBox();
                              },
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                                color: AppColor.lightgray,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const EventDialogBox();
                              },
                            );
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                                color: AppColor.lightgray,
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 40,
                  child: Text(
                    "Event Highlights",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.lightgray, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notice board", trailingwidget: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: InkWell(
            onTap: () {
              Get.to(const NotificationView());
            },
            child: Container(
              width: 31.w,
              height: 31.h,
              decoration: BoxDecoration(
                color: AppColor.belliconbackround,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: const Icon(
                FeatherIcons.bell,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ]),
      body: Stack(
        children: [
          stackcontainer(
              NoBackgroundcolor: true,
              writedata: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 280.h,
                      height: 280.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Image.asset(
                        "assets/images/notice.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 280.h,
                      // height: 220.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primary.withOpacity(0.7),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(-1, -2),
                          ),
                          BoxShadow(
                            color: AppColor.primary.withOpacity(0.7),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(1, 0),
                          ),
                          BoxShadow(
                            color: AppColor.grey2.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(1, 2),
                          ),
                          BoxShadow(
                            color: AppColor.grey2.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(-1, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.h),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Live Match",
                                    style: AppTextTheme.textTheme.labelLarge
                                        ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.textblack),
                                  ),
                                  const Icon(
                                    Icons.share_outlined,
                                    color: AppColor.primary,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    FeatherIcons.calendar,
                                    // color: AppColor.primary,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "6th March, 2024",
                                    style: AppTextTheme.textTheme.labelLarge
                                        ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.textblack),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.alarm,
                                    // color: AppColor.primary,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "10:30 AM - 11:30 AM",
                                    style: AppTextTheme.textTheme.labelLarge
                                        ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.textblack),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    // color: AppColor.primary,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "YOCO Hostel Common Area",
                                    style: AppTextTheme.textTheme.labelLarge
                                        ?.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.textblack),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                "Description",
                                style: AppTextTheme.textTheme.labelLarge
                                    ?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.textblack),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                style: AppTextTheme.textTheme.labelLarge
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.textblack),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
            bottom: -10.h,
            left: 0.h,
            right: 0.h,
            child: SizedBox(
              height: 100.h,
              child: const CustomBottomNavbar(),
            ),
          ),
        ],
      ),
    );
  }
}

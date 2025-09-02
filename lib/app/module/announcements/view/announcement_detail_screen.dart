import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  const AnnouncementDetailScreen({super.key});

  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titlewidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/dashboard/announcements.png",
                width: 50.w,
                height: 50.h,
              ),
              Text(
                "ANNOUNCEMENTS",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColor.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          trailingwidget: [
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
                  child: const Icon(FeatherIcons.bell, color: AppColor.white),
                ),
              ),
            ),
          ]),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 40.h,
              decoration: const BoxDecoration(
                color: AppColor.primary,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 597.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 530.h,
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 4, spreadRadius: 0)
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "NOTICE BOARDS",
                              style: AppTextTheme.textTheme.labelLarge
                                  ?.copyWith(
                                      color: AppColor.grey3,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              height: 470.h,
                              width: 330.w,
                              decoration: BoxDecoration(
                                color: AppColor.green,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Live Match",
                                          style: AppTextTheme
                                              .textTheme.labelLarge
                                              ?.copyWith(
                                            fontSize: 15,
                                            color: AppColor.textblack,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                          style: AppTextTheme
                                              .textTheme.labelLarge
                                              ?.copyWith(
                                            fontSize: 12,
                                            color: AppColor.textblack,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 40.h),
                                        //acer(),
                                        SizedBox(
                                          width: 170.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  const Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.black54),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    "6th March, 2024",
                                                    style: AppTextTheme
                                                        .textTheme.labelLarge
                                                        ?.copyWith(
                                                      fontSize: 10,
                                                      color: AppColor.textblack,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5.0),
                                              Row(
                                                children: <Widget>[
                                                  const Icon(Icons.access_time,
                                                      color: Colors.black54),
                                                  const SizedBox(width: 5.0),
                                                  Text(
                                                    "10:30 AM - 11:30 PM",
                                                    style: AppTextTheme
                                                        .textTheme.labelLarge
                                                        ?.copyWith(
                                                      fontSize: 10,
                                                      color: AppColor.textblack,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 10.h,
                                      right: 10.h,
                                      child: FloatingActionButton(
                                        shape: const CircleBorder(),
                                        backgroundColor: AppColor.white,
                                        onPressed: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              "assets/images/pdf_icon.png"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

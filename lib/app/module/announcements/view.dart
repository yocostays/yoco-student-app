import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/announcements/Widgets/cutom_calendar.dart';
import 'package:yoco_stay_student/app/module/announcements/Widgets/notice_board_card.dart';
import 'package:yoco_stay_student/app/module/announcements/view/announcement_detail_screen.dart';
import 'package:yoco_stay_student/app/module/announcements/view/notice_board_view.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

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
          Positioned(
            child: Container(
              height: 40.h,
              decoration: const BoxDecoration(
                color: AppColor.primary,
              ),
            ),
          ),
          SizedBox(
            height: 597.h,
            child: Column(
              children: [
                SizedBox(
                  height: 510.h,
                  child: SingleChildScrollView(
                    child: Column(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 230.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                    topLeft: Radius.circular(20.r),
                                  ),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 8,
                                        spreadRadius: 0,
                                        color: AppColor.grey3)
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 16.h),
                                        child: Text(
                                          "NOTICE BOARDS",
                                          style: AppTextTheme
                                              .textTheme.labelLarge
                                              ?.copyWith(
                                                  color: AppColor.grey3,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      NoticeBoardCarousel(
                                        noticeCards: [
                                          NoticeCard(
                                            title: 'Live Match',
                                            description:
                                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                            date: '6th March, 2024',
                                            time: '10:30 AM - 11:30 PM',
                                            backgroundColor: AppColor.green,
                                            onPressed: () {
                                              Get.to(
                                                  const AnnouncementDetailScreen());
                                            },
                                          ),
                                          NoticeCard(
                                            title: 'Lorem Ipsum',
                                            description:
                                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                            date: '10 March, 2024',
                                            time: '10:30 AM - 11:30 PM',
                                            backgroundColor: AppColor.yellow,
                                            onPressed: () {
                                              Get.to(const NoticeBoardScreen());
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.h),
                                child: Text(
                                  textAlign: TextAlign.left,
                                  "Holiday & events calendar".toUpperCase(),
                                  style: AppTextTheme.textTheme.labelLarge
                                      ?.copyWith(
                                          color: AppColor.grey3,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: const CustomCalendar(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

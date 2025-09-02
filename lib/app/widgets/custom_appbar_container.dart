// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class CutomAppBarContainer extends StatefulWidget {
  final String title;
  final List<Widget> contentWidgets;
  final bool? isTrailing;
  final double? height;
  final bool? isScroll;
  final bool? messmanagment;

  const CutomAppBarContainer({
    super.key,
    required this.title,
    required this.contentWidgets,
    this.isTrailing,
    this.height,
    this.isScroll = true,
    this.messmanagment,
  });

  @override
  State<CutomAppBarContainer> createState() => _CutomAppBarContainerState();
}

class _CutomAppBarContainerState extends State<CutomAppBarContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.messmanagment == false
          ? AppBar(
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
                  child: Container(
                    height: 15.h,
                    width: 15.h,
                    decoration: BoxDecoration(
                      color: AppColor.belliconbackround,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const Icon(
                      FeatherIcons.chevronLeft,
                      color: AppColor.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              backgroundColor: AppColor.primary,
              centerTitle: true,
              title: Text(
                widget.title,
                style: GoogleFonts.getFont(
                  "Quicksand",
                  fontWeight: FontWeight.w700,
                  fontSize: 13.sp,
                  color: AppColor.white,
                ),
              ),
              actions: [
                widget.isTrailing == false
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
                        child: InkWell(
                          onTap: () {
                            Get.to(const NotificationView());
                          },
                          child: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration: BoxDecoration(
                              color: AppColor.belliconbackround,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(const NotificationView());
                              },
                              child: const Icon(
                                FeatherIcons.bell,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            )
          : CustomAppBar(
              // title: "COMPLAINT MANAGEMENT",
              titlewidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/mess_managment/delicious-cartoon-style-food 1 (1).png",
                    width: 50.w,
                    height: 50.h,
                  ),
                  Text(
                    "MESS MANAGEMENT",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColor.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              trailingwidget: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Container(
                    width: 31.w,
                    height: 31.h,
                    decoration: BoxDecoration(
                      color: AppColor.lightpurple.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const NotificationView());
                      },
                      child: const Icon(
                        CupertinoIcons.bell,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: widget.height ?? 40.h,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: widget.isScroll == true
                ? SingleChildScrollView(
                    child: Column(
                      children: widget.contentWidgets,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: widget.contentWidgets,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class CustomAppBarContainer extends StatelessWidget {
  final String title;
  final List<Widget> contentWidgets;
  final bool isTrailing;
  final double? height;
  final bool isScroll;
  final bool isMessManagement;

  const CustomAppBarContainer({
    super.key,
    required this.title,
    required this.contentWidgets,
    this.isTrailing = true,
    this.height,
    this.isScroll = true,
    this.isMessManagement = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMessManagement
          ? _buildMessAppBar(context)
          : _buildNormalAppBar(context),
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: height ?? 40.h,
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
            child: SingleChildScrollView(
              physics: isScroll
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Column(children: contentWidgets),
            ),
          ),
        ],
      ),
    );
  }

  /// Normal AppBar
  PreferredSizeWidget _buildNormalAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primary,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Container(
          decoration: BoxDecoration(
            color: AppColor.belliconbackround,
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.all(6.w),
          child: const Icon(FeatherIcons.chevronLeft, color: AppColor.white),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w700,
          fontSize: 14.sp,
          color: AppColor.white,
        ),
      ),
      actions: isTrailing
          ? [
              IconButton(
                onPressed: () => Get.to(const NotificationView()),
                icon: Container(
                  decoration: BoxDecoration(
                    color: AppColor.belliconbackround,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.all(6.w),
                  child: const Icon(FeatherIcons.bell, color: AppColor.white),
                ),
              )
            ]
          : [],
    );
  }

  /// Mess Management AppBar
  PreferredSizeWidget _buildMessAppBar(BuildContext context) {
    return CustomAppBar(
      titlewidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/mess_managment/delicious-cartoon-style-food 1 (1).png",
            width: 40.w,
            height: 40.h,
          ),
          SizedBox(width: 8.w),
          Text(
            "MESS MANAGEMENT",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
          )
        ],
      ),
      trailingwidget: [
        IconButton(
          onPressed: () => Get.to(const NotificationView()),
          icon: Container(
            decoration: BoxDecoration(
              color: AppColor.lightpurple.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.all(6.w),
            child: const Icon(CupertinoIcons.bell, color: AppColor.white),
          ),
        ),
      ],
    );
  }
}

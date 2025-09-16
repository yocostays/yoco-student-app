import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class Dashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final HomeController homeController = HomeController();

  Dashboard({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    homeController.GetTotalData();
    return Stack(
      children: [
        Center(
          child: Obx(
            () => Container(
              width: 340.w,
              height: 287.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      // Events Status (slightly top-left)
                      _buildDashboardItem(
                        context,
                        color: AppColor.secondary.withOpacity(0.4),
                        imagePath: 'assets/images/dashboard/event.png',
                        textColor: AppColor.textblack,
                        number:
                            homeController.HometotalData.value.eventCount ??
                                0,
                        label: 'Events Status',
                        ontap: () {
                          Utils.showAlertDialog(context, 'Alert',
                              'Events Status Section coming soon.');
                        },
                      ),

                      // Announcement (slightly lower)
                      _buildDashboardItem(
                        context,
                        color: AppColor.purple,
                        imagePath:
                            'assets/images/dashboard/announcements.png',
                        textColor: AppColor.white,
                        number: homeController
                                .HometotalData.value.announcement ??
                            0,
                        label: 'Announcement',
                        ontap: () {
                          Utils.showAlertDialog(context, 'Alert',
                              'Announcement Section coming soon.');
                        },
                      ),

                      // Approval Status
                      _buildDashboardItem(
                        context,
                        color: AppColor.primary.withOpacity(0.4),
                        imagePath: 'assets/images/dashboard/approval.png',
                        textColor: AppColor.primary,
                        number:
                            homeController.HometotalData.value.leaveCount ?? 0,
                        label: 'Leave Status',
                        ontap: () {
                          // Get.toNamed(AppRoute.ApprovalStatus);
                          Get.toNamed(AppRoute.leavepage);
                        },
                      ),

                      // Complaint
                      _buildDashboardItem(
                        context,
                        color: AppColor.primary,
                        textColor: AppColor.white,
                        imagePath: 'assets/images/dashboard/complaints.png',
                        number: homeController.HometotalData.value.complainCount ?? 0,
                        label: 'Complaint',
                        ontap: () {
                          Get.toNamed(AppRoute.complainmanagment);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardItem(
    BuildContext context, {
    required Color color,
    required String imagePath,
    required int number,
    required String label,
    required Color textColor,
    required Function() ontap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            height: 113.h,
            width: 136.w,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: AppTextTheme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$number',
                      style: AppTextTheme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: textColor,
                      ),
                    ),
                    Image.asset(
                      imagePath,
                      scale: 3.8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

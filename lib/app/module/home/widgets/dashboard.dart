import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';

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
              // height: 315.h,    Commenting as Event status and Anauncemnt are hidden
              height: 185.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
// TO-DO commenting as functionality is not developed

                      // _buildDashboardItem(
                      //   context,
                      //   color: AppColor.secondary.withOpacity(0.4),
                      //   imagePath:
                      //       'assets/images/dashboard/event.png', // Example path
                      //   textColor: AppColor.textblack,
                      //   number:
                      //       homeController.HometotalData.value.eventCount ?? 0,
                      //   label: 'Events Status',
                      //   ontap: () {
                      //     Utils.showAlertDialog(context, 'Alert',
                      //         'Events Status Section coming soon.');

                      //     // Get.toNamed(AppRoute.eventhome);
                      //   },
                      // ),
                      // _buildDashboardItem(
                      //   context,
                      //   color: AppColor.purple,
                      //   imagePath:
                      //       'assets/images/dashboard/announcements.png', // Example path
                      //   textColor: AppColor.white,
                      //   number:
                      //       homeController.HometotalData.value.announcement ??
                      //           0,
                      //   label: 'Announcement',
                      //   ontap: () {
                      //     Utils.showAlertDialog(context, 'Alert',
                      //         'Announcement Section coming soon.');

                      //     // Get.to(AnnouncementScreen());
                      //   },
                      // ),
                      _buildDashboardItem(
                        context,
                        color: AppColor.primary.withOpacity(0.4),
                        imagePath:
                            'assets/images/dashboard/approval.png', // Example path
                        textColor: AppColor.primary,
                        number:
                            homeController.HometotalData.value.leaveCount ?? 0,
                        label: 'Approval Status',
                        ontap: () {
                          // Get.to(ApprovalStatusPage());
                          Get.toNamed(AppRoute.ApprovalStatus);
                        },
                      ),
                      _buildDashboardItem(
                        context,
                        color: AppColor.primary,
                        textColor: AppColor.white,
                        imagePath:
                            'assets/images/dashboard/complaints.png', // Example path
                        number:
                            homeController.HometotalData.value.complainCount ??
                                0,
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
        // Positioned(
        //   right: 0,
        //   top: 145.h,
        //   child: GestureDetector(
        //     onTap: () {
        //       scaffoldKey.currentState?.openEndDrawer();
        //     },
        //     child: Container(
        //       width: 30.h,
        //       height: 40.h,
        //       decoration: BoxDecoration(
        //         color: AppColor.primary,
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(30),
        //           bottomLeft: Radius.circular(30),
        //         ),
        //       ),
        //       child: Icon(
        //         Icons.chevron_left,
        //         color: Colors.white,
        //         size: 24.h,
        //       ),
        //     ),
        //   ),
        // ),
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
            height: 114.h,
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
                  style: AppTextTheme.textTheme.displayMedium
                      ?.copyWith(fontWeight: FontWeight.w700, color: textColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$number',
                      style: AppTextTheme.textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: textColor),
                    ),
                    Image.asset(
                      imagePath,
                      scale: 3.8,
                      // color: textColor,
                      // height: 66.h,
                      // width: 65.h,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';

import 'dart:ui';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
              // color:
              //     AppColor.primary.withOpacity(0.3),
              ),
        ),
        Positioned(
          right: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 690.h,
            child: Drawer(
              elevation: 2,
              backgroundColor: AppColor.primary.withOpacity(0.85),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 30.w, top: 45.h, bottom: 0.h, right: 0.w),
                    child: GridView.count(
                      // padding: EdgeInsets.zero,
                      crossAxisCount: 1,
                      childAspectRatio: (80 / 70),
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      children: <Widget>[
                        // _buildDrawerItem(
                        //     context,
                        //     'assets/images/drawer/emergency.png',
                        //     'Emergency', () {
                        //   // Get.toNamed(AppRoute.Emergencytabpage);
                        // }),
                        _buildDrawerItem(
                            context,
                            'assets/images/drawer/complaint.png',
                            'Complaint', () {
                          Get.toNamed(AppRoute.complainmanagment);
                        }),
                        _buildDrawerItem(
                            context, 'assets/images/drawer/leave.png', 'Leave',
                            () {
                          Get.toNamed(AppRoute.leavepage);
                        }),
                        _buildDrawerItem(
                            context, 'assets/images/drawer/mess.png', 'Mess',
                            () {
                          // Get.to(() => MessManagmentPage());
                          Get.toNamed(AppRoute.messmanagmentpage);
                        }),
                        _buildDrawerItem(
                            context,
                            'assets/images/drawer/daynight.png',
                            'Day / Night Out', () {
                          // Get.to(() => GetPassPages());
                          Get.toNamed(AppRoute.daynightout);
                        }),
                        // _buildDrawerItem(context,
                        //     'assets/images/drawer/late.png', 'Late Entry', () {
                        //   Get.toNamed(AppRoute.latepage);
                        // }),
                        // _buildDrawerItem(
                        //     context,
                        //     'assets/images/drawer/payment.png',
                        //     'My Payments', () {
                        //   Get.to(MyPaymentPage());
                        // }),
                        // _buildDrawerItem(context,
                        //     'assets/images/drawer/parcel.png', 'Parcel', () {
                        //   Get.to(() => ParcelPage());
                        //   print('Parcel tapped');
                        // }),
                        // _buildDrawerItem(context,
                        //     'assets/images/drawer/polling.png', 'Polling', () {
                        //   Get.to(() => PollingScreen());
                        // }),
                        // _buildDrawerItem(
                        //     context,
                        //     'assets/images/drawer/amenities.png',
                        //     'Amenities Booking', () {
                        //   Get.to(AmenitiesBooking());
                        // }),
                        // _buildDrawerItem(context, 'assets/images/drawer/ev.png',
                        //     'EV Slot Booking', () {
                        //   Get.to(() => EvSlotPage());
                        // }),
                        // _buildDrawerItem(
                        //     context,
                        //     'assets/images/drawer/vehicle.png',
                        //     'Vehicle Pass', () {
                        //   Get.to(() => VisitorParkingStatus());
                        //   // Get.to(MessAttendance());
                        // }),
                        // _buildDrawerItem(
                        //     context,
                        //     'assets/images/drawer/Attendance.png',
                        //     'My Attendance', () {
                        //   Get.to(MyAttendance());
                        //   // Get.to(MessAttendance());
                        // }),
                        // _buildDrawerItem(
                        //     context,
                        //     'assets/images/drawer/community.png',
                        //     'Community', () {
                        //   Get.to(() => CommunityScreen());
                        // }),
                        // _buildDrawerItem(
                        //     context,
                        //     'assets/images/drawer/Suggestions.png',
                        //     'Suggestion', () {
                        //   Get.to(SuggestionPage());
                        //   // Get.to(MessAttendance());
                        // }),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2 - 24,
                    left: 10.w,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItem(BuildContext context, String assetPath, String title,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 200.h,
        child: Column(
          children: [
            Container(
              height: 70.h,
              width: 70.h,
              margin: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 80.h,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  textAlign: TextAlign.center,
                  title,
                  style: AppTextTheme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.textwhite,
                      fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

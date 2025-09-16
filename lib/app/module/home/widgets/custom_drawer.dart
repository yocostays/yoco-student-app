import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'dart:async';

class DrawerArrowController extends GetxController {
  var offsetX = 0.0.obs; // horizontal slide offset
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // Animate every 1.2 seconds
    _timer = Timer.periodic(const Duration(milliseconds: 1200), (_) {
      _animateArrow();
    });
  }

  void _animateArrow() async {
    // Slide right
    offsetX.value = 12.0;
    await Future.delayed(const Duration(milliseconds: 300));

    // Slide left (like bounce)
    offsetX.value = -8.0;
    await Future.delayed(const Duration(milliseconds: 300));

    // Settle back to center
    offsetX.value = 0.0;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerArrowCtrl = Get.put(DrawerArrowController());

    final items = [
      DrawerItem("assets/images/drawer/emergency.png", "Emergency",
          () => Get.toNamed(AppRoute.Emergencytabpage)),
      DrawerItem("assets/images/drawer/complaint.png", "Complaint",
          () => Get.toNamed(AppRoute.complainmanagment)),
      DrawerItem("assets/images/drawer/leave.png", "Leave",
          () => Get.toNamed(AppRoute.leavepage)),
      DrawerItem("assets/images/drawer/mess.png", "Mess",
          () => Get.toNamed(AppRoute.messmanagmentpage)),
      // DrawerItem("assets/images/drawer/daynight.png", "Day / Night Out",
      //     () => Get.toNamed(AppRoute.daynightout)),
      // DrawerItem("assets/images/drawer/late.png", "Late Entry",
      //     () => Get.toNamed(AppRoute.latepage)),
      // DrawerItem("assets/images/drawer/payment.png", "My Payments",
      //     () => Get.toNamed(AppRoute.paymentpage)),
      // DrawerItem("assets/images/drawer/parcel.png", "Parcel",
      //     () => Get.toNamed(AppRoute.parcelpage)),
      // DrawerItem("assets/images/drawer/polling.png", "Polling",
      //     () => Get.toNamed(AppRoute.pollingpage)),
      // DrawerItem("assets/images/drawer/amenities.png", "Amenities Booking",
      //     () => Get.toNamed(AppRoute.amenitiesBooking)),
      // DrawerItem("assets/images/drawer/ev.png", "EV Slot Booking",
      //     () => Get.toNamed(AppRoute.evslotpage)),
      // DrawerItem("assets/images/drawer/vehicle.png", "Vehicle Pass",
      //     () => Get.toNamed(AppRoute.visitorParking)),
      // DrawerItem("assets/images/drawer/Attendance.png", "My Attendance",
      //     () => Get.toNamed(AppRoute.attendancePage)),
      // DrawerItem("assets/images/drawer/community.png", "Community",
      //     () => Get.toNamed(AppRoute.communityPage)),
      // DrawerItem("assets/images/drawer/Suggestions.png", "Suggestion",
      //     () => Get.toNamed(AppRoute.suggestionPage)),
    ];

    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(color: AppColor.primary.withOpacity(0.2)),
        ),

        // Right-side Drawer
        Positioned(
          right: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height,
            child: Drawer(
              elevation: 4,
              backgroundColor: AppColor.primary.withOpacity(0.95),
              child: Stack(
                children: [
                  // Drawer items list
                  ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      // Delay factor for staggered animation
                      final delay = index * 300; // each item delayed by 300ms

                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1.0, end: 0.0),
                        duration: const Duration(milliseconds: 800),
                        curve: Interval(
                          index * 0.2, // stagger each item
                          1.0,
                          curve: Curves.easeOutBack,
                        ),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(200 * value, 0), // slide from right
                            child: Opacity(
                              opacity:
                                  (1 - value).clamp(0.0, 1.0), // ✅ Safe opacity
                              child: child,
                            ),
                          );
                        },
                        child: _buildDrawerItem(context, item),
                      );
                    },
                  ),

                  // ✅ Animated drawer arrow
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2 - 24,
                    left: 10.w,
                    child: Obx(() {
                      return GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                            shape: BoxShape.circle,
                          ),
                          child: Transform.translate(
                            offset: Offset(drawerArrowCtrl.offsetX.value, 0),
                            child: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Drawer item builder
  Widget _buildDrawerItem(BuildContext context, DrawerItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Column(
          children: [
            Container(
              height: 65.h,
              width: 65.h,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Image.asset(item.icon, fit: BoxFit.contain),
            ),
            SizedBox(
              width: 80.h,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: AppTextTheme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColor.textwhite,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Drawer Item Model
class DrawerItem {
  final String icon;
  final String title;
  final VoidCallback onTap;
  DrawerItem(this.icon, this.title, this.onTap);
}

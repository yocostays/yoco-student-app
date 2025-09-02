import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/values/colors.dart';
import '../module/home/view.dart';

class BottomNavigation extends StatelessWidget {
  final bool? home;
  const BottomNavigation({
    super.key,
    this.home,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: home == true
          ? const Color(0xffFDFAFF)
          : AppColor.primary
              .withOpacity(0.2), // Background color for the BottomAppBar
      shape: const CircularNotchedRectangle(),
      notchMargin: -10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              FeatherIcons.home,
              color:
                  // _selectedIndex == 0
                  // ?
                  AppColor.primary,
              // : AppColor.grey4,
              size: 24.h,
            ),
            onPressed: () {
              Get.to(() => const DashboardPage());
            },
          ),
          const SizedBox(width: 40),
          // Space for the FloatingActionButton
          // IconButton(
          //   icon: Icon(
          //     FeatherIcons.users,
          //     color:
          //         //  _selectedIndex == 2
          //         //     ?
          //         AppColor.primary,
          //     // : AppColor.grey4,
          //     size: 24.h,
          //   ),
          //   onPressed: () {
          //     // Get.to(() => CommunityScreen());
          //   },
          // ),
        ],
      ),
    );
  }
}

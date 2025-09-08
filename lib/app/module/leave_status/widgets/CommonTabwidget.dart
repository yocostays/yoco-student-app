import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class CommonTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;

  const CommonTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(40.r),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBar(
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: Colors.white),
          insets: EdgeInsets.only(bottom: 60, left: 50, right: 50),
        ),
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
        labelStyle: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColor.white,
        unselectedLabelColor: AppColor.white,
      ),
    );
  }
}

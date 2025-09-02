// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view.dart';

import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/module/profile/widgets/profiles-tabs.dart';
import 'package:yoco_stay_student/app/module/profile/widgets/user_detail_page.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CustomAppBar(
        onLeadingPressed: () {
          Get.to(() => DashboardPage());
        },
        title: 'MY PROFILE',
        trailingwidget: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 14),
          //   child: Icon(
          //     Icons.share,
          //     color: AppColor.white,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                _showLogoutDialog(context);
              },
              child: Icon(
                CupertinoIcons.power,
                color: AppColor.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  userData(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(child: SingleChildScrollView(child: profileTab())),
                  // profileFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: CenterButton(),
      // bottomNavigationBar: BottomNavigation(),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you sure you want to Exit?",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColor.textblack,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            CustomButton(
              Title: "Yes",
              ontap: () async {
                profileController.LogOut();
              },
              width: 100.w,
              BoxColor: AppColor.primary,
              textcolor: AppColor.white,
              Textsize: 20,
            ),
            CustomButton(
              Title: "No",
              ontap: () {
                Get.back();
              },
              width: 100.w,
              BoxColor: AppColor.primary,
              textcolor: AppColor.white,
              Textsize: 20,
            ),
          ],
        );
      },
    );
  }
}

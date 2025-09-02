import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/Attendance/View/mess_management_view.dart';
import 'package:yoco_stay_student/app/module/Attendance/View/my_attendance_detail.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';

class MyAttendance extends StatefulWidget {
  const MyAttendance({super.key});

  @override
  State<MyAttendance> createState() => _MyAttendanceState();
}

class _MyAttendanceState extends State<MyAttendance> {
  @override
  Widget build(BuildContext context) {
    return CutomAppBarContainer(
      title: "MY ATTENDANCE ",
      messmanagment: false,
      contentWidgets: [
        Container(
          height: 670.h,
          width: double.infinity.w,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              boxShadow: const [
                // BoxShadow(color: AppColor.grey3, spreadRadius: 1, blurRadius: 1)
              ]),
          padding: EdgeInsets.only(left: 11.w, right: 11.w, top: 16.h),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(const MyAttendanceDetail());
                },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primary.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(-1, -2),
                      ),
                      BoxShadow(
                        color: AppColor.primary.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(1, 0),
                      ),
                      BoxShadow(
                        color: AppColor.grey2.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 2),
                      ),
                      BoxShadow(
                        color: AppColor.grey2.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(-1, 2),
                      ),
                      BoxShadow(
                        color: AppColor.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(-1, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Daily Attendance",
                          style: AppTextTheme.textTheme.displayLarge
                              ?.copyWith(color: AppColor.textblack),
                        ),
                        const Icon(
                          FeatherIcons.arrowRight,
                          color: AppColor.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  Get.to(const MessAttendance());
                },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primary.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(-1, -2),
                      ),
                      BoxShadow(
                        color: AppColor.primary.withOpacity(0.7),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(1, 0),
                      ),
                      BoxShadow(
                        color: AppColor.grey2.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(1, 2),
                      ),
                      BoxShadow(
                        color: AppColor.grey2.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(-1, 2),
                      ),
                      BoxShadow(
                        color: AppColor.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(-1, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mess Attendance",
                          style: AppTextTheme.textTheme.displayLarge
                              ?.copyWith(color: AppColor.textblack),
                        ),
                        const Icon(
                          FeatherIcons.arrowRight,
                          color: AppColor.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

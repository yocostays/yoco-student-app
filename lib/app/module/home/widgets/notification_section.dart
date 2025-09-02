import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';

class NotificationSection extends StatelessWidget {
  const NotificationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 160.h,
      // width: 340.w,
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      FeatherIcons.bell,
                      color: AppColor.primary,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    Text(
                      "Notification",
                      style: AppTextTheme.textTheme.displayMedium?.copyWith(
                          color: AppColor.primary, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Get.to(const NotificationView());
                  },
                  child: Text(
                    "See All",
                    style: AppTextTheme.textTheme.displayMedium?.copyWith(
                        color: AppColor.grey3, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            ListView.builder(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3, // Assuming you have 3 items in your list
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   width: 100.w,
                        //   child: Text("BREAKFAST:",
                        //       style: AppTextTheme
                        //           .textTheme.displayMedium
                        //           ?.copyWith(
                        //               fontWeight:
                        //                   FontWeight.w700,
                        //               color: AppColor
                        //                   .textblack)),
                        // ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text("NA", // Replace with your content
                            style: AppTextTheme.textTheme.displayMedium
                                ?.copyWith(color: AppColor.textblack)),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      height: 1.h,
                      color: Colors.black87,
                    ),
                    SizedBox(
                      height: 10.h, // Adjust this for your desired spacing
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

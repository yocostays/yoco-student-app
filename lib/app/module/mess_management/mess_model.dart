import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/mess_management/repository.dart';

import '../../core/theme/texttheme.dart';
import '../../core/values/colors.dart';

class MessManagmentData extends StatelessWidget {
  final MessController messController = Get.put(MessController());
  MessManagmentData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => messController.MealdataLoading.value == true
          ? Container()
          : Container(
              // height: 190.h,
              width: 340.w,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(20.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4, // Assuming you have 3 items in your list
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: Text(
                                    index == 0
                                        ? "BREAKFAST:"
                                        : index == 1
                                            ? "LUNCH"
                                            : index == 2
                                                ? "SNACKS"
                                                : index == 3
                                                    ? "DINNER"
                                                    : "",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    index == 0
                                        ? messController.todayMealData.value
                                                .breakfast ??
                                            "NA"
                                        : index == 1
                                            ? messController.todayMealData
                                                    .value.lunch ??
                                                "NA"
                                            : index == 2
                                                ? messController.todayMealData
                                                        .value.snacks ??
                                                    "NA"
                                                : index == 3
                                                    ? messController
                                                            .todayMealData
                                                            .value
                                                            .dinner ??
                                                        "NA"
                                                    : "",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                    ),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10
                                  .h, // Adjust this for your desired spacing
                            ),
                            Divider(
                              height: 1.h,
                              color: AppColor.textwhite,
                            ),
                            SizedBox(
                              height: 10
                                  .h, // Adjust this for your desired spacing
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

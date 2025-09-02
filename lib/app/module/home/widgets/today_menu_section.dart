import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

class TodayMenuSection extends StatelessWidget {
  final HomeController homeController = HomeController();
  TodayMenuSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    homeController.GetTodayMealData();
    return Obx(() => Container(
          // height: 160.h,
          // width: 340.w,
          decoration: BoxDecoration(
              color: AppColor.white, borderRadius: BorderRadius.circular(20.r)),
          child: homeController.MealdataLoading.value == true
              ? const CustomShimmer()
              : homeController.todayMealData.value.date == ""
                  ? Center(
                      child: Text(
                        "Data is Not Available.",
                        style: AppTextTheme.textTheme.displayMedium?.copyWith(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 10.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today's Menu",
                                style: AppTextTheme.textTheme.displayMedium
                                    ?.copyWith(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Get.to(SeeAll());
                                  Get.toNamed(AppRoute.messmanagmentpage);
                                },
                                child: Text(
                                  "See All",
                                  style: AppTextTheme.textTheme.displayMedium
                                      ?.copyWith(
                                          color: AppColor.grey3,
                                          fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                4, // Assuming you have 3 items in your list
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
                                            style: AppTextTheme
                                                .textTheme.displayMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColor.textblack)),
                                      ),
                                      Expanded(
                                        child: Text(
                                            // homeController.todayMealData.value
                                            //         .breakfast ??
                                            //     "", // Replace with your content
                                            index == 0
                                                ? homeController.todayMealData
                                                        .value.breakfast ??
                                                    "NA"
                                                : index == 1
                                                    ? homeController
                                                            .todayMealData
                                                            .value
                                                            .lunch ??
                                                        "NA"
                                                    : index == 2
                                                        ? homeController
                                                                .todayMealData
                                                                .value
                                                                .snacks ??
                                                            "NA"
                                                        : index == 3
                                                            ? homeController
                                                                    .todayMealData
                                                                    .value
                                                                    .dinner ??
                                                                "NA"
                                                            : "",
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextTheme
                                                .textTheme.displayMedium
                                                ?.copyWith(
                                                    color: AppColor.textblack)),
                                      )
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
        ));
  }
}

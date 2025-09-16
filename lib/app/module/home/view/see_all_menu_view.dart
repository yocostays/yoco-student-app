import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  final HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();
    homeController.GetTodayMealData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarContainer(
      title: 'See All Menu',
      isMessManagement: false,
      contentWidgets: [
        Container(
          height: 570.h,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(color: AppColor.grey3, spreadRadius: 1, blurRadius: 1)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Obx(
              () => homeController.MealdataLoading.value == true
                  ? const Loader()
                  : ListView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
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
                                              ? homeController.todayMealData
                                                      .value.lunch ??
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
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextTheme
                                          .textTheme.displayMedium
                                          ?.copyWith(
                                              color: AppColor.textblack))),
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
                  ),
            ),
          ),
        ),
      ],
      isTrailing: false,
    );
  }
}

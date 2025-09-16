import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/controller/suggation_controller.dart';
import 'package:yoco_stay_student/app/module/home/widgets/custom_textfield_limit.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  SuggationController controller = Get.put(SuggationController());
  String selectedCategory = 'Mess Management';
  TextEditingController suggestionController = TextEditingController();
  final int maxLength = 200;
  @override
  Widget build(BuildContext context) {
    return CustomAppBarContainer(
        title: "SUGGESTIONS",
      
        isMessManagement: false,
        contentWidgets: [
          SizedBox(
            width: 350.w,
            height: 570.h,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 320.w,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(-1, -2),
                        ),
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 1,
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
                      ],
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SELECT CATEGORY",
                            style: AppTextTheme.textTheme.displayLarge
                                ?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.grey3),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 60.w),
                            decoration: BoxDecoration(
                              color: AppColor.lightpurple,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selectedCategory,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Mess Management',
                                  'Category 2',
                                  'Category 3'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: AppTextTheme.textTheme.displayLarge
                                          ?.copyWith(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.textblack),
                                    ),
                                  );
                                }).toList(),
                                underline: const SizedBox(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          SuggationWriteDescriotion(controller: controller),
                          // Container(
                          //   height: 70.h,
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 12.w, vertical: 5.h),
                          //   decoration: BoxDecoration(
                          //     color: AppColor.lightyellow,
                          //     borderRadius: BorderRadius.circular(20.r),
                          //   ),
                          //   child: Center(
                          //     child: TextField(
                          //       controller: suggestionController,
                          //       maxLength: maxLength,
                          //       maxLines: 2,
                          //       decoration: InputDecoration(
                          //         border: InputBorder.none,
                          //         counterText:
                          //             '${suggestionController.text.length}/$maxLength',
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10.h,
                  right: -15.h,
                  child: Padding(
                    padding: EdgeInsets.all(8.h),
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(8.h),
                        child: Container(
                          width: 323.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.grey4.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 5,
                              ),
                            ],
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20.r)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: CustomButton(
                                ontap: () {},
                                Title: 'Submit',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}

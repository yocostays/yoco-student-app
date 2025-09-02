import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/widgets/action_assign_card.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class ProfileActionAndAssigned extends StatelessWidget {
  final String title;
  const ProfileActionAndAssigned({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      controller.GetProfileData();
      return Scaffold(
        appBar: CustomAppBar(title: title, trailingwidget: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: InkWell(
              onTap: () {
                Get.to(const NotificationView());
              },
              child: Container(
                width: 31.w,
                height: 31.h,
                decoration: BoxDecoration(
                  color: AppColor.belliconbackround,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(
                  CupertinoIcons.bell,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ]),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: stackcontainer(
            writedata: title == "INDISCIPLINARY ACTION"
                ? Obx(() => controller.profiledetailLoading.value == true
                    ? const Loader()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller
                            .profileDatas.value.indisciplinaryActions!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Action_Assign_Card(
                                name: controller.profileDatas.value.name ??
                                    "".toUpperCase(),
                                date: DateTime.parse(
                                  controller
                                          .profileDatas
                                          .value
                                          .indisciplinaryActions![index]
                                          .createdAt ??
                                      "",
                                ),
                                fine: controller.profileDatas.value
                                    .indisciplinaryActions![index].isFine,
                                fineamount: controller.profileDatas.value
                                    .indisciplinaryActions![index].fineAmount,
                                title: title == "INDISCIPLINARY ACTION"
                                    ? 'Remark:'
                                    : "Inventory:",
                                discription: title == "INDISCIPLINARY ACTION"
                                    ? controller
                                            .profileDatas
                                            .value
                                            .indisciplinaryActions![index]
                                            .remark ??
                                        ""
                                    : ' Bedsheet, Pillow',
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          );
                        },
                      ))
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 490.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Action_Assign_Card(
                                    name: 'Harsh Jogi',
                                    date: DateTime(2024, 2, 22),
                                    title: title == "INDISCIPLINARY ACTION"
                                        ? 'Remark:'
                                        : "Inventory:",
                                    discription: title ==
                                            "INDISCIPLINARY ACTION"
                                        ? ' Unethical behavior in hostel premises.'
                                        : ' Bedsheet, Pillow',
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const Divider(
                          color: AppColor.black,
                          thickness: 0.2,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: CustomButton(
                            ontap: () {},
                            Title: 'Submit',
                            BoxColor: AppColor.textprimary,
                            Boderradius: 20,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }
}

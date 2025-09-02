// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/module/profile/widgets/alertTextFiled.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

// ignore: must_be_immutable
class HostalDetail extends StatelessWidget {
  bool hostaldata;
  HostalDetail({
    super.key,
    required this.hostaldata,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      // hostaldata == true
      controller.GetHostelData();
      controller.GetProfileData();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          centerTitle: true,
          title: Text(
            hostaldata == true ? 'HOSTAL DETAILS' : "FAMILY / PERSONAL DETAILS",
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColor.white, fontSize: 14),
          ),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              width: 31.w,
              height: 31.h,
              decoration: BoxDecoration(
                color: AppColor.belliconbackround,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  CupertinoIcons.chevron_back,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
          actions: [
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
            )
          ],
        ),
        body: Obx(() {
          // List<Detail> hostaldetail = [
          //   Detail(name: "YOCO ID", url: TokenStorage.getUseruniqueId()),
          //   Detail(
          //       name: "RESIDENT OF",
          //       url: controller.hostelDetailsDatas.value.address ?? "NA"),
          //   Detail(
          //       name: "ROOM NUMBER / BED NUMBER",
          //       url: controller.hostelDetailsDatas.value.bedDetails ?? "NA"),
          //   Detail(
          //       name: "NAME OF ROOMMATE",
          //       url: (controller.hostelDetailsDatas.value.roomMates?.isEmpty ??
          //               true)
          //           ? "NA"
          //           : controller.hostelDetailsDatas.value.roomMates
          //                   ?.join(", ") ??
          //               "NA"),
          //   Detail(
          //       name: "CONTACT NUMBER",
          //       url: controller.hostelDetailsDatas.value.phone ?? "NA"),
          //   Detail(
          //       name: "LOCAL GUARDIAN",
          //       url: controller.hostelDetailsDatas.value.guardianContactNo ??
          //           "NA"),
          // ];

          // List<Detail> familydetail = [
          //   Detail(
          //       name: "BLOOD GROUP",
          //       url: controller.profileDatas.value.bloodGroup ?? "NA"),
          //   Detail(name: "ANY Medical ISSUE (Optional)", url: "NO"),
          //   Detail(
          //       name: "DATE OF BIRTH",
          //       url: hostaldata == true
          //           ? Utils.formatSelectedDateYear(
          //               DateTime.parse("1995-09-25T00:00:00.000Z"))
          //           : controller.profileDatas.value.dob == null
          //               ? Utils.formatSelectedDateYear(
          //                   DateTime.parse("1995-09-25T00:00:00.000Z"))
          //               : Utils.formatSelectedDateYear(DateTime.parse(
          //                   "${controller.profileDatas.value.dob}"))),
          //   Detail(
          //       name: "EMAIL ID",
          //       url: controller.profileDatas.value.email ?? "Na"),
          //   Detail(
          //       name: "PARENTS NAME",
          //       url: controller.profileDatas.value.fatherName ?? "Na"),
          //   Detail(
          //       name: "PARENTS MOBILE NUMBER",
          //       url: controller.profileDatas.value.fatherNumber ?? "Na"),
          //   Detail(
          //       name: "PARENTS EMAIL ID (Optional)",
          //       url: controller.profileDatas.value.fatherEmail ?? "Na"),

          //   // mother section
          //   Detail(
          //       name: "PARENTS NAME",
          //       url: "${controller.profileDatas.value.motherName ?? "Na"}"),
          //   Detail(
          //       name: "PARENTS MOBILE NUMBER",
          //       url: "${controller.profileDatas.value.motherNumber ?? "Na"}"),
          //   Detail(
          //       name: "PARENTS EMAIL ID (Optional)",
          //       url: "${controller.profileDatas.value.motherEmail ?? "Na"}"),
          // ];

          List<Detail> hostaldetail = [
            Detail(
                name: "YOCO ID",
                url: controller.profileDatas.value.uniqueId ?? "NA"),
            Detail(
                name: "RESIDENT OF",
                url: controller.hostelDetailsDatas.value.address ?? "NA"),
            Detail(
                name: "ROOM NUMBER / BED NUMBER",
                url: controller.hostelDetailsDatas.value.bedDetails
                        ?.toString() ??
                    "NA"),
            Detail(
                name: "NAME OF ROOMMATE",
                url: (controller.hostelDetailsDatas.value.roomMates?.isEmpty ??
                        true)
                    ? "NA"
                    : controller.hostelDetailsDatas.value.roomMates
                            ?.join(", ") ??
                        "NA"),
            Detail(
                name: "CONTACT NUMBER",
                url: controller.hostelDetailsDatas.value.phone?.toString() ??
                    "NA"),
            Detail(
                name: "LOCAL GUARDIAN",
                url: controller.hostelDetailsDatas.value.guardianContactNo
                        ?.toString() ??
                    "NA"),
          ];

          List<Detail> familydetail = [
            Detail(
                name: "BLOOD GROUP",
                url: controller.profileDatas.value.bloodGroup ?? "NA"),
            Detail(name: "ANY Medical ISSUE (Optional)", url: "NO"),
            Detail(
                name: "DATE OF BIRTH",
                url: controller.profileDatas.value.dob == null
                    ? Utils.formatSelectedDateYear(
                        DateTime.parse("1995-09-25T00:00:00.000Z"))
                    : Utils.formatSelectedDateYear(DateTime.parse(
                        "${controller.profileDatas.value.dob}"))),
            Detail(
                name: "EMAIL ID",
                url: controller.profileDatas.value.email ?? "NA"),
            Detail(
                name: "FATHER NAME",
                url: controller.profileDatas.value.fatherName ?? "NA"),
            Detail(
                name: "FATHER MOBILE NUMBER",
                url: controller.profileDatas.value.fatherNumber?.toString() ??
                    "NA"),
            Detail(
                name: "FATHER EMAIL ID (Optional)",
                url: controller.profileDatas.value.fatherEmail ?? "NA"),
            Detail(
                name: "MOTHER NAME",
                url: controller.profileDatas.value.motherName ?? "NA"),
            Detail(
                name: "MOTHER MOBILE NUMBER",
                url: controller.profileDatas.value.motherNumber?.toString() ??
                    "NA"),
            Detail(
                name: "MOTHER EMAIL ID (Optional)",
                url: controller.profileDatas.value.motherEmail ?? "NA"),
          ];
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                ),
                Positioned(
                  top: 25,
                  left: 11,
                  right: 10,
                  child: Container(
                      width: 339.w,
                      height: 570.h,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15.0),
                        // border: Border.all(
                        //   color: Colors.blue,
                        //   width: 2,
                        // ),
                        boxShadow: [
                          // BoxShadow(
                          //   color: AppColor.primary.withOpacity(0.2),
                          //   spreadRadius: 1,
                          //   blurRadius: 5,
                          //   offset:
                          //       Offset(-1, -2), // changes position of shadow
                          // ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: controller.profiledetailLoading.value == true
                          ? const CustomShimmer()
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 21.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 33,
                                      right: 37,
                                    ),
                                    child: hostaldata == true
                                        ? ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: hostaldetail.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  ProfileInfoRow(
                                                    label: hostaldetail[index]
                                                        .name,
                                                    value:
                                                        hostaldetail[index].url,
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  )
                                                ],
                                              );
                                            },
                                          )
                                        : ListView.builder(
                                            physics: hostaldata == true
                                                ? const NeverScrollableScrollPhysics()
                                                : const ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: familydetail.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(
                                                children: [
                                                  ProfileInfoRow(
                                                    label: familydetail[index]
                                                        .name,
                                                    value:
                                                        familydetail[index].url,
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            )),
                )
              ],
            ),
          );
        }),
      );
    });
  }
}

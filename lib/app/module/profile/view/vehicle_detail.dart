// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/module/profile/widgets/vehicle_detail_card.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class VehicleDetailData extends StatelessWidget {
  const VehicleDetailData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      controller.GetProfileData();
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(title: "VEHICLE DETAIL", trailingwidget: [
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            backgroundColor: AppColor.primary,
            onPressed: () async {
              Get.toNamed(AppRoute.vihcledetail);
            },
            child: Icon(
              Icons.add,
              size: 30.h,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Obx(
              () => stackcontainer(
                writedata: controller.profiledetailLoading == true
                    ? const Center(child: Loader())
                    : SingleChildScrollView(
                        child: controller
                                .profileDatas.value.vechicleDetails!.isEmpty
                            ? Center(
                                child: Text(
                                  "No Vehicle Data Found.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: AppColor.primary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              )
                            : Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.profileDatas.value
                                        .vechicleDetails!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          VehicleDetailCard(
                                            Vehicletype: controller
                                                .getVehicleName(controller
                                                        .profileDatas
                                                        .value
                                                        .vechicleDetails![index]
                                                        .vechicleType ??
                                                    ""),
                                            VehicleModel: controller
                                                    .profileDatas
                                                    .value
                                                    .vechicleDetails![index]
                                                    .modelName ??
                                                "".toUpperCase(),
                                            Vehiclenumber: controller
                                                    .profileDatas
                                                    .value
                                                    .vechicleDetails![index]
                                                    .vechicleNumber ??
                                                "",
                                            ontap: () {
                                              print("hello world");
                                              controller.VehicleDeteleapicall(
                                                  controller
                                                          .profileDatas
                                                          .value
                                                          .vechicleDetails![
                                                              index]
                                                          .sId ??
                                                      "");
                                            },
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                      ),
              ),
            )),
      );
    });
  }
}

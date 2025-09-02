// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/switch_button.dart';

// ignore: must_be_immutable
class profileTab extends StatelessWidget {
  profileTab({
    super.key,
  });
  ProfileController Controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    Controller.GetProfileData();
    return Obx(
      () => Controller.profiledetailLoading.value == true
          ? const Loader()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: Controller.detailsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Controller.detailsList[index].url ==
                                      "/proofileindisciplinary"
                                  ? {
                                      Controller.profileDatas.value
                                              .indisciplinaryActions!.isEmpty
                                          ? Utils.showToast(
                                              message:
                                                  "There No Indisciplinary Actions Against You.",
                                              gravity: ToastGravity.CENTER,
                                              toastlength: Toast.LENGTH_SHORT,
                                              textColor: Colors.white,
                                              fontsize: 16,
                                            )
                                          : Get.toNamed(
                                              Controller.detailsList[index].url,
                                            )
                                    }
                                  : index == 4
                                      ? Controller.profileDatas.value
                                                  .isVechicleDetailsAdded ==
                                              true
                                          ? Get.toNamed(
                                              AppRoute.addedvehicledata,
                                            )
                                          : Get.toNamed(
                                              Controller.detailsList[index].url,
                                            )
                                      : Get.toNamed(
                                          Controller.detailsList[index].url,
                                        );
                            },
                            child: Container(
                              height: 66.h,
                              width: 328.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.primary.withOpacity(1.0),
                                    AppColor.primary.withOpacity(0.1),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.6, left: 0.5, right: 0.5),
                                child: Container(
                                  height: 65.h,
                                  width: 326.w,
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(20.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColor.primary.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(-1,
                                            -2), // changes position of shadow
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          Controller.detailsList[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.copyWith(
                                                  color: AppColor.textblack,
                                                  fontSize: 16),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: AppColor.primary,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          //  Controller.detailsList.length.
                        ],
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Keep My Profile Private:",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: AppColor.textblack,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                      ),
                      const SwitchExample()
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

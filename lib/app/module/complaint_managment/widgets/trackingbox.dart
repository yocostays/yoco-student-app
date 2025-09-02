// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/controller/controller.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/widgets/stepper_class.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class ComplaintTimeLineDialogBox extends StatefulWidget {
  final String Complaintid;
  const ComplaintTimeLineDialogBox({
    super.key,
    required this.Complaintid,
  });

  @override
  State<ComplaintTimeLineDialogBox> createState() =>
      _ComplaintTimeLineDialogBoxState();
}

class _ComplaintTimeLineDialogBoxState extends State<ComplaintTimeLineDialogBox>
    with SingleTickerProviderStateMixin {
  final CompliantController controller = CompliantController();
  var currentStep = 0;
  var totalSteps = 3;
  late List<StepperData> stepsData;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  // @override
  // void initState() async {
  //   super.initState();
  //   await controller.GetComplaintedStatusData(widget.Complaintid);
  //   print("hello length : ${controller.ComplaintStatusdata.length}");
  //   stepsData = [
  //     StepperData(
  //       label: 'Pending',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
  //     ),
  //     StepperData(
  //       label: 'In Progress',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
  //     ),
  //     StepperData(
  //       label: 'Escalated',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
  //     ),
  //     StepperData(
  //       label: 'Completed',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
  //     ),
  //   ];
  //   totalSteps = stepsData.length;

  //   _controller = AnimationController(
  //     duration: const Duration(milliseconds: 500),
  //     vsync: this,
  //   );

  //   _fadeAnimation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.easeIn,
  //   );

  //   _controller.forward();
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.GetComplaintedStatusData(widget.Complaintid);
      currentStep = controller.ComplaintStatusdata.isEmpty
          ? 0
          : controller.ComplaintStatusdata.length - 1;

      setState(() {
        stepsData = [
          StepperData(
            label: 'Pending',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
          ),
          StepperData(
            label: 'In Progress',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
          ),
          StepperData(
            label: 'Escalated',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
          ),
          StepperData(
            label: 'Completed',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
          ),
        ];
        totalSteps = stepsData.length;
      });

      _controller.forward();
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 140),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tracking",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 20,
                        color: AppColor.textprimary,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Obx(() => controller.ComplaintStatusload.value == true
                    ? const Loader()
                    : Flexible(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.ComplaintStatusdata.length,
                          itemBuilder: (BuildContext context, int index) {
                            DateTime? dateTime;
                            String? formattedDate;
                            controller.ComplaintStatusdata.length > (index)
                                ? {
                                    dateTime = DateTime.parse(
                                        "${controller.ComplaintStatusdata[index].date}"),
                                    formattedDate =
                                        DateFormat("'On -' dd MMM, yy  hh:mm a")
                                            .format(dateTime),
                                  }
                                : formattedDate = "";

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20.r,
                                      backgroundColor: index + 1 <=
                                                  currentStep ||
                                              controller
                                                      .ComplaintStatusdata[
                                                          index]
                                                      .complainStatus ==
                                                  "resolved"
                                          ? AppColor.primary
                                          : controller.ComplaintStatusdata
                                                      .length ==
                                                  4
                                              ? AppColor.primary
                                              : index == currentStep
                                                  ? AppColor.primary
                                                      .withOpacity(0.5)
                                                  : Colors.black
                                                      .withOpacity(0.2),
                                      child: Text(
                                        "${index + 1}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .ComplaintStatusdata[index]
                                              .complainStatus!
                                              .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge
                                              ?.copyWith(
                                                  fontWeight:
                                                      FontWeight.w700),
                                        ),
                                        controller.ComplaintStatusdata
                                                    .length >
                                                (index)
                                            ? Text(
                                                controller.ComplaintStatusdata
                                                            .length >
                                                        (index)
                                                    ? controller
                                                                .ComplaintStatusdata[
                                                                    index]
                                                                .assignedStaffName !=
                                                            null
                                                        ? "${controller.ComplaintStatusdata[index].assignedStaffName}, Maintenance"
                                                        : ""
                                                    : "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12),
                                                maxLines: 2,
                                              )
                                            : const SizedBox(
                                                height: 0,
                                              ),
                                        formattedDate == ""
                                            ? Container()
                                            : Text(
                                                formattedDate,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12),
                                                // maxLines: 2,
                                              ),
                                        controller.ComplaintStatusdata
                                                    .length >
                                                (index)
                                            ? Text(
                                                controller.ComplaintStatusdata
                                                            .length >
                                                        (index)
                                                    ? controller
                                                            .ComplaintStatusdata[
                                                                index]
                                                            .remark ??
                                                        ""
                                                    : "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12),
                                                maxLines: 2,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ],
                                ),
                                index == (stepsData.length - 1)
                                    ? Container()
                                    : controller.ComplaintStatusdata[index]
                                                .complainStatus ==
                                            "resolved"
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 22),
                                            child: DottedDivider(
                                              Dottedcolor:
                                                  index + 1 <= currentStep
                                                      ? AppColor.primary
                                                      : Colors.black
                                                          .withOpacity(0.2),
                                            ),
                                          ),
                              ],
                            );
                          },
                        ),
                      ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DottedDivider extends StatelessWidget {
  final Color? Dottedcolor;
  const DottedDivider({
    super.key,
    required this.Dottedcolor,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, // Adjust height as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            6,
            (index) => Container(
                  width: 2,
                  height: 5,
                  color: Dottedcolor, // Adjust color as needed
                )),
      ),
    );
  }
}

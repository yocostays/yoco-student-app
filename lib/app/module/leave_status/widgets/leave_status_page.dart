// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/widgets/stepper_class.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class LeaveStatusDilogBox extends StatefulWidget {
  final String leaveId;
  const LeaveStatusDilogBox({
    super.key,
    required this.leaveId,
  });

  @override
  State<LeaveStatusDilogBox> createState() => _LeaveStatusDilogBoxState();
}

class _LeaveStatusDilogBoxState extends State<LeaveStatusDilogBox>
    with SingleTickerProviderStateMixin {
  final LeaveController _leavecontroller = Get.put(LeaveController());
  var currentStep = 0;
  var totalSteps = 0;
  late List<StepperData> stepsData;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _leavecontroller.GetLeaveStatusData(widget.leaveId);
    print(
        "leave Status data : ${_leavecontroller.SingleLeaveStatusData.length}");
    stepsData = [
      StepperData(
        label: 'Parent',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
      ),
      StepperData(
        label: 'HOD',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
      ),
      StepperData(
        label: 'Warden',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
      ),
    ];
    totalSteps = stepsData.length;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) {
      return "";
    }
    try {
      return "Date: ${DateFormat("'On -' dd MMM, yy  hh:mm a").format(DateTime.parse(date))}";
    } catch (e) {
      // Handle invalid date format gracefully
      return "";
    }
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 190),
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
                Obx(() => Flexible(
                      child: _leavecontroller.leaveStatusdataloading.value ==
                              true
                          ? const Loader()
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: stepsData.length,
                              itemBuilder: (BuildContext context, int index) {
                                _leavecontroller.SingleLeaveStatusData[index]
                                            .leaveStatus ==
                                        "pending"
                                    ? 0
                                    : setState(() {
                                        currentStep += 1;
                                      });

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20.r,
                                          backgroundColor:
                                              index + 1 <= currentStep ||
                                                      currentStep == 4
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
                                              stepsData[index].label,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            Text(
                                              "Remark: ${_leavecontroller.SingleLeaveStatusData[index].remark ?? ""}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400),
                                              maxLines: 2,
                                            ),
                                            Text(
                                              formatDate(_leavecontroller
                                                  .SingleLeaveStatusData[
                                                      index]
                                                  .date),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    index == (stepsData.length - 1)
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
      height: 50, // Adjust height as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            7,
            (index) => Container(
                  width: 2,
                  height: 5,
                  color: Dottedcolor, // Adjust color as needed
                )),
      ),
    );
  }
}

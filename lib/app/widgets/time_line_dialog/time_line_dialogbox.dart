import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/widgets/stepper_class.dart';

class TimelineController extends GetxController {
  var currentStep = 1.obs;
  late List<StepperData> stepsData;

  @override
  void onInit() {
    super.onInit();
    stepsData = [
      StepperData(label: 'Order Placed', description: 'Your order is placed.'),
      StepperData(label: 'Order Confirmed', description: 'Order confirmed.'),
      StepperData(label: 'Order Processed', description: 'Processing started.'),
      StepperData(label: 'Ready to Pickup', description: 'Pickup available.'),
    ];
  }

  void updateStep(int step) {
    if (step <= stepsData.length) {
      currentStep.value = step;
    }
  }
}


class TimeLineDialogBox extends StatelessWidget {
  const TimeLineDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimelineController());

    return Center(
      child: Container(
        width: Get.width * 0.9,
        height: Get.height * 0.6,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tracking",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close,
                      size: 20, color: AppColor.textprimary),
                )
              ],
            ),
            const Divider(),
            SizedBox(height: 10.h),

            // Steps List
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.stepsData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final step = controller.stepsData[index];
                    final isCompleted = index + 1 <= controller.currentStep.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: isCompleted
                                  ? AppColor.primary
                                  : Colors.grey.withOpacity(0.3),
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step.label,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: isCompleted
                                              ? AppColor.primary
                                              : AppColor.textblack),
                                ),
                                Text(
                                  step.description??"No description available",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600]),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Connector line
                        if (index < controller.stepsData.length - 1)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22),
                            child: DottedDivider(
                              dottedColor: isCompleted
                                  ? AppColor.primary
                                  : Colors.black.withOpacity(0.2),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedDivider extends StatelessWidget {
  final Color dottedColor;
  const DottedDivider({super.key, required this.dottedColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          7,
          (index) => Container(
            width: 2,
            height: 5,
            color: dottedColor,
          ),
        ),
      ),
    );
  }
}

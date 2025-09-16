import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

/// Controller to manage switch state
class SwitchController extends GetxController {
  var isOn = true.obs;

  void toggle(bool value) => isOn.value = value;
}

/// Reusable Switch Widget
class SwitchExample extends StatelessWidget {
  const SwitchExample({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SwitchController());

    return Center(
      child: Obx(
        () => Switch.adaptive(
          value: controller.isOn.value,
          activeColor: AppColor.primary,       // thumb color
          activeTrackColor: AppColor.white,    // track when ON
          inactiveThumbColor: AppColor.primary,
          inactiveTrackColor: AppColor.white,
          onChanged: controller.toggle,
        ),
      ),
    );
  }
}

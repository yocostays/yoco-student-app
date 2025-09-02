import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/colors.dart';
import 'DialogPage.dart';

class CenterButton extends StatelessWidget {
  final bool? home;
  const CenterButton({
    super.key,
    this.home,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: InkWell(
        onTap: () {
          _showBlurredDialog();
        },
        child: Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: home == true
                    ? const Color(0xffFDFAFF)
                    : AppColor.primary.withOpacity(0.2),
                shape: BoxShape.circle),
            child: Container(
              // height: 70,
              // width: 70,
              decoration: const BoxDecoration(
                  color: AppColor.primary, shape: BoxShape.circle),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 30,
              ),
            )),
      ),
    );
  }

  void _showBlurredDialog() {
    Get.dialog(
      const DialogPage(),
    );
  }
}

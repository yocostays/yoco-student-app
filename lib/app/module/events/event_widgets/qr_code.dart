import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_bar_code/code/src/code_generate.dart';
import 'package:qr_bar_code/code/src/code_type.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class EventQrcode extends StatelessWidget {
  const EventQrcode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: 193.w,
      padding: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(20.r)),
      child: Code(data: "https://www.yandex.com", codeType: CodeType.qrCode()),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/my_payment/widgets/deselected_widgets.dart';
import 'package:yoco_stay_student/app/module/my_payment/widgets/selected_widgets.dart';

class FineDuesTicketCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? date;
  final String? reason;
  final String? time;
  final int? Price;
  final Widget? timeSection;
  final double? dateFontSize;
  final double? timeFontSize;
  final Function()? ontap;
  final Function()? ontapcircule;
  final bool? selected;

  const FineDuesTicketCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.date,
    this.reason,
    this.time,
    this.Price,
    this.timeSection,
    this.dateFontSize,
    this.timeFontSize,
    this.ontap,
    this.ontapcircule,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapcircule,
      onDoubleTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.midpurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20.r),
        ),
        height: MediaQuery.of(context).size.height * 0.14,
        width: double.infinity,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Center(
                    child: Image.asset(
                      iconPath,
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.h),
                              child: Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                        color: AppColor.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            time == null ? SizedBox(height: 5.h) : Container(),
                            time == null
                                ? Padding(
                                    padding: EdgeInsets.only(left: 16.h),
                                    child: Text(
                                      reason ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              color: AppColor.primary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                const Icon(
                                  FeatherIcons.calendar,
                                  color: AppColor.primary,
                                  size: 20,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  date ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: AppColor.primary,
                                          fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            time == null ? Container() : SizedBox(height: 5.h),
                            time == null
                                ? Container()
                                : Row(
                                    children: [
                                      const Icon(
                                        FeatherIcons.clock,
                                        color: AppColor.primary,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        time ?? "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: AppColor.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                            SizedBox(height: 5.h),
                            timeSection == null
                                ? Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/wallet_icon.png",
                                        scale: 3.5,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        "₹${Price ?? 0}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: AppColor.primary,
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )
                                : timeSection ?? Container(),
                          ],
                        ),
                        selected == true
                            ? const Selectedwidgets()
                            : const NotSelected()
                      ],
                    ),
                  ),
                ),
              ],
            ),
            CustomPaint(
              painter: SideCutsDesign(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                width: double.infinity,
              ),
            ),
            CustomPaint(
              painter: DottedMiddlePath(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedMiddlePath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 2;
    double dashSpace = 7;
    double startY = 10;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    while (startY < size.height - 10) {
      canvas.drawCircle(Offset(size.width / 3.5, startY), 1.5, paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SideCutsDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(w / 3.5, h), radius: 7),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w / 3.5, 0), radius: 7),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

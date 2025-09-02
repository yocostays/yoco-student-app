import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class TicketCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? date;
  final String? ticketId;
  final String? time;
  final Widget? timeSection;
  final double? dateFontSize;
  final double? timeFontSize;

  const TicketCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.date,
    this.time,
    this.timeSection,
    this.dateFontSize,
    this.timeFontSize,
    this.ticketId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        iconPath,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Text(
                      ticketId ?? "",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColor.primary),
                      // maxLines: 2,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0.h),
                        child: Text(
                          title.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textprimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
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
                            style: TextStyle(
                              fontSize: dateFontSize ?? 13,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textprimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      timeSection == null
                          ? Row(
                              children: [
                                const Icon(
                                  FeatherIcons.clock,
                                  color: AppColor.primary,
                                  size: 20,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  time ?? "",
                                  style: TextStyle(
                                    fontSize: timeFontSize ?? 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textprimary,
                                  ),
                                ),
                              ],
                            )
                          : timeSection ?? Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CustomPaint(
            painter: SideCutsDesign(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
            ),
          ),
          CustomPaint(
            painter: DottedMiddlePath(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
            ),
          ),
        ],
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

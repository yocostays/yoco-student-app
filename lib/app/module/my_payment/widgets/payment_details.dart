import 'package:flutter/material.dart';
import 'package:yoco_stay_student/app/core/env.dart';
import 'package:yoco_stay_student/app/core/theme/quicksand_text_primary.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_utils.dart';

// ignore: must_be_immutable
class PayMentController extends StatelessWidget {
  // EventController eventcontroller = Get.put(EventController());

  const PayMentController({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screenwidth * 0.195,
                      child: const Column(
                        children: [
                          QSPrimary10(
                            Title: 'Booking No.',
                          ),
                          QSPrimary21W700(
                            Title: '200',
                          ),
                        ],
                      ),
                    ),
                    const DottedVerticalDivider(),
                    SizedBox(
                      width: screenwidth * 0.1,
                    ),
                    const QSPrimary16(
                      Title: "Payment Details",
                    ),
                  ],
                ),
              ),
              const DottedHorizontalDivider(),
            ],
          ),
        ),
        CustomPaint(
          painter: TopSideCutsDesign(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.12,
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}

class DottedMiddlePath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9;
    double dashSpace = 7;
    double startX = 10;
    final paint = Paint()
      ..color = AppColor.white
      ..strokeWidth = 1;

    while (startX < size.width - 10) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TopSideCutsDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    // canvas.drawArc(
    //   Rect.fromCircle(center: Offset(w / 3.5, h), radius: 7),
    //   0,
    //   10,
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.fill
    //     ..color = Colors.white,
    // );
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

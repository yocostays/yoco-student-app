// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:yoco_stay_student/app/core/env.dart';
import 'package:yoco_stay_student/app/core/theme/quicksand_text_primary.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_utils.dart';

// ignore: must_be_immutable
class GetpassExtensionClass extends StatelessWidget {
  String Getpassnumber;
  GetpassExtensionClass({
    super.key,
    required this.Getpassnumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
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
                          Column(
                            children: [
                              // QSPrimary10(
                              //   Title: 'Gate Pass No.',
                              // ),
                              Text(
                                'Gate Pass No.',
                                // 'Rugby',
                                style: GoogleFonts.getFont(
                                  'DM Sans',
                                  textStyle: GoogleFonts.quicksand(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textprimary,
                                  ),
                                ),

                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              QSPrimary21W700(
                                Title: Getpassnumber,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenwidth * 0.035,
                          ),
                          const DottedVerticalDivider(),
                          SizedBox(
                            width: screenwidth * 0.08,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Reason For Visiting",
                                // 'Rugby',
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  textStyle: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textprimary,
                                  ),
                                ),

                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Meeting Harsh Jogi",
                                // 'Rugby',
                                style: GoogleFonts.getFont(
                                  'Quicksand',
                                  textStyle: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textprimary,
                                  ),
                                ),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   width: screenwidth * 0.14,
                          // ),
                        ],
                      ),
                    ),
                    const DottedHorizontalDivider(),
                  ],
                ),
              ),
              CustomPaint(
                painter: BookingStatusSideCutsDesign(),
                child: const SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
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

class BookingStatusSideCutsDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // var h = size.height;
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

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class MessTicketCard extends StatefulWidget {
  final String iconPath;
  final String title;
  final String? date;
  final String? time;
  final Widget? timeSection;
  final double? dateFontSize;
  final double? timeFontSize;

  const MessTicketCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.date,
    this.time,
    this.timeSection,
    this.dateFontSize,
    this.timeFontSize,
  });

  @override
  State<MessTicketCard> createState() => _MessTicketCardState();
}

class _MessTicketCardState extends State<MessTicketCard> {
  // final List<String> items = [
  //   'Item1',
  //   'Item2',
  //   'Item3',
  //   'Item4',
  //   'Item5',
  //   'Item6',
  //   'Item7',
  //   'Item8',
  // ];

  String? selectedValue = 'Item2';

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
                child: Center(
                  child: Image.asset(
                    widget.iconPath,
                    scale: 3,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColor.textprimary,
                              ),
                            ),
                          ),
                        ],
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
                            widget.date ?? "",
                            style: TextStyle(
                              fontSize: widget.dateFontSize ?? 13.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor.textprimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      widget.timeSection == null
                          ? Row(
                              children: [
                                const Icon(
                                  FeatherIcons.clock,
                                  color: AppColor.primary,
                                  size: 20,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  widget.time ?? "",
                                  style: TextStyle(
                                    fontSize: widget.timeFontSize ?? 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textprimary,
                                  ),
                                ),
                              ],
                            )
                          : widget.timeSection ?? Container(),
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
          // Positioned(
          //   right: 15,
          //   top: 10,
          //   child: DropdownButtonHideUnderline(
          //     child: DropdownButton2<String>(
          //       isExpanded: true,
          //       hint: const Row(
          //         children: [
          //           Expanded(
          //             child: Text(
          //               'Book',
          //               style: TextStyle(
          //                 fontSize: 14,
          //                 fontWeight: FontWeight.bold,
          //                 color: AppColor.white,
          //               ),
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           ),
          //         ],
          //       ),
          //       items: items
          //           .map((String item) => DropdownMenuItem<String>(
          //                 value: item,
          //                 child: Text(
          //                   item,
          //                   style: const TextStyle(
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.bold,
          //                     color: Colors.white,
          //                   ),
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ))
          //           .toList(),
          //       value: selectedValue,
          //       onChanged: (String? value) {
          //         print("jnkfdsfjnkdsjf");
          //         setState(() {
          //           selectedValue = value;
          //         });
          //       },
          //       buttonStyleData: ButtonStyleData(
          //         height: 30,
          //         width: 100,
          //         padding: const EdgeInsets.only(left: 14, right: 14),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(14),
          //           border: Border.all(
          //             color: Colors.black26,
          //           ),
          //           color: AppColor.primary,
          //         ),
          //         elevation: 2,
          //       ),
          //       iconStyleData: const IconStyleData(
          //         icon: Icon(
          //           CupertinoIcons.chevron_down,
          //         ),
          //         iconSize: 14,
          //         iconEnabledColor: Colors.yellow,
          //         iconDisabledColor: Colors.grey,
          //       ),
          //       dropdownStyleData: DropdownStyleData(
          //         maxHeight: 200,
          //         width: 100,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(14),
          //           color: AppColor.primary,
          //         ),
          //         offset: const Offset(-20, 0),
          //         scrollbarTheme: ScrollbarThemeData(
          //           radius: const Radius.circular(40),
          //           thickness: MaterialStateProperty.all<double>(6),
          //           thumbVisibility: MaterialStateProperty.all<bool>(true),
          //         ),
          //       ),
          //       menuItemStyleData: const MenuItemStyleData(
          //         height: 30,
          //         padding: EdgeInsets.only(left: 14, right: 14),
          //       ),
          //     ),
          //   ),
          // ),
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

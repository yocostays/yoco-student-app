// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';

class stackcontainer extends StatelessWidget {
  final Widget writedata;
  final bool? NoBackgroundcolor;
  final bool? Shadow;
  final double? customheight;
  const stackcontainer({
    super.key,
    required this.writedata,
    this.NoBackgroundcolor,
    this.Shadow,
    this.customheight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50.h,
          decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              )),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: 25,
          left: 11,
          right: 10,
          child: Container(
            width: 339.w,
            height: customheight ?? 570.h,
            decoration: NoBackgroundcolor == true
                ? const BoxDecoration()
                : Shadow == true
                    ? BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15.0),
                        // border: Border.all(
                        //   color: Colors.blue,
                        //   width: 2,
                        // ),
                        boxShadow: [
                          // Shadow on the right side
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.1), // Set the shadow color
                            offset: const Offset(
                                2, 1), // Horizontal shift (right side)
                            blurRadius: 0.05,
                            spreadRadius: 0,
                          ),
                          // Shadow on the bottom
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.1), // Set the shadow color
                            offset: const Offset(
                                0, 2), // Vertical shift (bottom side)
                            blurRadius: 1,
                            spreadRadius: 1,
                          ),
                        ],
                      )
                    : BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(15.0),
                        // border: Border.all(
                        //   color: Colors.blue,
                        //   width: 2,
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primary.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                -1, -2), // changes position of shadow
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
            child: writedata,
          ),
        )
      ],
    );
  }
}

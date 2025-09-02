import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_utils.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/extension_tile.dart';

class AmitiesticketsDetal extends StatelessWidget {
  const AmitiesticketsDetal({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipPath(
            clipper: MyCustomclipper(),
            child: Container(
              // height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  )),
              child: Column(
                children: [
                  ExtensionClass(),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

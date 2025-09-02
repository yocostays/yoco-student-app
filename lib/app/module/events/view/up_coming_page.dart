// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_card.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';

class UpComingPage extends StatelessWidget {
  const UpComingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.contains(MaterialState.selected)) {
        return AppColor.white; // Use blue color when the checkbox is selected
      } else if (states.any(interactiveStates.contains)) {
        return Colors
            .transparent; // Use white color for other interactive states
      }
      return Colors.transparent;
      // if (states.any(interactiveStates.contains)) {
      //   return Colors.white;
      // }
      // return Colors.blue;
    }

    return SingleChildScrollView(
      child: Container(
        height: 510.h,
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                EventTimeNameCard(
                  paymentsectoion: () {
                    Get.toNamed(AppRoute.eventpage2nd);
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

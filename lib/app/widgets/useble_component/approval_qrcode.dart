import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_utils.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/qr_code.dart';
import 'package:yoco_stay_student/app/module/get_pass/widegts/extension.dart';

class PassQrCode extends StatelessWidget {
  final bool? loading;
  final String? gatepassnumber;
  const PassQrCode({
    super.key,
    this.loading,
    this.gatepassnumber,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.contains(WidgetState.selected)) {
        return AppColor.primary; // Use blue color when the checkbox is selected
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

    return ClipPath(
      clipper: MyCustomclipper(),
      child: loading == true
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                size: 50,
                color: AppColor.primary,
              ),
            )
          : Container(
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
                  GetpassExtensionClass(
                    Getpassnumber: gatepassnumber ?? "",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const EventQrcode(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          focusColor: Colors.yellow,
                          checkColor: Colors.white,
                          fillColor: WidgetStateProperty.resolveWith(getColor),
                          value: true,
                          onChanged: (bool? value) {
                            print("$value");
                            // controller.totalassesment();
                          },
                        ),
                      ),
                      Text(
                        'Booked',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColor.textprimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
    );
  }
}

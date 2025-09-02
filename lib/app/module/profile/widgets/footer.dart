import 'package:flutter/material.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/widgets/switch_button.dart';

class profileFooter extends StatelessWidget {
  const profileFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Keep My Profile Private:",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppColor.textblack,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        const SwitchExample()
      ],
    );
  }
}

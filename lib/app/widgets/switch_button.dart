import 'package:flutter/material.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch.adaptive(
          activeColor: AppColor.white,
          activeTrackColor: AppColor.primary,
          inactiveThumbColor: AppColor.primary,
          inactiveTrackColor: AppColor.white,
          value: light,
          onChanged: (bool value) {
            setState(() {
              light = value;
            });
          },
        ),
        // Switch.adaptive(
        //   // Don't use the ambient CupertinoThemeData to style this switch.
        //   applyCupertinoTheme: false,
        //   value: light,
        //   onChanged: (bool value) {
        //     setState(() {
        //       light = value;
        //     });
        //   },
        // ),
      ],
    );
  }
}

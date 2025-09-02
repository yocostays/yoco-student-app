import 'package:flutter/material.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppColor.white),
    textTheme: AppTextTheme.textTheme,
  );
  static final darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(backgroundColor: AppColor.white),
    textTheme: AppTextTheme.textTheme,
  );
}

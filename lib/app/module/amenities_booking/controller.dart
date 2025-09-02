import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmenitiesController extends GetxController {
  RxInt Selectedaminieties = 0.obs;
  RxInt nubmerofstudent = 0.obs;

  RxBool minusbutton = false.obs;
  RxBool plusbutton = false.obs;

  final TextEditingController TimeSlot = TextEditingController();
  final TextEditingController firstTimeSlot = TextEditingController();
  final TextEditingController secondTimeSlot = TextEditingController();

  String formatTimeRange(
      BuildContext context, TimeOfDay? startTime, TimeOfDay? endTime) {
    if (startTime == null || endTime == null) return '';
    final localizations = MaterialLocalizations.of(context);

    final startFormatted =
        localizations.formatTimeOfDay(startTime, alwaysUse24HourFormat: false);
    final endFormatted =
        localizations.formatTimeOfDay(endTime, alwaysUse24HourFormat: false);

    return '$startFormatted - $endFormatted';
  }
}

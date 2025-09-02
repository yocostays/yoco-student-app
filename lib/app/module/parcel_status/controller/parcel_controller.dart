import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ParcelController extends GetxController {
  RxInt parcelid = 0.obs;
  TextEditingController parceltypename = TextEditingController();
  TextEditingController Dateandtime = TextEditingController();
  TextEditingController fromdate = TextEditingController();
  TextEditingController moneypaid = TextEditingController();
  TextEditingController todate = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(
    BuildContext context,
  ) async {
    selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  Future<void> selectTime(
      BuildContext context, TextEditingController dateintext) async {
    int hour = 0;
    int minutes = 0;
    String appm = "";
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      String date = DateFormat('dd-MM-yyyy').format(selectedDate);
      // String time = DateFormat('hh:mm a').format(selectedTime);
      if (selectedTime.hour >= 12) {
        hour = selectedTime.hour - 12;
        minutes = selectedTime.minute;
        appm = "PM";
      } else {
        hour = selectedTime.hour;
        minutes = selectedTime.minute;
        appm = "AM";
      }
      dateintext.text =
          "$date $hour:${minutes <= 9 ? "0$minutes" : minutes}$appm";
    } else {
      selectedTime = TimeOfDay.now();
      String date = DateFormat('dd-MM-yyyy').format(selectedDate);
      // String time = DateFormat('hh:mm a').format(selectedTime);
      if (selectedTime.hour >= 12) {
        hour = selectedTime.hour - 12;
        minutes = selectedTime.minute;
        appm = "PM";
      } else {
        hour = selectedTime.hour;
        minutes = selectedTime.minute;
        appm = "AM";
      }
      dateintext.text =
          "$date $hour:${minutes <= 9 ? "0$minutes" : minutes}$appm";
    }
  }
}

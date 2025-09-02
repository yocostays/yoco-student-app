import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class Utils {
  // format Date Year
  static String formatDateYear(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  static String formatSelectedDateYear(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  static String formatDateString(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
      return formattedDate;
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid date";
    }
  }

  // format Only Year
  static String formatOnlyYear(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  static String formatDateYearString(String dateString,
      [String format = 'dd/MM/yyyy']) {
    try {
      DateTime parsedDate = DateFormat(format).parse(dateString);
      String formattedDate = DateFormat(format).format(parsedDate);
      return formattedDate;
    } catch (e) {
      // Handle errors or invalid date formats
      print("Error parsing date: $e");
      return "Invalid date";
    }
  }

  // format Date and Time
  static String formatDateTime(DateTime date) {
    return DateFormat('dd-MM-yyyy hh:mm a').format(date);
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) return "";
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  static void showLoading() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(
          color: AppColor.black,
        ),
      ),
      barrierDismissible: false,
    );
  }

  // capitalization like: Comaputer Scrience
  static String toCapitalization(String input) {
    List<String> words = input.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).toList();

    return capitalizedWords.join(' ');
  }

  // certification formate
  static String formatDatesAndCalculateDuration(
      String startDate, String endDate) {
    DateTime startDateTime = DateTime.parse(startDate);
    DateTime endDateTime = DateTime.parse(endDate);

    String formattedStartDate = DateFormat('d MMM yyyy').format(startDateTime);
    String formattedEndDate = DateFormat('d MMM yyyy').format(endDateTime);

    int monthDifference = (endDateTime.year - startDateTime.year) * 12 +
        endDateTime.month -
        startDateTime.month;

    return '$formattedStartDate - $formattedEndDate ($monthDifference Months)';
  }

  // Certificate isOngoings
  static String formatStartDateAndHandleOngoing(String startDate,
      [String? endDate]) {
    DateTime startDateTime = DateTime.parse(startDate);

    String formattedStartDate = DateFormat('d MMM yyyy').format(startDateTime);

    String formattedEndDate = endDate != null
        ? DateFormat('d MMM yyyy').format(DateTime.parse(endDate))
        : "Present";

    return '$formattedStartDate - $formattedEndDate';
  }

  // hide loading
  static void hideLoading() {
    Get.back();
  }

  // extract File Name
  static String extractFileName(String fullPath) {
    return fullPath.split('/').last;
  }

  // branch abbreviation
  static String getBranchAbbreviation(String branchName) {
    // Define a map of common branch names to their abbreviations
    Map<String, String> branchAbbreviations = {
      'mechanical': 'MECH',
      'electrical': 'EEE',
      'civil': 'CIVIL',
      'computer science': 'CSE',
      'chemical': 'CHE',
      'software': 'SE',
      'electronics': 'ET&T',
      'telecommunication': 'TELECOM',
      'artificial intelligence': 'AI',
      'machine learning': 'ML',
    };

    // Convert the branch name to lowercase for case-insensitive matching
    String normalizedBranch = branchName.toLowerCase();

    // Return the abbreviation if found, otherwise return the original branch name in uppercase
    return branchAbbreviations[normalizedBranch] ?? branchName.toUpperCase();
  }

  static void showToast(
      {required String message,
      ToastGravity? gravity,
      Color? backgroundcolor,
      Color? textColor,
      double? fontsize,
      int? timeduration,
      Toast? toastlength}) {
    Fluttertoast.showToast(
      backgroundColor: backgroundcolor ?? AppColor.primary,
      textColor: textColor ?? AppColor.textblack,
      msg: message,
      toastLength: toastlength ?? Toast.LENGTH_SHORT,
      fontSize: fontsize ?? 10,
      webPosition: "center",
      timeInSecForIosWeb: timeduration ?? 5,
      gravity: gravity ?? ToastGravity.TOP,
      webBgColor: "linear-gradient(to right, #0E7CF4, #04419E)",
    );
  }

  static Future<dynamic> deleteAccountConfirmation(
      BuildContext context, Function()? onTap) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        child: Container(
          width: 300.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
                child: Column(
                  children: [
                    Text(
                      "Are you sure you want to delete this chat?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: Row(children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.black, width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        height: 48.h,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColor.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "Delete",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // "9th March, 2024" output
  static String formatDatebynd(DateTime date) {
    final DateFormat dayFormat = DateFormat('d');
    final DateFormat monthFormat = DateFormat('MMM');
    final DateFormat yearFormat = DateFormat('y');

    String day = dayFormat.format(date);
    String month = monthFormat.format(date);
    String year = yearFormat.format(date);

    String suffix = 'th';
    if (day.endsWith('1') && !day.endsWith('11')) {
      suffix = 'st';
    } else if (day.endsWith('2') && !day.endsWith('12')) {
      suffix = 'nd';
    } else if (day.endsWith('3') && !day.endsWith('13')) {
      suffix = 'rd';
    }

    return '$day$suffix $month, $year';
  }

  String formatDate(DateTime date) {
    final daySuffix = _getDaySuffix(date.day);
    final formattedDate = DateFormat("d'$daySuffix' MMMM, y").format(date);
    return formattedDate;
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  Future selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        helpText: "Booking Date",
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      controller.text = formatDatebynd(selectedDate);
    }
  }

  //"10:30 AM"
  static String formatTimePass(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  static bool isDateInList(DateTime date, List<DateTime?> selectedDates) {
    return selectedDates.any((d) => d != null && isSameDay(d, date));
  }

  static void removeDate(DateTime date, List<DateTime?> selectedDates) {
    selectedDates.removeWhere((d) => d != null && isSameDay(d, date));
  }

  static bool isSelectedDayisBefroTodayDate(DateTime selectedDay) {
    DateTime now = DateTime.now();
    if (selectedDay.year >= now.year &&
        selectedDay.month >= now.month &&
        selectedDay.day >= now.day) {
      return true;
    } else {
      return false;
    }
  }

  static bool isSelectedDayisSameAsTodayDate(DateTime selectedDay) {
    DateTime now = DateTime.now();
    if (selectedDay.year == now.year &&
        selectedDay.month == now.month &&
        selectedDay.day == now.day) {
      return true;
    } else {
      return false;
    }
  }

  static bool IsSameDates(DateTime firstDate, DateTime Seconddate) {
    if (firstDate.year == Seconddate.year &&
        firstDate.month == Seconddate.month &&
        firstDate.day == Seconddate.day) {
      return true;
    } else {
      return false;
    }
  }

  static bool isSelectedDayisBeforpassingdate(
      DateTime selectedDay, DateTime givendate) {
    if (selectedDay.year >= givendate.year &&
        selectedDay.month >= givendate.month &&
        selectedDay.day >= givendate.day) {
      return true;
    } else {
      return false;
    }
  }

  static void showAlertDialog(
      BuildContext context, String? title, String? subtitle) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.primary,
          elevation: 24,
          title: Text(
            title ?? 'Alert',
            style: const TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  subtitle ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

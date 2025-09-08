import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/mess_management/repository.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/globals.dart' as globals;

final today = DateUtils.dateOnly(DateTime.now());

class EditMealScreen extends StatefulWidget {
  const EditMealScreen({super.key});

  @override
  _EditMealScreenState createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  // final HomeController homeController = Get.put(HomeController());
  final MessController messController = Get.put(MessController());
  final _scrollController = ScrollController();

  DateTime? Timeheading = DateTime.now();

  // List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
  //   DateTime.now(), // DateTime.now().add(const Duration(days: 5)),
  // ];
  List<DateTime?> SelectedWithActionButtonsWithValue = [
    // DateTime.now().add(const Duration(days: 5)),
  ];

  //
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  // DateTime? _selected;
  // DateTime? _enddate;

  List<DateTime> holidays = [
    // DateTime.parse("2024-10-31 18:57:59.274895"),
    // DateTime.parse("2024-11-05 18:57:59.274895"),
    // DateTime.parse("2024-11-14 18:57:59.274895"),
  ];

  // Custom DateFormatter for month and year
  String _formatMonthYear(DateTime date) {
    return DateFormat.yMMM().format(date);
  }

  //
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 1000) {
        // ignore: avoid_print
        print('scrolling distance: ${_scrollController.offset}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          width: 325.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.grey4.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 0),
              ),
            ],
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
          ),
          child: Obx(
            () => Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: CustomButton(
                  ontap: () {
                    messController.EditMeal();
                  },
                  Title: 'Edit Ticket',
                  isloaging: messController.EditBookMealLoading.value,
                  BoxColor: messController.EditBookMealLoading.value
                      ? AppColor.white
                      : null,
                ),
              ),
            ),
          )),
      body: CutomAppBarContainer(
          title: messController.BookEditPage.value
              ? "EDIT BOOK MEALS"
              : "EDIT CANCEL MEALS",
          messmanagment: false,
          isScroll: false,
          contentWidgets: [
            _buildCalendarWithActionButtons(),
          ]),
    );
  }

  bool isDateWithinRange(DateTime date, DateTime startDate, DateTime endDate) {
    // Extract only the date part by setting the time to midnight
    DateTime dateOnly = DateTime(date.year, date.month, date.day);
    DateTime startDateOnly =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);

    return (dateOnly.isAtSameMomentAs(startDateOnly) ||
            dateOnly.isAfter(startDateOnly)) &&
        (dateOnly.isAtSameMomentAs(endDateOnly) ||
            dateOnly.isBefore(endDateOnly));
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? _formatDate(values[0]) : 'null');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values.map((v) => _formatDate(v)).join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = _formatDate(values[0]);
        final endDate = values.length > 1 ? _formatDate(values[1]) : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }
    return valueText;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final daySuffix = _getDaySuffix(date.day);
    final formattedDate = DateFormat("d'$daySuffix' MMM, yyyy").format(date);
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

  Widget _buildCalendarWithActionButtons() {
    //DateTime now = DateTime.now();

    // Calculate the start of the week (Monday)
    //DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    // Calculate the end of the week (Sunday)
    //DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 10),
                  child: Container(
                    width: 315.w,
                    // height: 300,
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.7),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(-1, -2),
                        ),
                        BoxShadow(
                          color: AppColor.primary.withOpacity(0.7),
                          spreadRadius: 4,
                          blurRadius: 1,
                          offset: const Offset(1, 0),
                        ),
                        BoxShadow(
                          color: AppColor.grey2.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(1, 2),
                        ),
                        BoxShadow(
                          color: AppColor.grey2.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(-1, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primary.withOpacity(0.7),
                            spreadRadius: 1,
                            blurRadius: 1,
                            // offset: Offset(-1, -2),
                          ),
                          // BoxShadow(
                          //   color: AppColor.primary.withOpacity(0.7),
                          //   spreadRadius: 1,
                          //   blurRadius: 1,
                          //   offset: Offset(1, 0),
                          // ),
                          // BoxShadow(
                          //   color: AppColor.grey2.withOpacity(0.2),
                          //   spreadRadius: 1,
                          //   blurRadius: 2,
                          //   offset: Offset(1, 2),
                          // ),
                          // BoxShadow(
                          //   color: AppColor.grey2.withOpacity(0.2),
                          //   spreadRadius: 1,
                          //   blurRadius: 2,
                          //   offset: Offset(-1, 2),
                          // ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // IconButton(
                              //   icon: Icon(Icons.arrow_back),
                              //   onPressed: _onPreviousMonth,
                              // ),
                              Text(
                                _formatMonthYear(_focusedDay),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.primary),
                              ),
                              // IconButton(
                              //   icon: Icon(Icons.arrow_forward),
                              //   onPressed: _onNextMonth,
                              // ),
                              IconButton(
                                icon: const Icon(
                                  FeatherIcons.edit,
                                  color: AppColor.secondary,
                                ),
                                onPressed: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: _focusedDay,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101),
                                  );
                                  if (picked != _focusedDay) {
                                    setState(() {
                                      _focusedDay = picked!;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          TableCalendar(
                            // simpleSwipeConfig: const SimpleSwipeConfig(verticalThreshold: 50.0),
                            rangeStartDay: messController.SelectedDate,
                            rangeEndDay: messController.EndDate,
                            calendarFormat:
                                CalendarFormat.month, // Fixed to "month" format
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month'
                            },
                            // shouldFillViewport: true,
                            availableGestures:
                                AvailableGestures.horizontalSwipe,
                            firstDay: DateTime.now(),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDay,
                            // calendarFormat: _calendarFormat,
                            selectedDayPredicate: (day) {
                              // Calculate the start and end of the current week
                              DateTime startOfWeek = DateTime.now().subtract(
                                  Duration(days: DateTime.now().weekday - 1));
                              DateTime endOfWeek =
                                  startOfWeek.add(const Duration(days: 8));

                              // Allow selection only if the day is within the current week
                              return day.isAfter(startOfWeek
                                      .subtract(const Duration(days: 1))) &&
                                  day.isBefore(
                                      endOfWeek.add(const Duration(days: 1))) &&
                                  isSameDay(messController.SelectedDate, day);
                            },

                            onDaySelected: (selectedDay, focusedDay) {
                              // setState(() {
                              //   if (isSameDay(
                              //       selectedDay, homeController.SelectedDate)) {
                              //     homeController.SelectedDate = null;
                              //   } else if (isSameDay(
                              //       selectedDay, homeController.EndDate)) {
                              //     homeController.EndDate = null;
                              //   } else if (homeController.SelectedDate ==
                              //       null) {
                              //     homeController.SelectedDate = selectedDay;
                              //   } else if (homeController.SelectedDate !=
                              //           null &&
                              //       homeController.EndDate == null) {
                              //     selectedDay.isBefore(
                              //             homeController.SelectedDate!)
                              //         ? {
                              //             homeController.EndDate =
                              //                 homeController.SelectedDate,
                              //             homeController.SelectedDate =
                              //                 selectedDay,
                              //           }
                              //         : homeController.EndDate = selectedDay;
                              //   } else if (homeController.SelectedDate !=
                              //           null &&
                              //       homeController.EndDate != null) {
                              //     selectedDay.isAfter(homeController.EndDate!)
                              //         ? homeController.EndDate = selectedDay
                              //         : selectedDay.isAfter(
                              //                 homeController.SelectedDate!)
                              //             ? homeController.EndDate = selectedDay
                              //             : homeController.SelectedDate =
                              //                 selectedDay;
                              //   } else if (homeController.SelectedDate ==
                              //           null &&
                              //       homeController.EndDate != null) {
                              //     selectedDay.isAfter(homeController.EndDate!)
                              //         ? {
                              //             homeController.SelectedDate =
                              //                 homeController.EndDate,
                              //             homeController.EndDate = selectedDay,
                              //           }
                              //         : 0;
                              //   }

                              //   _focusedDay = focusedDay;
                              // });

                              // DateTime startOfWeek = DateTime.now().subtract(
                              //     Duration(days: DateTime.now().weekday - 1));
                              // DateTime endOfWeek =
                              //     startOfWeek.add(Duration(days: 7));

                              // if (selectedDay.isAfter(startOfWeek
                              //         .subtract(const Duration(days: 1))) &&
                              //     selectedDay.isBefore(
                              //         endOfWeek.add(const Duration(days: 1)))) {
                              //   setState(() {
                              //     // Your selection logic here
                              //     if (isSameDay(selectedDay,
                              //         homeController.SelectedDate)) {
                              //       homeController.SelectedDate = null;
                              //     } else if (isSameDay(
                              //         selectedDay, homeController.EndDate)) {
                              //       homeController.EndDate = null;
                              //     } else if (homeController.SelectedDate ==
                              //         null) {
                              //       homeController.SelectedDate = selectedDay;
                              //     } else if (homeController.SelectedDate !=
                              //             null &&
                              //         homeController.EndDate == null) {
                              //       selectedDay.isBefore(
                              //               homeController.SelectedDate!)
                              //           ? {
                              //               homeController.EndDate =
                              //                   homeController.SelectedDate,
                              //               homeController.SelectedDate =
                              //                   selectedDay,
                              //             }
                              //           : homeController.EndDate = selectedDay;
                              //     } else if (homeController.SelectedDate !=
                              //             null &&
                              //         homeController.EndDate != null) {
                              //       selectedDay.isAfter(homeController.EndDate!)
                              //           ? homeController.EndDate = selectedDay
                              //           : selectedDay.isAfter(
                              //                   homeController.SelectedDate!)
                              //               ? homeController.EndDate =
                              //                   selectedDay
                              //               : homeController.SelectedDate =
                              //                   selectedDay;
                              //     } else if (homeController.SelectedDate ==
                              //             null &&
                              //         homeController.EndDate != null) {
                              //       selectedDay.isAfter(homeController.EndDate!)
                              //           ? {
                              //               homeController.SelectedDate =
                              //                   homeController.EndDate,
                              //               homeController.EndDate =
                              //                   selectedDay,
                              //             }
                              //           : 0;
                              //     }

                              //     _focusedDay = focusedDay;
                              //   });
                              // } else {
                              //   Utils.showToast(
                              //     message: "Can't Book Meal For This Day.",
                              //     gravity: ToastGravity.BOTTOM,
                              //     textColor: Colors.white,
                              //     timeduration: 1,
                              //     fontsize: 16,
                              //   );
                              // }
                            },

                            onFormatChanged: (format) {
                              if (_calendarFormat != format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              }
                            },
                            onPageChanged: (focusedDay) {
                              setState(() {
                                _focusedDay = focusedDay;
                              });
                            },

                            calendarStyle: const CalendarStyle(
                              rangeEndDecoration: BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                              ),
                              withinRangeTextStyle:
                                  TextStyle(color: AppColor.white),
                              rangeHighlightColor: AppColor.primary,
                              holidayDecoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/drawer/amenities.png"))),
                              selectedDecoration: BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                              ),
                              todayDecoration: BoxDecoration(
                                color: AppColor.secondary,
                                shape: BoxShape.circle,
                              ),
                              todayTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            headerVisible: false, // Disable the default header
                            calendarBuilders: CalendarBuilders(
                              dowBuilder: (context, day) {
                                return Center(
                                  child: Text(
                                    DateFormat.E().format(day),
                                    style: const TextStyle(color: AppColor.grey3
                                        //  day.weekday == DateTime.sunday
                                        //     ? Colors.red
                                        //     : AppColor.primary,
                                        ),
                                  ),
                                );
                              },
                              defaultBuilder: (context, day, focusedDay) {
                                final isToday = isSameDay(day, DateTime.now());
                                final isSelected = isSameDay(
                                    day, messController.EditSelectedDate);
                                final endSelected =
                                    isSameDay(day, messController.EndDate);
                                final holiday = holidays.any((holiday) =>
                                    holiday.year == day.year &&
                                    holiday.month == day.month &&
                                    holiday.day == day.day);

                                if (isSelected && holiday) {
                                  return Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColor.white,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/drawer/amenities.png")),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${day.day}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (isSelected) {
                                  return holiday == true
                                      ? Center(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: AppColor.white,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/drawer/amenities.png")),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${day.day}',
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Center(
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: AppColor.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${day.day}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        );
                                }

                                if (endSelected) {
                                  return Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColor.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${day.day}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (holiday) {
                                  return Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/drawer/amenities.png")),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${day.day}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (holiday) {
                                  return Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/drawer/amenities.png")),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${day.day}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if (isToday) {
                                  return Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: AppColor.secondary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${day.day}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return Center(
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle(
                                      color: day.weekday == DateTime.sunday
                                          ? AppColor.red
                                          : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // const SizedBox(height: 10),
                SizedBox(
                  // width: 350.w,
                  height: globals.globalwidth * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 320.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primary.withOpacity(0.7),
                            spreadRadius: 1,
                            blurRadius: 1,
                            // offset: Offset(-1, -2),
                          ),
                          // BoxShadow(
                          //   color: AppColor.primary.withOpacity(0.7),
                          //   spreadRadius: 1,
                          //   blurRadius: 1,
                          //   offset: Offset(1, 0),
                          // ),
                          // BoxShadow(
                          //   color: AppColor.grey2.withOpacity(0.2),
                          //   spreadRadius: 1,
                          //   blurRadius: 1,
                          //   offset: Offset(1, 2),
                          // ),
                          // BoxShadow(
                          //   color: AppColor.grey2.withOpacity(0.2),
                          //   spreadRadius: 1,
                          //   blurRadius: 1,
                          //   offset: Offset(-1, 2),
                          // ),
                        ],
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Date",
                                        style: AppTextTheme
                                            .textTheme.displayLarge
                                            ?.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.grey3),
                                      ),
                                      SizedBox(width: 10.w),
                                      const Icon(
                                        FeatherIcons.calendar,
                                        color: AppColor.primary,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Container(
                                    width: double.infinity,
                                    height: 30.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: AppColor.lightyellow),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 0.h),
                                      child: Center(
                                        child: Text(
                                          _formatDate(
                                              messController.EditSelectedDate),
                                          style: AppTextTheme
                                              .textTheme.displayLarge
                                              ?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.textblack),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const MealContainer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MealContainer extends StatefulWidget {
  const MealContainer({super.key});

  @override
  _MealContainerState createState() => _MealContainerState();
}

class _MealContainerState extends State<MealContainer> {
  final MessController messController = Get.put(MessController());
  List<String> selectedMeals = [];

  void selectMeal() {
    setState(() {
      messController.EditDinner(false);
      messController.EditLunch(false);
      messController.EditBreakfast(false);
      messController.Editheightea(false);
    });
  }

  void buttonselectMeal() {
    setState(() {
      messController.EditDinner.value == true &&
              messController.EditLunch.value == true &&
              messController.EditBreakfast.value == true &&
              messController.Editheightea.value == true
          ? {
              messController.EditFullday(true),
              messController.EditDinner(false),
              messController.EditLunch(false),
              messController.EditBreakfast(false),
              messController.Editheightea(false),
            }
          : messController.EditFullday(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 140.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  MealCard(
                    title: 'Breakfast',
                    onTap: () {
                      setState(() {
                        messController.EditBreakfast.value == true
                            ? messController.EditBreakfast(false)
                            : messController.EditBreakfast(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected: messController.EditBreakfast.value == true
                        ? true
                        : false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MealCard(
                    title: 'Lunch',
                    onTap: () {
                      setState(() {
                        messController.EditLunch.value == true
                            ? messController.EditLunch(false)
                            : messController.EditLunch(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        messController.EditLunch.value == true ? true : false,
                  ),
                ],
              ),
              Column(
                children: [
                  MealCard(
                    title: 'Dinner',
                    onTap: () {
                      setState(() {
                        messController.EditDinner.value == true
                            ? messController.EditDinner(false)
                            : messController.EditDinner(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        messController.EditDinner.value == true ? true : false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MealCard(
                    title: 'High-tea',
                    onTap: () {
                      setState(() {
                        messController.Editheightea.value == true
                            ? messController.Editheightea(false)
                            : messController.Editheightea(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected: messController.Editheightea.value == true
                        ? true
                        : false,
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 8),
          MealCard(
            width: double.infinity.w,
            title: 'Full Day',
            onTap: () {
              setState(() {
                messController.EditFullday.value == true
                    ? {
                        messController.EditFullday(false),
                        selectMeal(),
                      }
                    : {
                        messController.EditFullday(true),
                        selectMeal(),
                      };
              });
            },
            isSelected: messController.EditFullday.value == true ? true : false,
          ),
          // SizedBox(height: 20),
          // Container(
          //   height: 50.h,
          //   child: SelectedMealView(
          //     meal: selectedMeals.join(', '),
          //     onClear: () {
          //       setState(() {
          //         selectedMeals = [];
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class MealCard extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final double? width;

  const MealCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    this.width,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color:
              widget.isSelected ? AppColor.lightyellow : AppColor.lightpurple,
        ),
        width: widget.width ?? 120.w,
        height: 30.h,
        child: Center(
          child: Text(
            widget.title,
            style: AppTextTheme.textTheme.displayLarge?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.textblack),
          ),
        ),
      ),
    );
  }
}

class SelectedMealView extends StatelessWidget {
  final String meal;
  final VoidCallback onClear;

  const SelectedMealView({
    super.key,
    required this.meal,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selected Meal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            child: Center(
              child: meal.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          meal,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: onClear,
                          child: const Text('Clear Selection'),
                        ),
                      ],
                    )
                  : const Text(
                      'No meal selected',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

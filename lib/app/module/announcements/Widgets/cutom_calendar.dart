// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _enddate;

  List<DateTime> holidays = [
    DateTime.parse("2024-08-15 18:57:59.274895"),
    DateTime.parse("2024-09-02 18:57:59.274895"),
    DateTime.parse("2024-09-14 18:57:59.274895"),
  ];

  // Custom DateFormatter for month and year
  String _formatMonthYear(DateTime date) {
    return DateFormat.yMMM().format(date);
  }

  void _onPreviousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1);
    });
  }

  void _onNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-1, -2),
          ),
          BoxShadow(
            color: AppColor.primary.withOpacity(0.7),
            spreadRadius: 1,
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
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _focusedDay) {
                    setState(() {
                      _focusedDay = picked;
                    });
                  }
                },
              ),
            ],
          ),
          TableCalendar(
            rangeStartDay: _selectedDay,
            rangeEndDay: _enddate,
            firstDay: DateTime.utc(1999, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month, // Fixed to "month" format
            availableCalendarFormats: const {CalendarFormat.month: 'Month'},
            // calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              DateTime? tempdate;
              setState(() {
                if (_selectedDay != null && _enddate == null) {
                  // If a start date is already selected, and no end date is set
                  _enddate = selectedDay;
                  bool isValidRange = !_enddate!.isBefore(_selectedDay!);
                  isValidRange == false
                      ? {
                          tempdate = _selectedDay,
                          _selectedDay = _enddate,
                          _enddate = tempdate,
                        }
                      : 0;
                } else if (_selectedDay != null && _enddate != null) {
                  // If both start and end dates are already set, reset them
                  _selectedDay = selectedDay;
                  _enddate = null;
                } else {
                  // If no dates are selected, set the start date
                  _selectedDay = selectedDay;
                }

                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              print("hello date : $focusedDay");
            },
            calendarStyle: const CalendarStyle(
              rangeEndDecoration: BoxDecoration(
                color: AppColor.primary,
                shape: BoxShape.circle,
              ),
              withinRangeTextStyle: TextStyle(color: AppColor.white),
              rangeHighlightColor: AppColor.primary,
              holidayDecoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/drawer/amenities.png"))),
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
                final isSelected = isSameDay(day, _selectedDay);
                final endSelected = isSameDay(day, _enddate);
                final holiday = holidays.any((holiday) =>
                    holiday.year == day.year &&
                    holiday.month == day.month &&
                    holiday.day == day.day);

                if (isSelected) {
                  return Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColor.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white),
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
                          style: const TextStyle(color: Colors.white),
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
                          style: const TextStyle(color: Colors.black),
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
                          style: const TextStyle(color: Colors.white),
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
    );
  }
}

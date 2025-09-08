import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/Attendance/widegts/selectedDate.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';

class MessAttendance extends StatefulWidget {
  const MessAttendance({super.key});

  @override
  State<MessAttendance> createState() => _MessAttendanceState();
}

class _MessAttendanceState extends State<MessAttendance> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CutomAppBarContainer(
          isScroll: false,
          title: "MESS ATTENDANCE",
          messmanagment: false,
          contentWidgets: [
            Container(
              height: 520.h,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                  boxShadow: const [
                    // BoxShadow(color: AppColor.grey3, spreadRadius: 1, blurRadius: 1)
                  ]),
              padding: EdgeInsets.only(left: 11.w, right: 11.w, top: 16.h),
              child: Column(
                children: [
                  // Custom Calendar Header
                  Container(
                    padding: EdgeInsets.only(
                      left: 2.w,
                      right: 4.w,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: _focusedDay,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2101),
                              );
                              if (picked != _focusedDay) {
                                setState(() {
                                  _focusedDay = picked!;
                                });
                              }
                            },
                            child:
                                SelecteAttendenceDate(focusedDay: _focusedDay)),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(7, (index) {
                            DateTime date = _focusedDay.add(Duration(
                                days: index - _focusedDay.weekday + 1));
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDay = date;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: _selectedDay == date
                                        ? AppColor.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.r))),
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      date.day.toString(),
                                      style: AppTextTheme.textTheme.displayLarge
                                          ?.copyWith(
                                              color: _selectedDay == date
                                                  ? AppColor.textwhite
                                                  : AppColor.primary,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20.sp),
                                    ),
                                    Text(
                                      DateFormat.E().format(date),
                                      style: AppTextTheme.textTheme.displayLarge
                                          ?.copyWith(
                                        fontSize: 12.sp,
                                        color: _selectedDay == date
                                            ? AppColor.textwhite
                                            : AppColor.primary,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        height: 400.h,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(20.r)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.w, vertical: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      FeatherIcons.calendar,
                                      color: AppColor.textwhite,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      _selectedDay != null
                                          ? DateFormat.yMMMd()
                                              .format(_selectedDay!)
                                          : 'No date selected',
                                      style: AppTextTheme.textTheme.displayLarge
                                          ?.copyWith(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.textwhite),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10
                                      .h, // Adjust this for your desired spacing
                                ),
                                Divider(
                                  height: 1.h,
                                  color: AppColor.textwhite,
                                ),
                                SizedBox(
                                  height: 10
                                      .h, // Adjust this for your desired spacing
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            "BREAKFAST",
                                            style: AppTextTheme
                                                .textTheme.bodySmall
                                                ?.copyWith(
                                              color: AppColor.textwhite,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 10.h,
                                              width: 10.h,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Present",
                                              style: AppTextTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                color: AppColor.textwhite,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Divider(
                                      height: 1.h,
                                      color: AppColor.textwhite,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            "LUNCH",
                                            style: AppTextTheme
                                                .textTheme.bodySmall
                                                ?.copyWith(
                                              color: AppColor.textwhite,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 10.h,
                                              width: 10.h,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Present",
                                              style: AppTextTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                color: AppColor.textwhite,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Divider(
                                      height: 1.h,
                                      color: AppColor.textwhite,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            "HI TEA",
                                            style: AppTextTheme
                                                .textTheme.bodySmall
                                                ?.copyWith(
                                              color: AppColor.textwhite,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 10.h,
                                              width: 10.h,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Present",
                                              style: AppTextTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                color: AppColor.textwhite,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Divider(
                                      height: 1.h,
                                      color: AppColor.textwhite,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            "DINNER",
                                            style: AppTextTheme
                                                .textTheme.bodySmall
                                                ?.copyWith(
                                              color: AppColor.textwhite,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 10.h,
                                              width: 10.h,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Text(
                                              "Absent",
                                              style: AppTextTheme
                                                  .textTheme.bodySmall
                                                  ?.copyWith(
                                                color: AppColor.textwhite,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Divider(
                                      height: 1.h,
                                      color: AppColor.textwhite,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: -10.h,
          left: 0.h,
          right: 0.h,
          child: SizedBox(
            height: 100.h,
            child: const CustomBottomNavbar(),
          ),
        ),
      ],
    );
  }
}

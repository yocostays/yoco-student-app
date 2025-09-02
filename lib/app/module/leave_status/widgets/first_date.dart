import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/widgets/ev_slot_inputtextfield.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';

class FirstDateSelecteDateRange extends StatelessWidget {
  final bool leave;
  const FirstDateSelecteDateRange({
    super.key,
    required LeaveController leavecontroller,
    required this.leave,
  }) : _leavecontroller = leavecontroller;

  final LeaveController _leavecontroller;

  @override
  Widget build(BuildContext context) {
    TimeOfDay? StartTime;
    TimeOfDay? EndTime;
    DateTimeRange? picked;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              leave == true ? "SELECT RANGE*" : "SELECT TIME RANGE*",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.grey3,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                  letterSpacing: 0.8),
            ),
            // Text(
            //   leave == true ? "NO. OF DAYS" : "NO. OF HOURS",
            //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //       color: AppColor.grey3,
            //       fontWeight: FontWeight.bold,
            //       height: 1.5,
            //       letterSpacing: 0.8),
            // ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "From",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.grey3,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                  letterSpacing: 0.8),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: leave == true
                  ? MediaQuery.of(context).size.width * 0.45.w
                  : MediaQuery.of(context).size.width * 0.55.w,
              height: 32.h,
              child: InkWell(
                onTap: () async => {
                  leave == true
                      ? {
                          picked = _leavecontroller.selectedDay.isNotEmpty
                              ? await showDateRangePicker(
                                  context: context,
                                  initialDateRange: DateTimeRange(
                                    start: _leavecontroller.selectedDay.first!,
                                    end: _leavecontroller.selectedDay.last!,
                                  ),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                )
                              : await showDateRangePicker(
                                  context: context,
                                  initialDateRange: DateTimeRange(
                                    start: DateTime.now(),
                                    end: DateTime.now(),
                                  ),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                ),
                          if (picked != null)
                            {
                              _leavecontroller.selectedDay.clear(),
                              // Do something with the selected range

                              _leavecontroller.selectedDay.add(picked!.start),
                              _leavecontroller.selectedDay.add(picked!.end),
                              if (_leavecontroller.selectedDay.isEmpty)
                                {
                                  _leavecontroller.selectDaterang.clear(),
                                  _leavecontroller.totaldate.clear(),
                                }
                              else
                                {
                                  _leavecontroller.selectDaterang.text =
                                      _leavecontroller.formatDateRange(
                                          _leavecontroller.selectedDay.first ??
                                              DateTime.now(),
                                          _leavecontroller.selectedDay.last ??
                                              DateTime.now()),
                                }
                            }
                        }
                      : {
                          StartTime = await showTimePicker(
                            helpText: "Select Start Time",
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              );
                            },
                          ),
                          StartTime != null
                              ? EndTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  helpText: "Select End Time",
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: false),
                                      child: child!,
                                    );
                                  },
                                )
                              : 0,
                          StartTime == null && EndTime == null
                              ? 0
                              : {
                                  _leavecontroller.TimeRange.text =
                                      _leavecontroller.formatTimeRange(
                                          context, StartTime, EndTime),
                                  _leavecontroller.EndTime = DateTime(
                                    _leavecontroller.selectedDay.first!.year,
                                    _leavecontroller.selectedDay.first!.month,
                                    _leavecontroller.selectedDay.first!.day,
                                    EndTime!.hour,
                                    EndTime!.minute,
                                  ),
                                  _leavecontroller.StartTime = DateTime(
                                    _leavecontroller.selectedDay.first!.year,
                                    _leavecontroller.selectedDay.first!.month,
                                    _leavecontroller.selectedDay.first!.day,
                                    StartTime!.hour,
                                    StartTime!.minute,
                                  ),
                                },
                        }
                },
                child: Ev_Slot_Custom_textfield(
                  textfiled: false,
                  textcenter: false,
                  textstyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12,
                      color: AppColor.textblack,
                      fontWeight: FontWeight.bold),
                  perfixiconwidget: Icon(
                    leave == true ? FeatherIcons.calendar : FeatherIcons.clock,
                    size: 20,
                    color: AppColor.primary,
                  ),
                  TextController: leave == true
                      ? _leavecontroller.firstdateDate
                      : _leavecontroller.TimeRange,
                  hint: 'Select Range',
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                StartTime = await showTimePicker(
                  helpText: "Select Start Time",
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: false),
                      child: child!,
                    );
                  },
                );

                _leavecontroller.firstdatetime.text =
                    _leavecontroller.formatTime(context, StartTime);
                _leavecontroller.selectedDay.isNotEmpty
                    ? {
                        _leavecontroller.selectedDay.first = DateTime(
                          _leavecontroller.selectedDay.first!.year,
                          _leavecontroller.selectedDay.first!.month,
                          _leavecontroller.selectedDay.first!.day,
                          StartTime!.hour,
                          StartTime!.minute,
                        )
                      }
                    : {0};
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.26.w,
                height: 32.h,
                child: Ev_Slot_Custom_textfield(
                  perfixiconwidget: const Icon(
                    FeatherIcons.clock,
                    size: 20,
                    color: AppColor.primary,
                  ),
                  textstyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12,
                      color: AppColor.textblack,
                      fontWeight: FontWeight.bold),
                  textfiled: false,
                  TextController: leave == true
                      ? _leavecontroller.firstdatetime
                      : _leavecontroller.Noofhours,
                  hint: "Time",
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

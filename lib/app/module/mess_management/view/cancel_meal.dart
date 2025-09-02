import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yoco_stay_student/app/module/mess_management/repository.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import '../../../core/theme/texttheme.dart';
import '../../../core/values/colors.dart';
import '../../../widgets/custom_appbar_container.dart';

class CancelMealManagment extends StatefulWidget {
  const CancelMealManagment({super.key});

  @override
  State<CancelMealManagment> createState() => _CancelMealManagmentState();
}

class _CancelMealManagmentState extends State<CancelMealManagment> {
  final MessController messController = Get.put(MessController());
  final ScrollController _scrollController = ScrollController();
  late DateTime lastDayOfMonth;
  DateTime? _selectedDate;
  DateTime now = DateTime.now();
  late int todayIndex;
  final FocusNode _focusNode = FocusNode();
  bool _isKeyboardOpen = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isKeyboardOpen = _focusNode.hasFocus;
      });
    });
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    // messController.selectedDayList.add(DateTime.now());
    // Add the scroll listener to the controller
    messController.selectedDayList.clear();

    todayIndex = DateTime.now()
        .difference(DateTime(_focusedDay.year, _focusedDay.month, 1))
        .inDays;

    // Scroll to today's date after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate(todayIndex);
    });

    // DateTime firstDayOfMonth =
    //     DateTime(DateTime.now().year, DateTime.now().month, 1);
    // messController.GetBookedData(firstDayOfMonth);
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _focusedDay = pickedDate;
        // _selectedDay.add(pickedDate);
      });
    }
  }

  void _scrollToSelectedDate(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = 60.0;
    double scrollPosition =
        0; // Set this to the actual width of each date item.

    // Calculate the offset to center the selected item
    if (index < 14) {
      scrollPosition =
          (index * itemWidth) - (screenWidth / 1.5) + (itemWidth / 1.5);
    } else if (index < 17) {
      scrollPosition =
          (index * itemWidth) - (screenWidth / 1) + (itemWidth / 1);
    } else if (index < 20) {
      scrollPosition =
          (index * itemWidth) - (screenWidth / 0.9) + (itemWidth / 0.9);
    } else {
      scrollPosition =
          (index * itemWidth) - (screenWidth / 0.8) + (itemWidth / 0.8);
    }
    // Ensure the calculated scroll position doesn’t go below zero
    scrollPosition = scrollPosition < 0 ? 0 : scrollPosition;

    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final daySuffix = _getDaySuffix(date.day);
    final formattedDate = DateFormat("d'$daySuffix' MMM, yyyy").format(date);
    return formattedDate;
  }

  bool isDateInList(DateTime date, List<DateTime?> selectedDates) {
    return selectedDates.any((d) => d != null && isSameDay(d, date));
  }

  void removeDate(DateTime date, List<DateTime?> selectedDates) {
    selectedDates.removeWhere((d) => d != null && isSameDay(d, date));
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

  DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;

  Future<void> selectDateRange(BuildContext context) async {
    DateTimeRange? picked = messController.selectedDayList.isNotEmpty
        ? await showDateRangePicker(
            context: context,
            initialDateRange: DateTimeRange(
              start: messController.selectedDayList.first!,
              end: messController.selectedDayList.last!,
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
          );

    if (picked != null) {
      messController.selectedDayList.clear();
      // Do something with the selected range

      setState(() {
        messController.selectedDayList.add(picked.start);
        messController.selectedDayList.add(picked.end);
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton:
      //     Visibility(visible: !_isKeyboardOpen, child: CenterButton()),
      // bottomNavigationBar: BottomNavigation(),
      body: Stack(
        children: [
          CutomAppBarContainer(title: "MESS MANAGEMENT", contentWidgets: [
            Container(
              height: 550.h,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: const [
                    BoxShadow(
                        color: AppColor.grey3, spreadRadius: 1, blurRadius: 1)
                  ]),
              child: Column(
                children: [
                  // Custom Calendar Header
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => selectDateRange(context),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 11.w, right: 11.w, top: 16.h),
                          child: Row(
                            children: [
                              Text(
                                DateFormat.yMMMM().format(_focusedDay),
                                style: AppTextTheme.textTheme.displayLarge
                                    ?.copyWith(
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Icon(
                                FeatherIcons.edit,
                                size: 20,
                                color: AppColor.primary,
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(CupertinoIcons.chevron_back,
                                color: AppColor.primary),
                            onPressed: () {
                              setState(() {
                                // Move to the previous month
                                if (_focusedDay.month > 1) {
                                  _focusedDay = DateTime(_focusedDay.year,
                                      _focusedDay.month - 1, 1);
                                } else {
                                  // If it's January, go to December of the previous year
                                  _focusedDay =
                                      DateTime(_focusedDay.year - 1, 12, 1);
                                }
                                lastDayOfMonth = DateTime(
                                    _focusedDay.year, _focusedDay.month + 1, 0);
                              });
                              messController.GetBookedData(_focusedDay);
                            },
                          ),
                          SizedBox(
                            width: 240.w,
                            height:
                                65.h, // Ensure the ListView has a fixed height
                            child: Obx(
                              () => messController.BookedDateLoading.value
                                  ? const Loader()
                                  : ListView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      controller: _scrollController,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          // lastDayOfMonth.month ==
                                          //             DateTime.now().month &&
                                          //         lastDayOfMonth.year == DateTime.now().year
                                          //     ? lastDayOfMonth.day - now.day + 1
                                          //     :
                                          lastDayOfMonth.day,
                                      itemBuilder: (context, index) {
                                        bool isSelected = false;
                                        DateTime date =
                                            //  _focusedDay.month ==
                                            //             DateTime.now().month &&
                                            //         _focusedDay.year == DateTime.now().year
                                            //     ? DateTime.now().add(Duration(days: index))
                                            //     :
                                            DateTime(_focusedDay.year,
                                                    _focusedDay.month, 1)
                                                .add(Duration(days: index));
                                        messController.selectedDayList.isEmpty
                                            ? isSelected = false
                                            : isSelected = messController
                                                    .selectedDayList.isNotEmpty &&
                                                (Utils.IsSameDates(date, messController.selectedDayList.first!) ||
                                                    Utils.IsSameDates(
                                                        date,
                                                        messController
                                                            .selectedDayList
                                                            .last!) ||
                                                    (date.isAfter(DateTime(messController.selectedDayList.first!.year, messController.selectedDayList.first!.month, messController.selectedDayList.first!.day)) &&
                                                        date.isBefore(DateTime(
                                                            messController
                                                                .selectedDayList
                                                                .last!
                                                                .year,
                                                            messController
                                                                .selectedDayList
                                                                .last!
                                                                .month,
                                                            messController
                                                                .selectedDayList
                                                                .last!
                                                                .day))) ||
                                                    Utils.isDateInList(date, messController.selectedDayList));

                                        if (isSelected) {
                                          // Automatically scroll to the selected date
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            _scrollToSelectedDate(index);
                                          });
                                        }

                                        print(
                                            "hello data : ${messController.isoDateStrings}");
                                        bool isBooked = messController
                                            .isoDateStrings!
                                            .any((isoString) {
                                          DateTime bookedDate =
                                              DateTime.parse(isoString);

                                          // Check if `date` matches the `bookedDate` ignoring the time
                                          return date.year == bookedDate.year &&
                                              date.month == bookedDate.month &&
                                              date.day == bookedDate.day;
                                        });
                                        //  _selectedDay.contains(date);
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  date.isAfter(
                                                              DateTime.now()) ||
                                                          (date.day ==
                                                                  DateTime.now()
                                                                      .day &&
                                                              date.month ==
                                                                  DateTime.now()
                                                                      .month &&
                                                              date.year ==
                                                                  DateTime.now()
                                                                      .year)
                                                      ? {
                                                          _scrollToSelectedDate(
                                                              index),
                                                          if (messController
                                                              .selectedDayList
                                                              .isNotEmpty)
                                                            {
                                                              if (Utils.isDateInList(
                                                                  date,
                                                                  messController
                                                                      .selectedDayList))
                                                                {
                                                                  Utils.removeDate(
                                                                      date,
                                                                      messController
                                                                          .selectedDayList),
                                                                }
                                                              else if (date.isBefore(
                                                                  messController
                                                                      .selectedDayList
                                                                      .first!))
                                                                {
                                                                  messController
                                                                      .selectedDayList
                                                                      .first = date,
                                                                }
                                                              else if (date.isAfter(
                                                                      messController
                                                                          .selectedDayList
                                                                          .first!) &&
                                                                  date.isBefore(
                                                                      messController
                                                                          .selectedDayList
                                                                          .last!))
                                                                {
                                                                  messController
                                                                      .selectedDayList
                                                                      .last = date,
                                                                }
                                                              else
                                                                {
                                                                  messController
                                                                      .selectedDayList
                                                                      .add(
                                                                          date),
                                                                }
                                                            }
                                                          else
                                                            {
                                                              messController
                                                                  .selectedDayList
                                                                  .add(date),
                                                            }
                                                        }
                                                      : Utils.showToast(
                                                          message:
                                                              "Can't Select Back Date!",
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          textColor:
                                                              Colors.white,
                                                          fontsize: 16,
                                                        );
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? AppColor.primary
                                                        : isBooked
                                                            ? AppColor
                                                                .lightpurple
                                                            : Utils.isSelectedDayisSameAsTodayDate(
                                                                    date)
                                                                ? AppColor
                                                                    .secondary
                                                                : Colors
                                                                    .transparent,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(10.r),
                                                      bottom:
                                                          Radius.circular(10.r),
                                                    )),
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      date.day.toString(),
                                                      style: AppTextTheme
                                                          .textTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                              color: isSelected
                                                                  ? AppColor
                                                                      .textwhite
                                                                  : AppColor
                                                                      .primary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 20),
                                                    ),
                                                    Text(
                                                      DateFormat.E()
                                                          .format(date),
                                                      style: AppTextTheme
                                                          .textTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                        fontSize: 12,
                                                        color: isSelected
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
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            )
                                          ],
                                        );
                                      },
                                    ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.chevron_forward,
                                color: AppColor.primary),
                            onPressed: () {
                              setState(() {
                                // Move to the next month
                                _focusedDay = DateTime(
                                    _focusedDay.year, _focusedDay.month + 1, 1);
                                lastDayOfMonth = DateTime(
                                    _focusedDay.year, _focusedDay.month + 1, 0);
                              });
                              messController.GetBookedData(_focusedDay);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),

                  Stack(
                    children: [
                      SizedBox(
                        height: 380.h,
                        width: double.infinity,
                        // child: Container(
                        //     // height: 190.h,
                        //     // width: 340.w,
                        //     decoration: BoxDecoration(
                        //         color: AppColor.primary,
                        //         borderRadius: BorderRadius.circular(20.r)),
                        //     child: Obx(
                        //       () => messController.MealdataLoading.value == true
                        //           ? CustomShimmer()
                        //           : Padding(
                        //               padding: EdgeInsets.symmetric(
                        //                   horizontal: 25.w, vertical: 20.h),
                        //               child: Column(
                        //                 children: [
                        //                   Container(
                        //                     height: 100.h,
                        //                     child: ListView.builder(
                        //                       // physics: NeverScrollableScrollPhysics(),
                        //                       padding: EdgeInsets.all(0),
                        //                       // physics: NeverScrollableScrollPhysics(),
                        //                       shrinkWrap: true,
                        //                       itemCount:
                        //                           4, // Assuming you have 3 items in your list
                        //                       itemBuilder: (context, index) {
                        //                         return Column(
                        //                           crossAxisAlignment:
                        //                               CrossAxisAlignment.start,
                        //                           children: [
                        //                             Row(
                        //                               mainAxisAlignment:
                        //                                   MainAxisAlignment.start,
                        //                               children: [
                        //                                 SizedBox(
                        //                                   width: 100.w,
                        //                                   child: Text(
                        //                                     index == 0
                        //                                         ? "BREAKFAST:"
                        //                                         : index == 1
                        //                                             ? "LUNCH"
                        //                                             : index == 2
                        //                                                 ? "SNACKS"
                        //                                                 : index ==
                        //                                                         3
                        //                                                     ? "DINNER"
                        //                                                     : "",
                        //                                     style: AppTextTheme
                        //                                         .textTheme
                        //                                         .bodySmall
                        //                                         ?.copyWith(
                        //                                       color: AppColor
                        //                                           .textwhite,
                        //                                       fontWeight:
                        //                                           FontWeight.w700,
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 Expanded(
                        //                                   child: Text(
                        //                                     index == 0
                        //                                         ? messController
                        //                                                 .todayMealData
                        //                                                 .value
                        //                                                 .breakfast ??
                        //                                             "NA"
                        //                                         : index == 1
                        //                                             ? messController
                        //                                                     .todayMealData
                        //                                                     .value
                        //                                                     .lunch ??
                        //                                                 "NA"
                        //                                             : index == 2
                        //                                                 ? messController
                        //                                                         .todayMealData
                        //                                                         .value
                        //                                                         .snacks ??
                        //                                                     "NA"
                        //                                                 : index ==
                        //                                                         3
                        //                                                     ? messController.todayMealData.value.dinner ??
                        //                                                         "NA"
                        //                                                     : "",
                        //                                     style: AppTextTheme
                        //                                         .textTheme
                        //                                         .bodySmall
                        //                                         ?.copyWith(
                        //                                       color: AppColor
                        //                                           .textwhite,
                        //                                     ),
                        //                                     maxLines: 2,
                        //                                   ),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                             SizedBox(
                        //                               height: 10
                        //                                   .h, // Adjust this for your desired spacing
                        //                             ),
                        //                             Divider(
                        //                               height: 1.h,
                        //                               color: AppColor.textwhite,
                        //                             ),
                        //                             SizedBox(
                        //                               height: 10
                        //                                   .h, // Adjust this for your desired spacing
                        //                             ),
                        //                           ],
                        //                         );
                        //                       },
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //     )),
                      ),
                      Positioned(
                        // bottom: 0,
                        // left: 0.w,
                        // right: 0.w,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 11.w,
                            right: 11.w,
                          ),
                          child: SizedBox(
                            width: 380.w,
                            child: Center(
                              child: Container(
                                width: 340.w,
                                height: 430.h,
                                decoration: BoxDecoration(
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
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Cancel Meal",
                                                style: AppTextTheme
                                                    .textTheme.displayLarge
                                                    ?.copyWith(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColor.grey3),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    selectDateRange(context),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Date*",
                                                      style: AppTextTheme
                                                          .textTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColor
                                                                  .grey3),
                                                    ),
                                                    SizedBox(width: 10.w),
                                                    const Icon(
                                                      FeatherIcons.calendar,
                                                      color: AppColor.primary,
                                                      size: 20,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10.h),
                                              Container(
                                                width: double.infinity,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    color:
                                                        AppColor.lightyellow),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 10.h),
                                                  child: Center(
                                                    child: Text(
                                                      messController
                                                              .selectedDayList
                                                              .isNotEmpty
                                                          ? messController
                                                                      .selectedDayList
                                                                      .length ==
                                                                  1
                                                              ?
                                                              // "${DateFormat.yMMMMd().format(_selectedDay.first!)}"
                                                              _formatDate(
                                                                  messController
                                                                      .selectedDayList
                                                                      .first!)
                                                              : "${_formatDate(messController.selectedDayList.first!)} to ${_formatDate(messController.selectedDayList.last!)}"
                                                          : 'No date selected*',
                                                      style: AppTextTheme
                                                          .textTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColor
                                                                  .textblack),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const MealContainer(),
                                        const SizedBox(
                                          height: 80,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Reason",
                                                style: AppTextTheme
                                                    .textTheme.displayLarge
                                                    ?.copyWith(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColor.grey3),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 210.w,
                                                    // height: 40.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                        color: AppColor
                                                            .lightyellow),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: TextField(
                                                          controller:
                                                              messController
                                                                  .Reason,
                                                          style: AppTextTheme
                                                              .textTheme
                                                              .displayLarge
                                                              ?.copyWith(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColor
                                                                      .textblack),
                                                          minLines:
                                                              1, // Minimum number of visible lines
                                                          maxLines: null,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Type here",
                                                            border: InputBorder
                                                                .none, // Removes the bottom line
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none, // Removes the bottom line when focused
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none, // Removes the bottom line when enabled
                                                            errorBorder: InputBorder
                                                                .none, // Removes the bottom line when there's an error
                                                            disabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            hintStyle: AppTextTheme
                                                                .textTheme
                                                                .displayLarge
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: AppColor
                                                                        .grey3),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (messController
                                                                  .Breakfast
                                                                  .value ==
                                                              false &&
                                                          messController.Lunch.value ==
                                                              false &&
                                                          messController.Dinner
                                                                  .value ==
                                                              false &&
                                                          messController.Fullday
                                                                  .value ==
                                                              false &&
                                                          messController
                                                                  .heightea
                                                                  .value ==
                                                              false) {
                                                        Utils.showToast(
                                                          message:
                                                              "Please Selecte a Meal For Cancel.",
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          textColor:
                                                              Colors.white,
                                                          fontsize: 16,
                                                        );
                                                      } else {
                                                        messController
                                                            .CancelMeal();
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 40.h,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: AppColor
                                                                  .lightpurple,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: Icon(
                                                        FeatherIcons
                                                            .chevronRight,
                                                        color: AppColor.primary,
                                                        size: 20.h,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Container(height: 100.h, child: CustomBottomNavbar()),
          // ),
        ],
      ),
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
      messController.Dinner(false);
      messController.Lunch(false);
      messController.Breakfast(false);
      messController.heightea(false);
    });
  }

  void buttonselectMeal() {
    setState(() {
      messController.Dinner.value == true &&
              messController.Lunch.value == true &&
              messController.heightea.value == true &&
              messController.Breakfast.value == true
          ? {
              messController.Fullday(true),
              messController.Dinner(false),
              messController.Lunch(false),
              messController.Breakfast(false),
            }
          : messController.Fullday(false);
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  MealCard(
                    title: 'Breakfast',
                    onTap: () {
                      setState(() {
                        messController.Breakfast.value == true
                            ? messController.Breakfast(false)
                            : messController.Breakfast(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        messController.Breakfast.value == true ? true : false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MealCard(
                    title: 'Lunch',
                    onTap: () {
                      setState(() {
                        messController.Lunch.value == true
                            ? messController.Lunch(false)
                            : messController.Lunch(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        messController.Lunch.value == true ? true : false,
                  ),
                ],
              ),
              Column(
                children: [
                  MealCard(
                    title: 'High-tea',
                    onTap: () {
                      setState(() {
                        messController.heightea.value == true
                            ? messController.heightea(false)
                            : messController.heightea(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        messController.heightea.value == true ? true : false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MealCard(
                    title: 'Dinner',
                    onTap: () {
                      setState(() {
                        messController.Dinner.value == true
                            ? messController.Dinner(false)
                            : messController.Dinner(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        messController.Dinner.value == true ? true : false,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          MealCard(
            width: double.infinity.w,
            title: 'Full Day',
            onTap: () {
              setState(() {
                print("sdkmfc: ${messController.Fullday.value}");
                messController.Fullday.value == true
                    ? {
                        messController.Fullday(false),
                        selectMeal(),
                      }
                    : {
                        messController.Fullday(true),
                        selectMeal(),
                      };
              });
              print("sdkmfc: ${messController.Fullday.value}");
            },
            isSelected: messController.Fullday.value == true ? true : false,
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
  _MealCardState createState() => _MealCardState();
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
                fontSize: 13.sp,
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

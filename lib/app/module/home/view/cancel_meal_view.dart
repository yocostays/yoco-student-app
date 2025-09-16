import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class MessManagementScreen extends StatefulWidget {
  const MessManagementScreen({super.key});

  @override
  _MessManagementScreenState createState() => _MessManagementScreenState();
}

class _MessManagementScreenState extends State<MessManagementScreen> {
  final HomeController homeController = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();
  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDate;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  late int todayIndex;

  @override
  void initState() {
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    homeController.selectedDay.clear();
    homeController.Reason.clear();

    todayIndex = DateTime.now()
        .difference(DateTime(_focusedDay.year, _focusedDay.month, 1))
        .inDays;

    // Scroll to today's date after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate(todayIndex);
    });
    // DateTime firstDayOfMonth =
    //     DateTime(DateTime.now().year, DateTime.now().month, 1);
    // homeController.GetBookedData(firstDayOfMonth);
    // Add the scroll listener to the controller
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
    // _selectedDay.clear();
    // Startdate = await showDatePicker(
    //   helpText: "Select Start Date",
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(2101),
    // );
    // setState(() {
    //   _selectedDay.add(Startdate);
    // });
    // Startdate != null
    //     ? {
    //         enddate = await showDatePicker(
    //           helpText: "Select End Date",
    //           context: context,
    //           initialDate: DateTime.now(),
    //           firstDate: DateTime.now(),
    //           lastDate: DateTime(2101),
    //         ),
    //         setState(() {
    //           _selectedDay.add(enddate);
    //         }),
    //       }
    //     : 0;
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<String> isoDateStrings = [
    "2024-11-20T00:00:00.000Z",
    "2024-11-25T00:00:00.000Z",
    "2024-11-21T00:00:00.000Z",
    "2024-11-22T00:00:00.000Z",
    "2024-11-23T00:00:00.000Z",
    "2024-11-24T00:00:00.000Z",
  ];

  @override
  Widget build(BuildContext context) {
    return CustomAppBarContainer(
        title: "CANCEL MEAL",
        isMessManagement: false,
        contentWidgets: [
          Container(
            height: 570.h,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [
                  BoxShadow(
                      color: AppColor.grey3, spreadRadius: 1, blurRadius: 1)
                ]),
            padding: EdgeInsets.only(top: 16.h),
            child: Column(
              children: [
                // Custom Calendar Header
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11, right: 11),
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
                    const SizedBox(height: 10.0),
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
                            homeController.GetBookedData(_focusedDay);
                          },
                        ),
                        SizedBox(
                            width: 240.w,
                            height: 65
                                .h, // Ensure the ListView has a fixed height
                            child: Obx(
                              () => homeController.BookedDateLoading.value
                                  ? const Center(
                                      child: Loader(),
                                    )
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
                                        homeController.selectedDay.isEmpty
                                            ? isSelected = false
                                            : isSelected = homeController.selectedDay.isNotEmpty &&
                                                (Utils.IsSameDates(date, homeController.selectedDay.first!) ||
                                                    Utils.IsSameDates(
                                                        date,
                                                        homeController
                                                            .selectedDay
                                                            .last!) ||
                                                    (date.isAfter(DateTime(homeController.selectedDay.first!.year, homeController.selectedDay.first!.month, homeController.selectedDay.first!.day)) &&
                                                        date.isBefore(DateTime(
                                                            homeController
                                                                .selectedDay
                                                                .last!
                                                                .year,
                                                            homeController
                                                                .selectedDay
                                                                .last!
                                                                .month,
                                                            homeController
                                                                .selectedDay
                                                                .last!
                                                                .day))) ||
                                                    Utils.isDateInList(date,
                                                        homeController.selectedDay));
                
                                        if (isSelected) {
                                          // Automatically scroll to the selected date
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            _scrollToSelectedDate(index);
                                          });
                                        }
                
                                        bool isBooked = homeController
                                            .isoDateStrings!
                                            .any((isoString) {
                                          DateTime bookedDate =
                                              DateTime.parse(isoString);
                
                                          // Check if `date` matches the `bookedDate` ignoring the time
                                          return date.year ==
                                                  bookedDate.year &&
                                              date.month ==
                                                  bookedDate.month &&
                                              date.day == bookedDate.day;
                                        });
                                        //  _selectedDay.contains(date);
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  date.isAfter(DateTime
                                                              .now()) ||
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
                                                          if (homeController
                                                              .selectedDay
                                                              .isNotEmpty)
                                                            {
                                                              if (Utils.isDateInList(
                                                                  date,
                                                                  homeController
                                                                      .selectedDay))
                                                                {
                                                                  Utils.removeDate(
                                                                      date,
                                                                      homeController
                                                                          .selectedDay),
                                                                }
                                                              else if (date.isBefore(
                                                                  homeController
                                                                      .selectedDay
                                                                      .first!))
                                                                {
                                                                  homeController
                                                                      .selectedDay
                                                                      .first = date,
                                                                }
                                                              else if (date.isAfter(homeController
                                                                      .selectedDay
                                                                      .first!) &&
                                                                  date.isBefore(homeController
                                                                      .selectedDay
                                                                      .last!))
                                                                {
                                                                  homeController
                                                                      .selectedDay
                                                                      .last = date,
                                                                }
                                                              else
                                                                {
                                                                  homeController
                                                                      .selectedDay
                                                                      .add(
                                                                          date),
                                                                }
                                                            }
                                                          else
                                                            {
                                                              homeController
                                                                  .selectedDay
                                                                  .add(date),
                                                            }
                                                        }
                                                      : Utils.showToast(
                                                          message:
                                                              "Can't Select Back Date!",
                                                          gravity:
                                                              ToastGravity
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
                                                      top: Radius.circular(
                                                          10.r),
                                                      bottom: Radius.circular(
                                                          10.r),
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
                                                            ? AppColor
                                                                .textwhite
                                                            : AppColor
                                                                .primary,
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
                            )),
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
                            homeController.GetBookedData(_focusedDay);
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 11, right: 11),
                  child: SizedBox(
                    height: 430.h,
                    child: Container(
                      width: 340.w,
                      height: 300.h,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
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
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.grey3),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Date",
                                              style: AppTextTheme
                                                  .textTheme.displayLarge
                                                  ?.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                      ),
                                      SizedBox(height: 10.h),
                                      Container(
                                        width: double.infinity,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: AppColor.lightyellow),
                                        child: Center(
                                          child: Text(
                                            // DateFormat("d'$daySuffix' MMM, yyyy").format(date);
                                            homeController
                                                    .selectedDay.isNotEmpty
                                                ? homeController.selectedDay
                                                            .length ==
                                                        1
                                                    ?
                                                    // "${DateFormat.yMMMMd().format(_selectedDay.first!)}"
                                                    _formatDate(homeController
                                                        .selectedDay.first!)
                                                    : "${_formatDate(homeController.selectedDay.first!)} to ${_formatDate(homeController.selectedDay.last!)}"
                                                : 'No date selected',
                                            style: AppTextTheme
                                                .textTheme.displayLarge
                                                ?.copyWith(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color:
                                                        AppColor.textblack),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const MealContainer(),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Reason",
                                    style: AppTextTheme.textTheme.displayLarge
                                        ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.grey3),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 210.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            color: AppColor.lightyellow),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: TextField(
                                            controller: homeController.Reason,
                                            style: AppTextTheme
                                                .textTheme.displayLarge
                                                ?.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColor.textblack),
                                            decoration: InputDecoration(
                                              hintText: "Type here",
                                              border: InputBorder
                                                  .none, // Removes the bottom line
                                              focusedBorder: InputBorder
                                                  .none, // Removes the bottom line when focused
                                              enabledBorder: InputBorder
                                                  .none, // Removes the bottom line when enabled
                                              errorBorder: InputBorder
                                                  .none, // Removes the bottom line when there's an error
                                              disabledBorder: InputBorder.none,
                                              hintStyle: AppTextTheme
                                                  .textTheme.displayLarge
                                                  ?.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColor.grey3),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Obx(
                                        () => homeController
                                                    .CancelMealLoading.value ==
                                                true
                                            ? Center(
                                                child: LoadingAnimationWidget
                                                    .discreteCircle(
                                                  size: 50,
                                                  color: AppColor.primary,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  print(
                                                      "meal true : ${homeController.Breakfast.value == false || homeController.Lunch.value == false || homeController.Dinner.value == false || homeController.Fullday.value == false}");
                                                  if (homeController
                                                      .selectedDay.isEmpty) {
                                                    Utils.showToast(
                                                      message:
                                                          "Please Selecte Date",
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      textColor: Colors.white,
                                                      fontsize: 16,
                                                    );
                                                  } else if (homeController
                                                              .Breakfast
                                                              .value ==
                                                          false &&
                                                      homeController
                                                              .Lunch.value ==
                                                          false &&
                                                      homeController
                                                              .Dinner.value ==
                                                          false &&
                                                      homeController
                                                              .Fullday.value ==
                                                          false &&
                                                      homeController
                                                              .heightea.value ==
                                                          false) {
                                                    Utils.showToast(
                                                      message:
                                                          "Please Selecte a Meal For Cancel.",
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      textColor: Colors.white,
                                                      fontsize: 16,
                                                    );
                                                  } else {
                                                    homeController.CancelMeal();
                                                  }
                                                },
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: AppColor
                                                              .lightpurple,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: Icon(
                                                    FeatherIcons.chevronRight,
                                                    color: AppColor.primary,
                                                    size: 20.h,
                                                  ),
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}

class MealContainer extends StatefulWidget {
  const MealContainer({super.key});

  @override
  _MealContainerState createState() => _MealContainerState();
}

class _MealContainerState extends State<MealContainer> {
  final HomeController homeController = Get.put(HomeController());
  List<String> selectedMeals = [];

  void selectMeal() {
    setState(() {
      homeController.Dinner(false);
      homeController.Lunch(false);
      homeController.Breakfast(false);
      homeController.heightea(false);
    });
  }

  void buttonselectMeal() {
    setState(() {
      homeController.Dinner.value == true &&
              homeController.Lunch.value == true &&
              homeController.Breakfast.value == true &&
              homeController.heightea.value == true
          ? {
              homeController.Fullday(true),
              homeController.Dinner(false),
              homeController.Lunch(false),
              homeController.Breakfast(false),
              homeController.heightea(false),
            }
          : homeController.Fullday(false);
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
                        homeController.Breakfast.value == true
                            ? homeController.Breakfast(false)
                            : homeController.Breakfast(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        homeController.Breakfast.value == true ? true : false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MealCard(
                    title: 'Lunch',
                    onTap: () {
                      setState(() {
                        homeController.Lunch.value == true
                            ? homeController.Lunch(false)
                            : homeController.Lunch(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        homeController.Lunch.value == true ? true : false,
                  ),
                ],
              ),
              Column(
                children: [
                  MealCard(
                    title: 'High-tea',
                    onTap: () {
                      setState(() {
                        homeController.heightea.value == true
                            ? homeController.heightea(false)
                            : homeController.heightea(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        homeController.heightea.value == true ? true : false,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MealCard(
                    title: 'Dinner',
                    onTap: () {
                      setState(() {
                        homeController.Dinner.value == true
                            ? homeController.Dinner(false)
                            : homeController.Dinner(true);
                        buttonselectMeal();
                      });
                    },
                    isSelected:
                        homeController.Dinner.value == true ? true : false,
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
                homeController.Fullday.value == true
                    ? {
                        homeController.Fullday(false),
                        selectMeal(),
                      }
                    : {
                        homeController.Fullday(true),
                        selectMeal(),
                      };
              });
            },
            isSelected: homeController.Fullday.value == true ? true : false,
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
                fontSize: 13,
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

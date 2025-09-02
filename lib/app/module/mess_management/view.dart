import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/mess_management/repository.dart';
import 'package:yoco_stay_student/app/module/mess_management/view/cancel_meal.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

import '../../core/theme/texttheme.dart';
import '../../core/values/colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custum_app_bar.dart';
import '../../widgets/stackbodysection.dart';

class MessManagmentPage extends StatefulWidget {
  const MessManagmentPage({super.key});

  @override
  State<MessManagmentPage> createState() => _MessManagmentPageState();
}

class _MessManagmentPageState extends State<MessManagmentPage> {
  final MessController messController = Get.put(MessController());
  final ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0.0;
  DateTime _focusedDay = DateTime.now();
  late DateTime lastDayOfMonth;
  DateTime now = DateTime.now();
  late int todayIndex;

  @override
  void initState() {
    super.initState();
    _lastScrollOffset = 0.0;
    messController.selectedDay = DateTime.now();
    messController.Selecteddate.text = "${DateTime.now()}";
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    messController.GetTodayMealData(DateTime.now());
    DateTime today = DateTime.now();
    todayIndex = today
        .difference(DateTime(_focusedDay.year, _focusedDay.month, 1))
        .inDays;

    // Scroll to today's date after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate(todayIndex);
    });
    // Add the scroll listener to the controller
  }

  // void _onScroll() {
  //   double offset = _scrollController.offset;

  //   // Calculate the scroll delta to determine the direction of scrolling
  //   double scrollDelta = offset - _lastScrollOffset;

  //   // If the user is scrolling right (forward)
  //   if (scrollDelta > 0) {
  //     setState(() {
  //       _focusedDay =
  //           _focusedDay.add(Duration(days: 7)); // Move one week forward
  //     });
  //   }
  //   // If the user is scrolling left (backward)
  //   else if (scrollDelta < 0) {
  //     setState(() {
  //       _focusedDay =
  //           _focusedDay.subtract(Duration(days: 7)); // Move one week backward
  //     });
  //   }

  //   // Update the last scroll offset
  //   _lastScrollOffset = offset;
  // }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        // title: "COMPLAINT MANAGEMENT",
        titlewidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/mess_managment/delicious-cartoon-style-food 1 (1).png",
              width: 50.w,
              height: 50.h,
            ),
            Text(
              "MESS MANAGEMENT",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        trailingwidget: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              width: 31.w,
              height: 31.h,
              decoration: BoxDecoration(
                color: AppColor.belliconbackround,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(const NotificationView());
                },
                child: const Icon(
                  CupertinoIcons.bell,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: stackcontainer(
              customheight: screenHeight * 0.8,
              NoBackgroundcolor: true,
              Shadow: false,
              writedata: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  InkWell(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _focusedDay,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != _focusedDay) {
                        setState(() {
                          _focusedDay = picked;
                          messController.selectedDay = picked;
                          messController.GetTodayMealData(picked);
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                DateFormat('MMM yyyy').format(_focusedDay),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                        color: AppColor.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              const Icon(
                                FeatherIcons.calendar,
                                size: 15,
                                color: AppColor.secondary,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70.h,
                    width: double
                        .infinity, // Ensure the ListView has a fixed height
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Previous month button
                        IconButton(
                          icon: const Icon(CupertinoIcons.chevron_back,
                              color: AppColor.primary),
                          onPressed: () {
                            setState(() {
                              // Move to the previous month
                              if (_focusedDay.month > 1) {
                                _focusedDay = DateTime(
                                    _focusedDay.year, _focusedDay.month - 1, 1);
                              } else {
                                // If it's January, go to December of the previous year
                                _focusedDay =
                                    DateTime(_focusedDay.year - 1, 12, 1);
                              }
                              lastDayOfMonth = DateTime(
                                  _focusedDay.year, _focusedDay.month + 1, 0);
                            });
                          },
                        ),

                        // Date ListView
                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
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
                                  DateTime(_focusedDay.year, _focusedDay.month,
                                          1)
                                      .add(Duration(days: index));
                              isSelected = messController.selectedDay.year ==
                                      date.year &&
                                  messController.selectedDay.year ==
                                      date.month &&
                                  messController.selectedDay.day == date.day;
                              if (isSelected) {
                                // Automatically scroll to the selected date
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _scrollToSelectedDate(index);
                                });
                              }

                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        messController.selectedDay = date;
                                        _scrollToSelectedDate(index);
                                      });
                                      messController.GetTodayMealData(date);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              messController.selectedDay.year ==
                                                          date.year &&
                                                      messController.selectedDay
                                                              .month ==
                                                          date.month &&
                                                      messController.selectedDay
                                                              .day ==
                                                          date.day
                                                  ? AppColor.primary
                                                  : Colors.transparent,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10.r),
                                            bottom: Radius.circular(5.r),
                                          )),
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 12),
                                      child: Column(
                                        children: [
                                          Text(
                                            date.day.toString(),
                                            style: AppTextTheme
                                                .textTheme.displayLarge
                                                ?.copyWith(
                                                    color: messController
                                                                    .selectedDay
                                                                    .year ==
                                                                date.year &&
                                                            messController
                                                                    .selectedDay
                                                                    .month ==
                                                                date.month &&
                                                            messController
                                                                    .selectedDay
                                                                    .day ==
                                                                date.day
                                                        ? AppColor.textwhite
                                                        : AppColor.primary,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 22),
                                          ),
                                          Text(
                                            DateFormat.E().format(date),
                                            style: AppTextTheme
                                                .textTheme.displayLarge
                                                ?.copyWith(
                                              fontSize: 14,
                                              color: messController.selectedDay
                                                              .year ==
                                                          date.year &&
                                                      messController.selectedDay
                                                              .month ==
                                                          date.month &&
                                                      messController.selectedDay
                                                              .day ==
                                                          date.day
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
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // Next month button
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
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 430.h,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // MessManagmentData(),
                            Obx(
                              () => messController.MealdataLoading.value == true
                                  ? const CustomShimmer()
                                  : Container(
                                      // height: 190.h,
                                      width: 340.w,
                                      decoration: BoxDecoration(
                                          color: AppColor.primary,
                                          borderRadius:
                                              BorderRadius.circular(20.r)),
                                      child: messController.todayMealData.value
                                                      .breakfast ==
                                                  null &&
                                              messController.todayMealData.value
                                                      .lunch ==
                                                  null &&
                                              messController.todayMealData.value
                                                      .snacks ==
                                                  null &&
                                              messController.todayMealData.value
                                                      .dinner ==
                                                  null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 80),
                                              child: Center(
                                                child: Text(
                                                  "Meals Not Added For This Day.",
                                                  style: AppTextTheme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                    color: AppColor.textwhite,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 25.w,
                                                  vertical: 20.h),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    // height: 190.h,
                                                    child: ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      // physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          4, // Assuming you have 3 items in your list
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 100.w,
                                                                  child: Text(
                                                                    index == 0
                                                                        ? "BREAKFAST:"
                                                                        : index ==
                                                                                1
                                                                            ? "LUNCH"
                                                                            : index == 2
                                                                                ? "SNACKS"
                                                                                : index == 3
                                                                                    ? "DINNER"
                                                                                    : "",
                                                                    style: AppTextTheme
                                                                        .textTheme
                                                                        .bodySmall
                                                                        ?.copyWith(
                                                                      color: AppColor
                                                                          .textwhite,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    index == 0
                                                                        ? messController.todayMealData.value.breakfast ??
                                                                            "Breakfast Not Added."
                                                                        : index ==
                                                                                1
                                                                            ? messController.todayMealData.value.lunch ??
                                                                                "Lunch Not Added"
                                                                            : index == 2
                                                                                ? messController.todayMealData.value.snacks ?? "Snacks Not Added"
                                                                                : index == 3
                                                                                    ? messController.todayMealData.value.dinner ?? "Dinner Not Added"
                                                                                    : "",
                                                                    style: AppTextTheme
                                                                        .textTheme
                                                                        .bodySmall
                                                                        ?.copyWith(
                                                                      color: AppColor
                                                                          .textwhite,
                                                                    ),
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10
                                                                  .h, // Adjust this for your desired spacing
                                                            ),
                                                            Divider(
                                                              height: 1.h,
                                                              color: AppColor
                                                                  .textwhite,
                                                            ),
                                                            SizedBox(
                                                              height: 10
                                                                  .h, // Adjust this for your desired spacing
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                    ),
                            ),
                            const SizedBox(height: 20.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "DID YOU KNOW?",
                                style: AppTextTheme.textTheme.displayLarge
                                    ?.copyWith(
                                  color: AppColor.grey3,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                decoration: const BoxDecoration(),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.asset(
                                    'assets/images/mess_managment/banner.png',
                                    scale: 1,
                                  ),
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
                            // CustomButton(
                            //   ontap: () {
                            //     // Get.to(MealFeedbackpage());
                            //     _showFeedBackDialog(context);
                            //   },
                            //   Title: '+ ADD FEEDBACK & SUGGETIONS',
                            //   borderColor: AppColor.grey7,
                            //   BoxColor: AppColor.white,
                            //   textcolor: AppColor.textblack,
                            // ),
                            CustomButton(
                              ontap: () {
                                // Get.to(BookedMealStatus());

                                Get.toNamed(AppRoute.MealStatusTab);
                              },
                              Title: '+ MEAL STATUS',
                              borderColor: AppColor.grey7,
                              BoxColor: AppColor.white,
                              textcolor: AppColor.textblack,
                            ),

                            // SizedBox(
                            //   height: 10.h,
                            // ),

                            (Utils.isSelectedDayisBefroTodayDate(
                                                messController.selectedDay) ==
                                            true ||
                                        Utils.isSelectedDayisSameAsTodayDate(
                                            messController.selectedDay)) &&
                                    Utils.isSelectedDayisBefroTodayDate(
                                        messController.selectedDay)
                                ? SizedBox(
                                    height: 10.h,
                                  )
                                : Container(),
                            (Utils.isSelectedDayisBefroTodayDate(
                                                messController.selectedDay) ==
                                            true ||
                                        Utils.isSelectedDayisSameAsTodayDate(
                                            messController.selectedDay)) &&
                                    Utils.isSelectedDayisBefroTodayDate(
                                        messController.selectedDay)
                                ? CustomButton(
                                    ontap: () async {
                                      DateTime firstDayOfMonth = DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          1);
                                      await messController.GetBookedData(
                                          firstDayOfMonth);
                                      Get.to(() => const CancelMealManagment());
                                      // Get.toNamed(AppRoute.MessPageCancel);
                                    },
                                    Title: '+ CANCEL MEAL',
                                    borderColor: AppColor.grey7,
                                    BoxColor: AppColor.white,
                                    textcolor: AppColor.textblack,
                                  )
                                : Container(),
                            SizedBox(
                              height: 10.h,
                            ),
                            // CustomButton(
                            //   ontap: () {
                            //     // Get.to(CancelMealStatus());

                            //     Get.toNamed(AppRoute.Canceltickets);
                            //   },
                            //   Title: '+ CANCELLED MEAL STATUS',
                            //   borderColor: AppColor.grey7,
                            //   BoxColor: AppColor.white,
                            //   textcolor: AppColor.textblack,
                            // ),

                            SizedBox(
                              height: 20.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: -15,
          //   child: Container(height: 100.h, child: CustomBottomNavbar()),
          // ),
        ],
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: CenterButton(),
      // bottomNavigationBar: BottomNavigation(),
    );
  }

  void _showFeedBackDialog(BuildContext context) {
    int textlenght = 0;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          content: Container(
            width: 340.w,
            height: 350.h,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "FEEDBACK",
                          style: AppTextTheme.textTheme.displayLarge?.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.grey3),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "How would you rate the quality of food served in the mess today?",
                          style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.textblack),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  width: 50,
                                  height: 50,
                                  scale: 2,
                                  "assets/images/mess_managment/Good.png",
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  "Good",
                                  style: AppTextTheme.textTheme.bodyLarge
                                      ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.textblack),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  width: 50,
                                  height: 50,
                                  scale: 2,
                                  "assets/images/mess_managment/Better.png",
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  "Good",
                                  style: AppTextTheme.textTheme.bodyLarge
                                      ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.textblack),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  width: 50,
                                  height: 50,
                                  scale: 2,
                                  "assets/images/mess_managment/Asset 1@4x 3.png",
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  "Good",
                                  style: AppTextTheme.textTheme.bodyLarge
                                      ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.textblack),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  scale: 3,
                                  width: 50,
                                  height: 50,
                                  "assets/images/mess_managment/Poor.png",
                                ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Text(
                                  "Good",
                                  style: AppTextTheme.textTheme.bodyLarge
                                      ?.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.textblack),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Overall, How satisfied are you with the mess management experience provided by YOCO Stays in February?",
                          style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.textblack),
                        ),
                        SizedBox(height: 10.h),
                        Center(
                          child: RatingBar(
                            initialRating: 3,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            ratingWidget: RatingWidget(
                              full: _image(
                                  'assets/images/mess_managment/Asset 1@4x 3.png'),
                              half: _image(
                                  'assets/images/mess_managment/Star5.png'),
                              empty: _image(
                                  'assets/images/mess_managment/Star5.png'),
                            ),
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reason",
                          style: AppTextTheme.textTheme.displayLarge?.copyWith(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.grey3),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 170.h,
                              child: TextField(
                                maxLength: 100,
                                maxLines: null,
                                onChanged: (value) {
                                  setState(() {
                                    textlenght = value as int;
                                  });
                                },
                                decoration: InputDecoration(
                                  counterText: "",
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: AppColor.textblack,
                                          fontWeight: FontWeight.w700),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: AppColor.textgrey,
                                          fontWeight: FontWeight.w700),
                                  hintText: 'Type here...',
                                  filled: true,
                                  fillColor: const Color(
                                      0xFFFFF4D8), // Background color
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 11.0,
                                      horizontal:
                                          20.0), // Padding inside the text field
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        30.0), // Rounded corners
                                    borderSide: BorderSide.none, // No border
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              height: 30.h,
                              width: 30.h,
                              decoration: const BoxDecoration(
                                  color: AppColor.lightpurple,
                                  shape: BoxShape.circle),
                              child: Icon(
                                FeatherIcons.chevronRight,
                                color: AppColor.primary,
                                size: 20.h,
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
        );
      },
    );
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 10.0,
      width: 10.0,
    );
  }
}

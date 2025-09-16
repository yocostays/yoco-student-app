import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';

import '../../../core/theme/texttheme.dart';
import '../../../core/values/colors.dart';
import '../../../widgets/custom_appbar_container.dart';
import '../model_class.dart';

class MealFeedbackpage extends StatefulWidget {
  const MealFeedbackpage({super.key});

  @override
  State<MealFeedbackpage> createState() => _MealFeedbackpageState();
}

class _MealFeedbackpageState extends State<MealFeedbackpage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomAppBarContainer(
            
            isMessManagement: true,
            title: "MESS MANAGEMENT",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    DateFormat('MMM yyyy').format(_focusedDay),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                            color: AppColor.primary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
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
                                    child: const Icon(
                                      FeatherIcons.calendar,
                                      size: 15,
                                      color: AppColor.primary,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
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
                                        style: AppTextTheme
                                            .textTheme.displayLarge
                                            ?.copyWith(
                                                color: _selectedDay == date
                                                    ? AppColor.textwhite
                                                    : AppColor.primary,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20.sp),
                                      ),
                                      Text(
                                        DateFormat.E().format(date),
                                        style: AppTextTheme
                                            .textTheme.displayLarge
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
                          height: 430.h,
                          child: Container(
                            // height: 190.h,
                            // width: 340.w,
                            decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 20.h),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 120.h,
                                    child: ListView.builder(
                                      // physics: NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.all(0),
                                      // physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: mealmenu
                                          .length, // Assuming you have 3 items in your list
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 100.w,
                                                  child: Text(
                                                    mealmenu[index].mealType,
                                                    style: AppTextTheme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                      color: AppColor.textwhite,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${mealmenu[index].items}",
                                                    style: AppTextTheme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                      color: AppColor.textwhite,
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
                                              color: AppColor.textwhite,
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
                        Positioned(
                          bottom: 0,
                          left: 0.w,
                          right: 0.w,
                          child: SizedBox(
                            width: 350.w,
                            child: Center(
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                              "FEEDBACK",
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
                                            Text(
                                              "How would you rate the quality of food served in the mess today?",
                                              style: AppTextTheme
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColor.textblack),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
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
                                                      style: AppTextTheme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColor
                                                                  .textblack),
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
                                                      style: AppTextTheme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColor
                                                                  .textblack),
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
                                                      style: AppTextTheme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColor
                                                                  .textblack),
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
                                                      style: AppTextTheme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColor
                                                                  .textblack),
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
                                              style: AppTextTheme
                                                  .textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color:
                                                          AppColor.textblack),
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
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                onRatingUpdate: (rating) {
                                                  print(rating);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
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
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                      color:
                                                          AppColor.lightyellow),
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.w,
                                                              vertical: 10.h),
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "Type here",
                                                          border: InputBorder
                                                              .none, // Removes the bottom line
                                                          focusedBorder: InputBorder
                                                              .none, // Removes the bottom line when focused
                                                          enabledBorder: InputBorder
                                                              .none, // Removes the bottom line when enabled
                                                          errorBorder: InputBorder
                                                              .none, // Removes the bottom line when there's an error
                                                          disabledBorder:
                                                              InputBorder.none,
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
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Container(
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
                      ],
                    ),
                  ],
                ),
              ),
            ]),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SizedBox(height: 100.h, child: const CustomBottomNavbar()),
        ),
      ],
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

class MealContainer extends StatefulWidget {
  const MealContainer({super.key});

  @override
  _MealContainerState createState() => _MealContainerState();
}

class _MealContainerState extends State<MealContainer> {
  List<String> selectedMeals = [];

  void selectMeal(String meal) {
    setState(() {
      if (meal == 'Full Day') {
        selectedMeals = ['Breakfast', 'Lunch', 'Dinner'];
      } else {
        if (selectedMeals.contains(meal)) {
          selectedMeals.remove(meal);
        } else {
          selectedMeals.add(meal);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 110.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MealCard(
                title: 'Breakfast',
                onTap: () => selectMeal('Breakfast'),
                isSelected: selectedMeals.contains('Breakfast'),
              ),
              MealCard(
                title: 'Lunch',
                onTap: () => selectMeal('Lunch'),
                isSelected: selectedMeals.contains('Lunch'),
              ),
              MealCard(
                title: 'Dinner',
                onTap: () => selectMeal('Dinner'),
                isSelected: selectedMeals.contains('Dinner'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          MealCard(
            width: double.infinity.w,
            title: 'Full Day',
            onTap: () {
              setState(() {
                selectedMeals = ['Breakfast', 'Lunch', 'Dinner'];
              });
            },
            isSelected: selectedMeals.contains('Breakfast') &&
                selectedMeals.contains('Lunch') &&
                selectedMeals.contains('Dinner'),
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
        width: widget.width ?? 85.w,
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

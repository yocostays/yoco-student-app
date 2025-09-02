// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/mess_management/repository.dart';
import 'package:yoco_stay_student/app/module/mess_management/widegts/mess_ticket.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

class BookedMealStatus extends StatefulWidget {
  const BookedMealStatus({super.key});

  @override
  State<BookedMealStatus> createState() => _BookedMealStatusState();
}

class _BookedMealStatusState extends State<BookedMealStatus> {
  final MessController messController = Get.put(MessController());
  // DateTime _focusedDay = DateTime.now();
  // DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    messController.GetBookedMealList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: CenterButton(),
      // bottomNavigationBar: BottomNavigation(),
      body: Column(
        children: [
          Container(
            height: 460.h,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [
                  BoxShadow(
                      color: AppColor.grey3, spreadRadius: 1, blurRadius: 1)
                ]),
            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Text(
                    "BOOKED MEAL STATUS",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColor.textgrey,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  width: 340.w,
                  height: 430.h,
                  child: Obx(
                    () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: messController.BookedTicketLoading.value == true
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return const Column(
                                    children: [
                                      CustomShimmer(
                                        height: 120,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  );
                                },
                              )
                            : messController.BookedTicketHistorydata.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 250),
                                      child: Text(
                                        "There no Booked Meal Data.",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: AppColor.primary,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: messController
                                        .BookedTicketHistorydata.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      String title = "";

                                      if (messController
                                              .BookedTicketHistorydata[index]
                                              .breakfast ==
                                          true) {
                                        title += "Breakfast";
                                      }

                                      if (messController
                                              .BookedTicketHistorydata[index]
                                              .lunch ==
                                          true) {
                                        if (title.isNotEmpty) {
                                          title += ", ";
                                        }
                                        title += "Lunch";
                                      }
                                      if (messController
                                              .BookedTicketHistorydata[index]
                                              .dinner ==
                                          true) {
                                        if (title.isNotEmpty) {
                                          title += ", ";
                                        }
                                        title += "Dinner";
                                      }
                                      if (messController
                                              .BookedTicketHistorydata[index]
                                              .snacks ==
                                          true) {
                                        if (title.isNotEmpty) {
                                          title += ", ";
                                        }
                                        title += "Snacks";
                                      }
                                      return Column(
                                        children: [
                                          Stack(
                                            children: [
                                              MessTicketCard(
                                                iconPath:
                                                    'assets/images/mess_managment/delicious-cartoon-style-food 1 (1).png',
                                                title: title,
                                                time: Utils.formatTimePass(
                                                    DateTime.parse(
                                                  messController
                                                          .BookedTicketHistorydata[
                                                              index]
                                                          .date ??
                                                      "2024-10-07",
                                                )),
                                                date: Utils
                                                    .formatSelectedDateYear(
                                                        DateTime.parse(
                                                  messController
                                                          .BookedTicketHistorydata[
                                                              index]
                                                          .date ??
                                                      "2024-10-0",
                                                )),
                                              ),
                                              // Positioned(
                                              //   right: 10,
                                              //   top: 0,
                                              //   child: messController
                                              //               .BookedTicketHistorydata[
                                              //                   index]
                                              //               .canUndoBooking ==
                                              //           false
                                              //       ? Container()
                                              //       : InkWell(
                                              //           onTap:
                                              //               () {
                                              //             setState(
                                              //                 () {
                                              //               _showLogoutDialog(
                                              //                   context,
                                              //                   messController.BookedTicketHistorydata[index].sId ?? "");
                                              //             });
                                              //           },
                                              //           child:
                                              //               Icon(
                                              //             Icons
                                              //                 .close,
                                              //             size:
                                              //                 25,
                                              //             weight:
                                              //                 20.sp,
                                              //             color: AppColor
                                              //                 .primary,
                                              //           ),
                                              //         ),
                                              // ),
                                              Positioned(
                                                right: 15,
                                                bottom: 5,
                                                child: messController
                                                            .BookedTicketHistorydata[
                                                                index]
                                                            .canUndoBooking ==
                                                        false
                                                    ? Container()
                                                    : CustomButton(
                                                        height: 25,
                                                        width: 40,
                                                        ontap: () {
                                                          setState(() {
                                                            messController
                                                                            .BookedTicketHistorydata[
                                                                                index]
                                                                            .dinner ==
                                                                        true &&
                                                                    messController
                                                                            .BookedTicketHistorydata[
                                                                                index]
                                                                            .lunch ==
                                                                        true &&
                                                                    messController
                                                                            .BookedTicketHistorydata[
                                                                                index]
                                                                            .snacks ==
                                                                        true &&
                                                                    messController
                                                                            .BookedTicketHistorydata[index]
                                                                            .breakfast ==
                                                                        true
                                                                ? {
                                                                    messController
                                                                        .EditFullday(
                                                                            true),
                                                                    messController
                                                                        .EditDinner(
                                                                            false),
                                                                    messController
                                                                        .EditBreakfast(
                                                                            false),
                                                                    messController
                                                                        .EditLunch(
                                                                            false),
                                                                    messController
                                                                        .Editheightea(
                                                                            false),
                                                                  }
                                                                : {
                                                                    messController.EditDinner(messController
                                                                        .BookedTicketHistorydata[
                                                                            index]
                                                                        .dinner),
                                                                    messController.EditBreakfast(messController
                                                                        .BookedTicketHistorydata[
                                                                            index]
                                                                        .breakfast),
                                                                    messController.EditLunch(messController
                                                                        .BookedTicketHistorydata[
                                                                            index]
                                                                        .lunch),
                                                                    messController.Editheightea(messController
                                                                        .BookedTicketHistorydata[
                                                                            index]
                                                                        .snacks),
                                                                    messController
                                                                        .EditFullday(
                                                                            false)
                                                                  };
                                                            messController
                                                                    .EditSelectedDate =
                                                                DateTime.tryParse(
                                                                    messController
                                                                            .BookedTicketHistorydata[index]
                                                                            .date ??
                                                                        "");
                                                            messController
                                                                    .EditTicketId
                                                                    .value =
                                                                messController
                                                                    .BookedTicketHistorydata[
                                                                        index]
                                                                    .sId!;
                                                            messController
                                                                .BookEditPage(
                                                                    true);
                                                          });
                                                          Get.toNamed(AppRoute
                                                              .EditTicketsPage);
                                                        },
                                                        Title: "EDIT"),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          )
                                        ],
                                      );
                                    },
                                  )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you Sure to Remove This Cancled Meal?",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColor.textblack,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            CustomButton(
              Title: "Yes",
              ontap: () async {
                messController.BookEditPage(true);
                messController.deleteticket(id);
              },
              width: 100.w,
              BoxColor: AppColor.primary,
              textcolor: AppColor.white,
              Textsize: 20,
            ),
            CustomButton(
              Title: "No",
              ontap: () {
                Get.back();
              },
              width: 100.w,
              BoxColor: AppColor.primary,
              textcolor: AppColor.white,
              Textsize: 20,
            ),
          ],
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

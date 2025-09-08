// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:yoco_stay_student/app/core/env.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/controller.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/model.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/widgets/ev_slot_inputtextfield.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/widgets/price_button.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/leave_status/widgets/selected_date.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class AmietiesFormPage extends StatefulWidget {
  const AmietiesFormPage({super.key});

  @override
  State<AmietiesFormPage> createState() => _AmietiesFormPageState();
}

class _AmietiesFormPageState extends State<AmietiesFormPage> {
  AmenitiesController Controller = Get.put(AmenitiesController());
  DateTime _focusedDay = DateTime.now();
  final List<DateTime?> _selectedDay = [];
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;

  @override
  void initState() {
    // _selectedDay = DateTime.now();
    super.initState();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  final List<String> purposes = [
    "Visiting Parents",
    "Medical Leave",
    "Emergency",
    "Family Function",
    "Vacation",
    "Festival",
    "Competitive Exam",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    TimeOfDay? StartTime;
    TimeOfDay? EndTime;
    return Scaffold(
      appBar: CustomAppBar(
        // title: "COMPLAINT MANAGEMENT",
        titlewidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              aminitiesItemslist[Controller.Selectedaminieties.value].imageName,
              width: 40.w,
              height: 50.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              child: Text(
                aminitiesItemslist[Controller.Selectedaminieties.value].title,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColor.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
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
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r))),
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
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
                            child: selecteddate(
                              date: DateFormat('MMM yyyy').format(_focusedDay),
                            )),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: List.generate(7, (index) {
                            //     DateTime date = _focusedDay.add(Duration(
                            //         days: index - _focusedDay.weekday + 1));
                            //     bool isSelected = _selectedDay == date;
                            //     return GestureDetector(
                            //       onTap: () {
                            //         // if sunday is nucluded then remove comment
                            //         // date.weekday == 7
                            //         //     ? 0
                            //         //     :
                            //         setState(() {
                            //           if (isSelected) {
                            //             _selectedDay = null;
                            //           } else {
                            //             _selectedDay = date;
                            //           }
                            //         });
                            //       },
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //             color: _selectedDay == date
                            //                 ? AppColor.white
                            //                 : Colors.transparent,
                            //             borderRadius: BorderRadius.vertical(
                            //               top: Radius.circular(10.r),
                            //               bottom: Radius.circular(10.r),
                            //             )),
                            //         padding: EdgeInsets.all(10.0),
                            //         child: Column(
                            //           children: [
                            //             Text(
                            //               DateFormat.E().format(date),
                            //               style: AppTextTheme
                            //                   .textTheme.displayLarge
                            //                   ?.copyWith(
                            //                 fontSize: 12.sp,
                            //                 color: _selectedDay == date
                            //                     ? AppColor.primary
                            //                     : AppColor.white,
                            //               ),
                            //             ),
                            //             Text(
                            //               date.day.toString(),
                            //               style: AppTextTheme
                            //                   .textTheme.displayLarge
                            //                   ?.copyWith(
                            //                       color: _selectedDay == date
                            //                           ? AppColor.primary
                            //                           : AppColor.white,
                            //                       fontWeight: FontWeight.w700,
                            //                       fontSize: 15.sp),
                            //             ),
                            //             // SizedBox(
                            //             //   height: 15.h,
                            //             // )
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   }),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: 320.w,
                                height:
                                    70.0, // Ensure the ListView has a fixed height
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  // controller: _scrollController,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: lastDayOfMonth.day,
                                  itemBuilder: (context, index) {
                                    DateTime date = _focusedDay.add(Duration(
                                        days: index - _focusedDay.day + 1));
                                    bool isSelected =
                                        _selectedDay.contains(date);
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            _selectedDay.remove(date);
                                          } else {
                                            _selectedDay.add(date);
                                          }
                                          // _selectedDay.isEmpty == true
                                          //     ? {
                                          //         _leavecontroller
                                          //             .selectDaterang
                                          //             .clear(),
                                          //         _leavecontroller.totaldate
                                          //             .clear(),
                                          //       }
                                          //     : _leavecontroller
                                          //             .selectDaterang.text =
                                          //         _leavecontroller
                                          //             .formatDateRange(
                                          //                 _selectedDay.first ??
                                          //                     DateTime.now(),
                                          //                 _selectedDay.last ??
                                          //                     DateTime.now());
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColor.white
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              DateFormat.E().format(date),
                                              style: AppTextTheme
                                                  .textTheme.displayLarge
                                                  ?.copyWith(
                                                fontSize: 14.0,
                                                color: isSelected
                                                    ? AppColor.primary
                                                    : AppColor.white,
                                              ),
                                            ),
                                            Text(
                                              date.day.toString(),
                                              style: AppTextTheme
                                                  .textTheme.displayLarge
                                                  ?.copyWith(
                                                      color: isSelected
                                                          ? AppColor.primary
                                                          : AppColor.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  aminitiesItemslist[Controller.Selectedaminieties.value].id ==
                          1
                      ? Container()
                      : aminitiesItemslist[Controller.Selectedaminieties.value]
                                  .id ==
                              1
                          ? Container()
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "TIME SLOT",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            // color: AppColor.grey3,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5,
                                            letterSpacing: 0.8),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          height: 32.h,
                                          child: Ev_Slot_Custom_textfield(
                                            Ontab: () async => {
                                              StartTime = await showTimePicker(
                                                helpText: "Select Start Time",
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                false),
                                                    child: child!,
                                                  );
                                                },
                                              ),
                                              StartTime != null
                                                  ? EndTime =
                                                      await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      helpText:
                                                          "Select End Time",
                                                      builder:
                                                          (BuildContext context,
                                                              Widget? child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      false),
                                                          child: child!,
                                                        );
                                                      },
                                                    )
                                                  : 0,
                                              StartTime == null &&
                                                      EndTime == null
                                                  ? 0
                                                  : {
                                                      setState(() {
                                                        Controller.firstTimeSlot
                                                                .text =
                                                            Controller
                                                                .formatTimeRange(
                                                                    context,
                                                                    StartTime,
                                                                    EndTime);
                                                      }),
                                                    },
                                            },
                                            textinputdiseble: true,
                                            textcenter: false,
                                            boxColor: AppColor.grey6,
                                            hinttextstyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: AppColor.textgrey,
                                                    fontWeight:
                                                        FontWeight.w700),
                                            textstyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: AppColor.textblack,
                                                    fontWeight:
                                                        FontWeight.w700),
                                            TextController:
                                                Controller.firstTimeSlot,
                                            hint: 'Enter Time Slot',
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          height: 32.h,
                                          child: Ev_Slot_Custom_textfield(
                                            Ontab: () async => {
                                              StartTime = await showTimePicker(
                                                helpText: "Select Start Time",
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                false),
                                                    child: child!,
                                                  );
                                                },
                                              ),
                                              StartTime != null
                                                  ? EndTime =
                                                      await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      helpText:
                                                          "Select End Time",
                                                      builder:
                                                          (BuildContext context,
                                                              Widget? child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      false),
                                                          child: child!,
                                                        );
                                                      },
                                                    )
                                                  : 0,
                                              StartTime == null &&
                                                      EndTime == null
                                                  ? 0
                                                  : {
                                                      setState(() {
                                                        Controller
                                                                .secondTimeSlot
                                                                .text =
                                                            Controller
                                                                .formatTimeRange(
                                                                    context,
                                                                    StartTime,
                                                                    EndTime);
                                                      }),
                                                    },
                                            },
                                            textinputdiseble: true,
                                            boxColor: AppColor.grey6,
                                            textcenter: false,
                                            hinttextstyle: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: AppColor.grey3,
                                                    fontWeight:
                                                        FontWeight.w700),
                                            TextController:
                                                Controller.secondTimeSlot,
                                            hint: 'Enter Time Slot',
                                          ),
                                        ),

                                        // TextFields(
                                        //   paddinghorizontal: screenwidth * 0.03,
                                        //   name: "06:00 AM - 09:00 AM",
                                        //   fontSize: screenwidth * 0.035,
                                        // ),
                                        // TextFields(
                                        //   paddinghorizontal: screenwidth * 0.03,
                                        //   fontSize: screenwidth * 0.035,
                                        //   name: "06:00 AM - 09:00 AM",
                                        // )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                  aminitiesItemslist[Controller.Selectedaminieties.value].id ==
                          1
                      ? Container()
                      : aminitiesItemslist[Controller.Selectedaminieties.value]
                                  .id ==
                              1
                          ? Container()
                          : SizedBox(
                              height: 20.h,
                            ),
                  aminitiesItemslist[Controller.Selectedaminieties.value].id ==
                          1
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Obx(
                            () => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NUMBER OF STUDENTS",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          // color: AppColor.grey3,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                          letterSpacing: 0.8),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Controller.minusbutton(true);
                                          Controller.plusbutton(false);
                                          Controller.nubmerofstudent.value == 0
                                              ? 0
                                              : Controller
                                                  .nubmerofstudent.value -= 1;
                                        },
                                        child: Controller.minusbutton == true
                                            ? TextFields(
                                                paddinghorizontal:
                                                    screenwidth * 0.12,
                                                fontSize: screenwidth * 0.04,
                                                boxcolor: AppColor.primary,
                                                textColor: AppColor.white,
                                                name: "-",
                                              )
                                            : TextFields(
                                                paddinghorizontal:
                                                    screenwidth * 0.12,
                                                fontSize: screenwidth * 0.04,
                                                name: "-",
                                              ),
                                      ),
                                      TextFields(
                                        paddinghorizontal: screenwidth * 0.07,
                                        fontSize: screenwidth * 0.04,
                                        name:
                                            "    ${Controller.nubmerofstudent.value}    ",
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Controller.minusbutton(false);
                                          Controller.plusbutton(true);
                                          Controller.nubmerofstudent.value += 1;
                                        },
                                        child: Controller.plusbutton == true
                                            ? TextFields(
                                                paddinghorizontal:
                                                    screenwidth * 0.12,
                                                fontSize: screenwidth * 0.04,
                                                boxcolor: AppColor.primary,
                                                textColor: AppColor.white,
                                                name: "+",
                                              )
                                            : TextFields(
                                                paddinghorizontal:
                                                    screenwidth * 0.12,
                                                fontSize: screenwidth * 0.04,
                                                name: "+",
                                              ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                  aminitiesItemslist[Controller.Selectedaminieties.value].id ==
                          1
                      ? Container()
                      : SizedBox(
                          height: 10.h,
                        ),
                  aminitiesItemslist[Controller.Selectedaminieties.value].id ==
                          1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: laundyitems.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 40,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  CustomCard(
                                    image: laundyitems[index].imageName,
                                    name: laundyitems[index].title,
                                    quanty: laundyitems[index].Quntity,
                                    incresce: () {
                                      setState(() {
                                        Controller.minusbutton(false);
                                        Controller.plusbutton(true);
                                        laundyitems[index].Quntity += 1;
                                      });
                                    },
                                    decrease: () {
                                      setState(() {
                                        Controller.minusbutton(true);
                                        Controller.plusbutton(false);
                                        laundyitems[index].Quntity == 0
                                            ? 0
                                            : laundyitems[index].Quntity -= 1;
                                      });
                                    },
                                  ),
                                  FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(laundyitems[index].title))
                                ],
                              );
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height:
                        aminitiesItemslist[Controller.Selectedaminieties.value]
                                    .id ==
                                1
                            ? 50
                            : 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AVAILABILITY STATUS",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  // color: AppColor.grey3,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                  letterSpacing: 0.8),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40.h,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: avalbelitme.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      avalbelitme[index].status == true
                                          ? selected(
                                              name: avalbelitme[index].title,
                                            )
                                          : notselected(
                                              name: avalbelitme[index].title,
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            aminitiesItemslist[Controller.Selectedaminieties.value].id != 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      // height: 76.h,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black.withOpacity(0.1),
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                                offset: const Offset(1, -1))
                          ]),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: CustomButton(
                        ontap: () {},
                        Title: 'Book Now',
                        Textsize: 15,
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: EminitiesContainerButton(),
                  ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

class selected extends StatelessWidget {
  final String name;
  const selected({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding:
          EdgeInsets.symmetric(horizontal: screenwidth * 0.05, vertical: 0.0),
      decoration: BoxDecoration(
        color: AppColor.yellow3,
        borderRadius: BorderRadius.circular(20.0),
        // boxShadow: [
        //   // BoxShadow(
        //   //   color: AppColor.primary, // Shadow color
        //   //   spreadRadius: 0,
        //   //   blurRadius: 3,
        //   //   offset: Offset(-1, -2), // Shadow position
        //   // ),
        //   // BoxShadow(
        //   //   color: AppColor.black
        //   //       .withOpacity(0.2), // Shadow color
        //   //   spreadRadius: 0,
        //   //   blurRadius: 3,
        //   //   offset: Offset(1, 2), // Shadow position
        //   // )
        // ],
      ),
      child: Center(
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColor.white,
                fontSize: screenwidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class notselected extends StatelessWidget {
  final String name;
  const notselected({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      padding:
          EdgeInsets.symmetric(horizontal: screenwidth * 0.05, vertical: 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          const BoxShadow(
            color: AppColor.primary, // Shadow color
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(-1, -2), // Shadow position
          ),
          BoxShadow(
            color: AppColor.black.withOpacity(0.2), // Shadow color
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(1, 2), // Shadow position
          )
        ],
      ),
      child: Center(
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColor.textgrey,
                fontSize: screenwidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final String name;
  final Color? boxcolor;
  final Color? textColor;
  final double? paddinghorizontal;
  final double? paddingvertical;
  final double? fontSize;
  const TextFields({
    super.key,
    required this.name,
    this.boxcolor,
    this.textColor,
    this.paddinghorizontal,
    this.paddingvertical,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: paddinghorizontal ?? 25.0,
          vertical: paddingvertical ?? 10.0),
      decoration: BoxDecoration(
        color: boxcolor ?? AppColor.grey6,
        borderRadius: BorderRadius.circular(20.0),
        // boxShadow: [
        //   // BoxShadow(
        //   //   color: AppColor.primary, // Shadow color
        //   //   spreadRadius: 0,
        //   //   blurRadius: 3,
        //   //   offset: Offset(-1, -2), // Shadow position
        //   // ),
        //   // BoxShadow(
        //   //   color: AppColor.black
        //   //       .withOpacity(0.2), // Shadow color
        //   //   spreadRadius: 0,
        //   //   blurRadius: 3,
        //   //   offset: Offset(1, 2), // Shadow position
        //   // )
        // ],
      ),
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: textColor ?? AppColor.textblack,
              fontSize: fontSize ?? 13,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String image;
  final String name;
  final int quanty;
  final Function() incresce;
  final Function() decrease;

  CustomCard({
    super.key,
    required this.image,
    required this.name,
    required this.quanty,
    required this.incresce,
    required this.decrease,
  });
  final AmenitiesController Controller = Get.put(AmenitiesController());

  final int quantity = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Stack(
        children: [
          Container(
            // width: 140,
            // height: 160,
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      image,
                      scale: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '₹15',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Per piece',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 0,
            bottom: 0,
            child: Stack(
              children: [
                Container(
                  width: 30.w,
                  height: 100.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      // topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(5),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$quanty",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -15,
                  right: 0,
                  left: -2,
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                    ),
                    onPressed: incresce,
                    // onPressed: () {
                    //   Controller.minusbutton(false);
                    //   Controller.plusbutton(true);
                    //   Controller.nubmerofstudent.value += 1;
                    // },
                    color: Colors.purple,
                  ),
                ),
                Positioned(
                  bottom: -15,
                  right: 0,
                  left: -2,
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove,
                      size: 20,
                    ),
                    onPressed: decrease,
                    // onPressed: () {
                    //   print("hjdbsfkjn");
                    //   Controller.minusbutton(true);
                    //   Controller.plusbutton(false);
                    //   Controller.nubmerofstudent.value == 0
                    //       ? 0
                    //       : Controller.nubmerofstudent.value -= 1;
                    // },
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/controller/ve_slot_controller.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/model/ev_model.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/widgets/custom_price_section.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/widgets/ev_slot_inputtextfield.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

// ignore: must_be_immutable
class EvSlotBookingForm extends StatelessWidget {
  final EvSlotController EvController = Get.put(EvSlotController());
  final fruitDropdownController = DropdownController();

  EvSlotBookingForm({super.key});

  String formatTimeRange(
      BuildContext context, TimeOfDay? startTime, TimeOfDay? endTime) {
    if (startTime == null || endTime == null) return '';

    final duration = calculateDuration(startTime, endTime);

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    EvController.Noofhours.text =
        '$hours : ${minutes <= 9 ? "0$minutes" : minutes} ';
    final localizations = MaterialLocalizations.of(context);

    final startFormatted =
        localizations.formatTimeOfDay(startTime, alwaysUse24HourFormat: false);
    final endFormatted =
        localizations.formatTimeOfDay(endTime, alwaysUse24HourFormat: false);

    return '$startFormatted - $endFormatted';
  }

  Duration calculateDuration(TimeOfDay startTime, TimeOfDay endTime) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    // If end time is before start time, assume it's on the next day
    final difference = (endMinutes - startMinutes + 1440) % 1440;

    return Duration(minutes: difference);
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: "Booking Date",
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      EvController.Boolingdate.text =
          Utils.formatSelectedDateYear(selectedDate);
    }
  }

  final int selected = 4;

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
              Evitems[EvController.Selectebooking.value - 1].imageName,
              width: 50.w,
              height: 50.h,
            ),
            Text(
              Evitems[EvController.Selectebooking.value - 1].title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.white,
                  fontSize: 15,
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: stackcontainer(
          NoBackgroundcolor: false,
          writedata: Column(
            children: [
              SizedBox(
                height: 500.h,
                child: SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "BOOKING DATE",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.grey3,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                      letterSpacing: 0.8),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Icon(
                              FeatherIcons.calendar,
                              size: 15,
                              color: AppColor.primary,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InkWell(
                          onTap: () async {
                            _selectDate(context);
                          },
                          child: Ev_Slot_Custom_textfield(
                            textfiled: false,
                            TextController: EvController.Boolingdate,
                            hint: 'Selecte Date',
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SELECT TIME RANGE",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.grey3,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                      letterSpacing: 0.8),
                            ),
                            Text(
                              "NO. OF HOURS",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.grey3,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                      letterSpacing: 0.8),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 192.w,
                              height: 32.h,
                              child: InkWell(
                                onTap: () async => {
                                  StartTime = await showTimePicker(
                                    helpText: "Select Start Time",
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: false),
                                        child: child!,
                                      );
                                    },
                                  ),
                                  StartTime != null
                                      ? EndTime = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          helpText: "Select End Time",
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
                                        )
                                      : 0,
                                  StartTime == null && EndTime == null
                                      ? 0
                                      : EvController.TimeRange.text =
                                          formatTimeRange(
                                              context, StartTime, EndTime),
                                },
                                child: Ev_Slot_Custom_textfield(
                                  textfiled: false,
                                  textstyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: AppColor.textblack,
                                          fontWeight: FontWeight.w700),
                                  perfixiconwidget: const Icon(
                                    FeatherIcons.clock,
                                    color: AppColor.primary,
                                  ),
                                  TextController: EvController.TimeRange,
                                  hint: 'Time Range',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 85.w,
                              height: 32.h,
                              child: Ev_Slot_Custom_textfield(
                                textfiled: false,
                                TextController: EvController.Noofhours,
                                hint: 'Hours',
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "VEHICLE NUMBER",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppColor.grey3,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                  letterSpacing: 0.8),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Ev_Slot_Custom_textfield(
                          TextController: EvController.vehiclenumber,
                          hint: 'Vehicle Number',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "MODEL/COMPANY",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppColor.grey3,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                  letterSpacing: 0.8),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Ev_Slot_Custom_textfield(
                          TextController: EvController.model,
                          hint: 'Vehicle Name',
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Parking Slot",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.textblack,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                      letterSpacing: 0.8),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // gradient: LinearGradient(
                                //   colors: [
                                //     AppColor.textprimary,
                                //     AppColor.white
                                //   ], // Define your gradient colors here
                                // ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: AppColor.textprimary,
                                      blurRadius: 0,
                                      spreadRadius: 0,
                                      offset: Offset(0.1, -1)),
                                  // BoxShadow(
                                  //     color: AppColor.white,
                                  //     blurRadius: 0,
                                  //     spreadRadius: 0,
                                  //     offset: Offset(-1, 1)),
                                ],
                                borderRadius: BorderRadius.circular(16
                                    .r), // Same border radius as the text field
                              ),
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                width: 100.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColor.black.withOpacity(0.4),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 0)),
                                  ], // Same border radius as the text field
                                ),
                                child: DropDownTextField(
                                  onChanged: (value) {
                                    print("heloo $value");
                                  },
                                  textFieldDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 4),
                                    hintText: "Location",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: AppColor.grey3,
                                            fontWeight: FontWeight.w700,
                                            height: 1.5,
                                            letterSpacing: 0.8),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w700,
                                            height: 1.5,
                                            letterSpacing: 0.8),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                        borderSide: BorderSide.none),
                                  ),
                                  searchDecoration: InputDecoration(
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w700,
                                            height: 1.5,
                                            letterSpacing: 0.8),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color: AppColor.black,
                                            fontWeight: FontWeight.normal,
                                            height: 1.5,
                                            letterSpacing: 0.8),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  dropDownList: const [
                                    DropDownValueModel(
                                        name: 'Korba', value: "value1"),
                                    DropDownValueModel(
                                        name: 'Bilaspur', value: "value2"),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 100.h,
                          child: GridView.builder(
                            itemCount: 10,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.3,
                              mainAxisSpacing: 1,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(
                                () => Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        EvController.selectedindex.value =
                                            index + 1;
                                        print("hellojfdkfj");
                                      },
                                      child: Container(
                                        // height: 10.h,
                                        // width: 10.w,
                                        decoration: BoxDecoration(
                                          color: EvController.selected.value ==
                                                  index + 1
                                              ? AppColor.secondary
                                                  .withOpacity(0.1)
                                              : EvController.selectedindex
                                                          .value ==
                                                      index + 1
                                                  ? AppColor.primary
                                                  : AppColor.primary
                                                      .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 15),
                                        child: Center(
                                          child: Text(
                                            "${index + 1}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                  color: EvController
                                                              .selected.value ==
                                                          index + 1
                                                      ? AppColor.secondary
                                                      : EvController
                                                                  .selectedindex
                                                                  .value ==
                                                              index + 1
                                                          ? AppColor.white
                                                          : AppColor.textblack,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 1.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(-1, -2), // changes position of shadow
                      ),
                    ]),
              ),
              const PriceContainerButton()
            ],
          ),
        ),
      ),
    );
  }
}

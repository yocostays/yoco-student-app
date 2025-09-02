import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/widgets/ev_slot_inputtextfield.dart';
import 'package:yoco_stay_student/app/module/get_pass/repository.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/input_text_widgets.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class PassFromPage extends StatefulWidget {
  const PassFromPage({super.key});

  @override
  State<PassFromPage> createState() => _PassFromPageState();
}

class _PassFromPageState extends State<PassFromPage> {
  GetPassController getpasscontroller = Get.put(GetPassController());
  final ScrollController _scrollController = ScrollController();
  late int todayIndex;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  // String? _selectedPurpose;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;

  final List<String> purposes = [
    "Local Shops",
    "City Visit",
    "Worship",
    "Medical Appointment",
    "Local Guardian",
    "Other",
  ];

  @override
  void initState() {
    super.initState();
    getpasscontroller.GetCategoryListdata("day out");
    getpasscontroller.Cleardata();
    _selectedDay = DateTime.now();
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    todayIndex = DateTime.now()
        .difference(DateTime(_focusedDay.year, _focusedDay.month, 1))
        .inDays;

    // Scroll to today's date after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate(todayIndex);
    });
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

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    TimeOfDay? StartTime;
    TimeOfDay? EndTime;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Obx(
              () => CustomButton(
                ontap: getpasscontroller.DayOutCreating.value
                    ? () {}
                    : () {
                        if (getpasscontroller.StartTime == null &&
                            getpasscontroller.EndTime == null &&
                            getpasscontroller.DayoutCetegory.text.isEmpty &&
                            getpasscontroller.discription.text.isEmpty) {
                          Utils.showToast(
                            message:
                                "Date, Timing, Purpose, Description is Required.",
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.white,
                            fontsize: 16,
                          );
                        } else if (getpasscontroller
                            .contactnumber.text.isNotEmpty) {
                          print("sdf ${getpasscontroller.contactnumber.text}");
                          getpasscontroller.contactnumber.text.length >= 10
                              ? getpasscontroller.SubmitLeaveApplication()
                              : Utils.showToast(
                                  message:
                                      "Visiter Phone Number Must be 10 Digit.",
                                  gravity: ToastGravity.CENTER,
                                  textColor: Colors.white,
                                  fontsize: 16,
                                );
                        } else {
                          getpasscontroller.SubmitLeaveApplication();
                        }
                      },
                Title: 'Send For Approval',
                Textsize: 15,
                isloaging: getpasscontroller.DayOutCreating.value,
                BoxColor: getpasscontroller.DayOutCreating.value
                    ? AppColor.white
                    : null,
              ),
            )),
      ),
      appBar: CustomAppBar(
          titlewidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                getpasscontroller.getpasstabController.index == 0
                    ? "assets/images/get_pass/Student app_Icon-04 2.png"
                    : "assets/images/get_pass/6306475 1.png",
                width: 50.w,
                height: 50.h,
              ),
              Text(
                getpasscontroller.getpasstabController.index == 0
                    ? "DAY OUT/NIGHT OUT"
                    : "VISITORS MANAGMENT",
                //"visitors management",
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
          ]),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: getpasscontroller.getpasstabController.index == 0
            ? Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: SingleChildScrollView(
                        // physics: NeverScrollableScrollPhysics(),
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
                                  // SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            DateTime? picked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: _focusedDay,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2101),
                                            );
                                            if (picked != null &&
                                                picked != _focusedDay) {
                                              setState(() {
                                                _focusedDay = picked;
                                              });
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                DateFormat('MMM yyyy')
                                                    .format(_focusedDay),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge
                                                    ?.copyWith(
                                                        color: AppColor.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                        GestureDetector(
                                          onTap: () async {
                                            DateTime? picked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: _focusedDay,
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2101),
                                            );
                                            if (picked != null &&
                                                picked != _focusedDay) {
                                              setState(() {
                                                _focusedDay = picked;
                                              });
                                            }
                                          },
                                          child: Text(
                                            "Select date",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: AppColor.grey3,
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                            CupertinoIcons.chevron_back,
                                            color: AppColor.white),
                                        onPressed: () {
                                          setState(() {
                                            // Move to the previous month
                                            if (_focusedDay.month > 1) {
                                              _focusedDay = DateTime(
                                                  _focusedDay.year,
                                                  _focusedDay.month - 1,
                                                  1);
                                            } else {
                                              // If it's January, go to December of the previous year
                                              _focusedDay = DateTime(
                                                  _focusedDay.year - 1, 12, 1);
                                            }
                                            lastDayOfMonth = DateTime(
                                                _focusedDay.year,
                                                _focusedDay.month + 1,
                                                0);
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        height: 65.h,
                                        child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          controller: _scrollController,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: lastDayOfMonth.day,
                                          itemBuilder: (context, index) {
                                            DateTime date =
                                                // _focusedDay.month ==
                                                //             DateTime.now().month &&
                                                //         _focusedDay.year ==
                                                //             DateTime.now().year
                                                //     ? DateTime.now()
                                                //         .add(Duration(days: index))
                                                //     :
                                                DateTime(_focusedDay.year,
                                                        _focusedDay.month, 1)
                                                    .add(Duration(days: index));
                                            bool isSelected =
                                                _selectedDay!.day == date.day &&
                                                    _selectedDay!.month ==
                                                        date.month &&
                                                    _selectedDay!.year ==
                                                        date.year;

                                            if (isSelected) {
                                              // Automatically scroll to the selected date
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                _scrollToSelectedDate(index);
                                              });
                                            }

                                            return GestureDetector(
                                              onTap: () {
                                                date.isAfter(DateTime.now()) ||
                                                        isSameDay(date,
                                                            DateTime.now())
                                                    ? _selectedDay == date
                                                        ? setState(() {
                                                            _selectedDay = null;
                                                          })
                                                        : setState(() {
                                                            _scrollToSelectedDate(
                                                                index);
                                                            _selectedDay = date;
                                                          })
                                                    : Utils.showToast(
                                                        message:
                                                            "You Can't Select Back Date!",
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeduration: 1,
                                                        toastlength:
                                                            Toast.LENGTH_SHORT,
                                                        textColor: Colors.white,
                                                        fontsize: 16,
                                                      );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? AppColor.white
                                                      : Utils.isSelectedDayisSameAsTodayDate(
                                                              date)
                                                          ? AppColor.secondary
                                                          : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      DateFormat.E()
                                                          .format(date),
                                                      style: AppTextTheme
                                                          .textTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                        fontSize: 16,
                                                        color: isSelected
                                                            ? AppColor.primary
                                                            : Utils.isSelectedDayisSameAsTodayDate(
                                                                    date)
                                                                ? AppColor
                                                                    .primary
                                                                : AppColor
                                                                    .white,
                                                      ),
                                                    ),
                                                    Text(
                                                      date.day.toString(),
                                                      style: AppTextTheme
                                                          .textTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                        color: isSelected
                                                            ? AppColor.primary
                                                            : Utils.isSelectedDayisSameAsTodayDate(
                                                                    date)
                                                                ? AppColor
                                                                    .primary
                                                                : AppColor
                                                                    .white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        //  SingleChildScrollView(
                                        //   scrollDirection: Axis.horizontal,
                                        //   physics: const ClampingScrollPhysics(),
                                        //   child:

                                        //       Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.spaceBetween,
                                        //     children: List.generate(
                                        //         lastDayOfMonth.month ==
                                        //                     DateTime.now()
                                        //                         .month &&
                                        //                 lastDayOfMonth.year ==
                                        //                     DateTime.now().year
                                        //             ? lastDayOfMonth.day -
                                        //                 now.day +
                                        //                 1
                                        //             : lastDayOfMonth.day,
                                        //         (index) {
                                        //       DateTime date = _focusedDay.month ==
                                        //                   DateTime.now().month &&
                                        //               _focusedDay.year ==
                                        //                   DateTime.now().year
                                        //           ? DateTime.now()
                                        //               .add(Duration(days: index))
                                        //           : DateTime(_focusedDay.year,
                                        //                   _focusedDay.month, 1)
                                        //               .add(Duration(days: index));
                                        //       bool isSelected =
                                        //           _selectedDay!.day == date.day &&
                                        //               _selectedDay!.month ==
                                        //                   date.month &&
                                        //               _selectedDay!.year ==
                                        //                   date.year;

                                        //       return GestureDetector(
                                        //         onTap: () {
                                        //           date.isAfter(DateTime.now()) ||
                                        //                   isSameDay(date,
                                        //                       DateTime.now())
                                        //               ? _selectedDay == date
                                        //                   ? setState(() {
                                        //                       _selectedDay = null;
                                        //                     })
                                        //                   : setState(() {
                                        //                       _selectedDay = date;
                                        //                     })
                                        //               : Utils.showToast(
                                        //                   message:
                                        //                       "You Can't Select Back Date!",
                                        //                   gravity:
                                        //                       ToastGravity.CENTER,
                                        //                   timeduration: 1,
                                        //                   toastlength:
                                        //                       Toast.LENGTH_SHORT,
                                        //                   textColor: Colors.white,
                                        //                   fontsize: 16,
                                        //                 );
                                        //         },
                                        //         child: Container(
                                        //           decoration: BoxDecoration(
                                        //             color: isSelected
                                        //                 ? AppColor.white
                                        //                 : Colors.transparent,
                                        //             borderRadius:
                                        //                 BorderRadius.circular(
                                        //                     20.0),
                                        //           ),
                                        //           padding: EdgeInsets.all(10.0),
                                        //           child: Column(
                                        //             children: [
                                        //               Text(
                                        //                 DateFormat.E()
                                        //                     .format(date),
                                        //                 style: AppTextTheme
                                        //                     .textTheme
                                        //                     .displayLarge
                                        //                     ?.copyWith(
                                        //                   fontSize: 16,
                                        //                   color: isSelected
                                        //                       ? AppColor.primary
                                        //                       : AppColor.white,
                                        //                 ),
                                        //               ),
                                        //               Text(
                                        //                 date.day.toString(),
                                        //                 style: AppTextTheme
                                        //                     .textTheme
                                        //                     .displayLarge
                                        //                     ?.copyWith(
                                        //                   color: isSelected
                                        //                       ? AppColor.primary
                                        //                       : AppColor.white,
                                        //                   fontWeight:
                                        //                       FontWeight.w700,
                                        //                   fontSize: 16,
                                        //                 ),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       );

                                        //     }),
                                        //   ),

                                        // ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            CupertinoIcons.chevron_forward,
                                            color: AppColor.white),
                                        onPressed: () {
                                          setState(() {
                                            // Move to the next month
                                            _focusedDay = DateTime(
                                                _focusedDay.year,
                                                _focusedDay.month + 1,
                                                1);
                                            lastDayOfMonth = DateTime(
                                                _focusedDay.year,
                                                _focusedDay.month + 1,
                                                0);
                                          });
                                        },
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
                              height: 10.h,
                            ),
                            Container(
                                // height: MediaQuery.of(context).size.height * 0.63,
                                child: SelecteTimeRange(
                                    context, StartTime, EndTime)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : visitor_managment(),
      ),
    );
  }

  Padding SelecteTimeRange(
      BuildContext context, TimeOfDay? StartTime, TimeOfDay? EndTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SELECT TIME RANGE*",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.grey3,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 0.8),
                  ),
                  Text(
                    "NO. OF HOURS",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                        print("selected date : $_selectedDay"),
                        _selectedDay == null
                            ? Utils.showToast(
                                message: "please Selected date First.",
                                gravity: ToastGravity.CENTER,
                                timeduration: 1,
                                toastlength: Toast.LENGTH_SHORT,
                                textColor: Colors.white,
                                fontsize: 16,
                              )
                            : {
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
                                setState(() {
                                  getpasscontroller.StartTime = DateTime(
                                    _selectedDay!.year,
                                    _selectedDay!.month,
                                    _selectedDay!.day,
                                    StartTime!.hour,
                                    StartTime!.minute,
                                  );
                                }),
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
                                    : {
                                        getpasscontroller.TimeRange.text =
                                            getpasscontroller.formatTimeRange(
                                                context, StartTime, EndTime),
                                        setState(() {
                                          getpasscontroller.EndTime = DateTime(
                                            _selectedDay!.year,
                                            _selectedDay!.month,
                                            _selectedDay!.day,
                                            EndTime!.hour,
                                            EndTime!.minute,
                                          );
                                        }),
                                      },
                              },
                      },
                      child: Ev_Slot_Custom_textfield(
                        textfiled: false,
                        hinttextstyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                                color: AppColor.textgrey,
                                fontWeight: FontWeight.w700),
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
                        TextController: getpasscontroller.TimeRange,
                        hint: 'Time Range',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 85.w,
                    height: 32.h,
                    child: Ev_Slot_Custom_textfield(
                      hinttextstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.textgrey,
                              fontWeight: FontWeight.w700),
                      textfiled: false,
                      TextController: getpasscontroller.Noofhours,
                      hint: 'Hours',
                      textstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.textblack,
                              fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              SelecteDayoutpurpose(context),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "NAME OF PERSON VISITING",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.textgrey,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 0.8),
                  ),
                  Text(
                    "CONTACT NUMBER",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.textgrey,
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
                    width: MediaQuery.of(context).size.width * 0.47,
                    height: 32.h,
                    child: Ev_Slot_Custom_textfield(
                      textcenter: false,
                      hinttextstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.textgrey,
                              fontWeight: FontWeight.w700),
                      textstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.textblack,
                              fontWeight: FontWeight.w700),
                      TextController: getpasscontroller.personname,
                      hint: 'Name here',
                      suffixIcon: Icons.contacts_rounded,
                      onSuffixIconPressed: () {
                        _pickContact();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 32.h,
                    child: Ev_Slot_Custom_textfield(
                      numberbutton: true,
                      maxnumber: 10,
                      textcenter: false,
                      hinttextstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.grey3,
                              fontWeight: FontWeight.w700),
                      TextController: getpasscontroller.contactnumber,
                      hint: 'Number here',
                      textstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.textblack,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              inputtextwidgets(
                hinttextstyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.grey3, fontWeight: FontWeight.w700),
                controller: getpasscontroller.discription,
              ),
              SizedBox(
                height: 10.h,
              ),
              LeaveApprovel(context),
            ],
          ),
        ),
      ),
    );
  }

  Column SelecteDayoutpurpose(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "SELECT PURPOSE OF LEAVE*",
          style: GoogleFonts.quicksand(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColor.textgrey,
          ),
          //  Theme.of(context).textTheme.bodyLarge?.copyWith(
          //     // color: AppColor.grey3,
          //     fontWeight: FontWeight.bold,
          //     height: 1.5,
          //     letterSpacing: 0.8),
        ),
        const SizedBox(height: 10),
        Obx(
          () => getpasscontroller.dayoutcategoryloading.value == true
              ? const Loader()
              : SizedBox(
                  width: double.infinity,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (100 / 20),
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: getpasscontroller.DayoutCategorydata.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool isSelected = getpasscontroller.DayoutCetegory.text ==
                          getpasscontroller.DayoutCategorydata[index].sId;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            getpasscontroller.DayoutCetegory.text =
                                getpasscontroller
                                    .DayoutCategorydata[index].sId!;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.secondary
                                : AppColor.grey6,
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(
                            //   color: isSelected
                            //       ? Colors.amber.shade600
                            //       : Colors.grey.shade300,
                            //   width: 2,
                            // ),
                          ),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                getpasscontroller
                                    .DayoutCategorydata[index].name!
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: AppColor.textblack,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Wrap(
                  //   spacing: 15.0,
                  //   runSpacing: 10.0,
                  //   children:
                  //       getpasscontroller.DayoutCategorydata.map((purpose) {
                  //     bool isSelected =
                  //         getpasscontroller.DayoutCetegory.text == purpose.sId;
                  //     return GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           getpasscontroller.DayoutCetegory.text =
                  //               purpose.sId!;
                  //         });
                  //       },
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(
                  //             vertical: 10, horizontal: 15),
                  //         decoration: BoxDecoration(
                  //           color: isSelected
                  //               ? AppColor.secondary
                  //               : AppColor.grey6,
                  //           borderRadius: BorderRadius.circular(20),
                  //           // border: Border.all(
                  //           //   color: isSelected
                  //           //       ? Colors.amber.shade600
                  //           //       : Colors.grey.shade300,
                  //           //   width: 2,
                  //           // ),
                  //         ),
                  //         child: Text(
                  //           purpose.name!.toUpperCase(),
                  //           style:
                  //               Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //                     color: AppColor.textblack,
                  //                     fontWeight: FontWeight.w700,
                  //                   ),
                  //         ),
                  //       ),
                  //     );

                  //   }).toList(),
                  // ),
                ),
        )
      ],
    );
  }

  Container LeaveApprovel(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "LEAVE STAGES FOR APPROVAL",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColor.textgrey, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStepWidget("1", "Parents", isActive: false),
              _buildLine(),
              _buildStepWidget("2", "HOD", isActive: false),
              _buildLine(),
              _buildStepWidget("3", "Warden", isActive: false),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStepWidget(String number, String label,
      {bool isActive = false}) {
    return Column(
      children: [
        Container(
          height: 31.h,
          width: 31.w,
          // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.deepPurple : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              number,
              // style: TextStyle(
              //   color: isActive ? Colors.white : Colors.deepPurple,
              //   fontWeight: FontWeight.bold,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isActive ? AppColor.textgrey : AppColor.primary,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColor.primary, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildLine() {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 4),
          height: 2,
          width: 50,
          color: Colors.deepPurple,
        ),
        Container(
          height: 25.h,
        )
      ],
    );
  }

  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  List<Contact>? _contacts;
  Future<void> _pickContact() async {
    Contact? contact = await _contactPicker.selectContact();
    setState(() {
      _contacts = contact == null ? null : [contact];
      getpasscontroller.personname.text = _contacts!.single.fullName ?? "";
      String phoneNumber = _contacts!.single.phoneNumbers!.first;

// Remove '+91' if it exists at the beginning of the string
      phoneNumber = phoneNumber.replaceFirst('+91', '');

// Trim any extra spaces that may remain
      phoneNumber = phoneNumber.trim();
      getpasscontroller.contactnumber.text = phoneNumber.replaceAll(' ', '');
      // "${_contacts!.single.phoneNumbers!.first}";
    });
  }
}

class visitor_managment extends StatelessWidget {
  visitor_managment({
    super.key,
  });

  final GetPassController getpasscontroller = Get.put(GetPassController());

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
        helpText: "Booking Date",
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      controller.text = Utils.formatDatebynd(selectedDate);
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: "Select Time",
    );

    if (picked != null) {
      final DateTime now = DateTime.now();
      final DateTime selectedTime =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      controller.text = formatTimePass(selectedTime);
    }
  }

  String formatTimePass(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return stackcontainer(
      writedata: Column(
        children: [
          SizedBox(
            height: 500.h,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "APPLY FOR VISITOR PASS",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColor.primary, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    inputtextwidgets(
                      lable: "VISITOR’S NAME*",
                      notshowlimit: true,
                      hint: "Name",
                      hinttextstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.grey3,
                              fontWeight: FontWeight.w700),
                      controller: getpasscontroller.visitorname,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    inputtextwidgets(
                      lable: "RELATION WITH STUDENT*",
                      notshowlimit: true,
                      hinttextstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.grey3,
                              fontWeight: FontWeight.w700),
                      controller: getpasscontroller.relationwithstudent,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    inputtextwidgets(
                      lable: "CONTACT NUMBER",
                      notshowlimit: true,
                      hinttextstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.grey3,
                              fontWeight: FontWeight.w700),
                      controller: getpasscontroller.contactnumber,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "EXPECTED ARRIVAL DATE",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 192.w,
                          height: 32.h,
                          child: InkWell(
                            onTap: () async => {
                              await _selectDate(
                                  context, getpasscontroller.Arriveldate),
                              await _selectTime(
                                  context, getpasscontroller.ArrivelTimeRange)
                            },
                            child: Ev_Slot_Custom_textfield(
                              textfiled: false,
                              textstyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.textblack,
                                      fontWeight: FontWeight.w700),
                              TextController: getpasscontroller.Arriveldate,
                              hint: 'Date',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 85.w,
                          height: 32.h,
                          child: Ev_Slot_Custom_textfield(
                            textfiled: false,
                            TextController: getpasscontroller.ArrivelTimeRange,
                            hint: 'Time',
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "EXPECTED DEPARTURE DATE",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 192.w,
                          height: 32.h,
                          child: InkWell(
                            onTap: () async => {
                              await _selectDate(
                                  context, getpasscontroller.Departuredate),
                              await _selectTime(
                                  context, getpasscontroller.Departuretime)
                            },
                            child: Ev_Slot_Custom_textfield(
                              textfiled: false,
                              textstyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.textblack,
                                      fontWeight: FontWeight.w700),
                              TextController: getpasscontroller.Departuredate,
                              hint: 'Date',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 85.w,
                          height: 32.h,
                          child: Ev_Slot_Custom_textfield(
                            textfiled: false,
                            TextController: getpasscontroller.Departuretime,
                            hint: 'time',
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    inputtextwidgets(
                      lable: "REASON FOR VISITING",
                      notshowlimit: true,
                      hinttextstyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.grey3,
                              fontWeight: FontWeight.w700),
                      controller: getpasscontroller.reasonforvisiting,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 1.h,
            width: double.infinity,
            decoration:
                BoxDecoration(color: Colors.black.withOpacity(0.2), boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(-1, -2), // changes position of shadow
              ),
            ]),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              ontap: () {},
              Title: 'Send For Approval',
              Textsize: 15,
            ),
          )
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
      child: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.textgrey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final String name;
  final Color? boxcolor;
  final Color? textColor;
  const TextFields({
    super.key,
    required this.name,
    this.boxcolor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
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
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';
import 'package:yoco_stay_student/app/module/leave_status/widgets/first_date.dart';
import 'package:yoco_stay_student/app/module/leave_status/widgets/input_textfield.dart';
import 'package:yoco_stay_student/app/module/leave_status/widgets/second_date.dart';
import 'package:yoco_stay_student/app/module/leave_status/widgets/selecte_date_rang.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class LeaveFromPage extends StatefulWidget {
  final bool leave;
  const LeaveFromPage({super.key, required this.leave});

  @override
  State<LeaveFromPage> createState() => _LeaveFromPageState();
}

class _LeaveFromPageState extends State<LeaveFromPage> {
final LeaveController _leavecontroller = 
      Get.put(LeaveController(), permanent: true);
  DateTime _focusedDay = DateTime.now();
  // List<DateTime?> _selectedDay = [];

  final ScrollController _scrollController = ScrollController();
  double _lastScrollOffset = 0.0;
  DateTime now = DateTime.now();
  late DateTime lastDayOfMonth;
  late int todayIndex;

  @override
void initState() {
  super.initState();
  _lastScrollOffset = 0.0;

  // Run after first frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _leavecontroller.GetCategoryListdata("leave");

    widget.leave == true
        ? _leavecontroller.selectedDay.clear()
        : _leavecontroller.selectedDay.add(DateTime.now());

    _leavecontroller.totaldate.clear();
    _leavecontroller.Noofhours.clear();
  });

  lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  todayIndex = DateTime.now()
      .difference(DateTime(_focusedDay.year, _focusedDay.month, 1))
      .inDays;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    _scrollToSelectedDate(todayIndex);
  });
}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  DateTime? date;
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
    return Scaffold(
      bottomNavigationBar: SubmitButton(),
      appBar: CustomAppBar(
        // title: "COMPLAINT MANAGEMENT",
        titlewidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              widget.leave == true
                  ? "assets/images/drawer/leave.png"
                  : "assets/icons/late_entry.png",
              width: 40.w,
              height: 50.h,
            ),
            Text(
              widget.leave == true ? "LEAVE REQUEST" : "LATE COMING",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        trailingwidget: [
          Notificationsection(),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.76,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TimeSection(context, widget.leave == false ? true : false),
                widget.leave == false
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SelecteDateRange(
                          leavecontroller: _leavecontroller,
                          leave: widget.leave,
                        ),
                      )
                    : Container(),
                widget.leave == false
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: FirstDateSelecteDateRange(
                          leavecontroller: _leavecontroller,
                          leave: widget.leave,
                        ),
                      ),
                widget.leave == false
                    ? Container()
                    : _leavecontroller.selectedDay.length != 2
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: SecondDateSelecteDateRange(
                              leavecontroller: _leavecontroller,
                              leave: widget.leave,
                            ),
                          ),

                _leavecontroller.totaldate.text == ""
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "No of Days:    ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.grey3,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      height: 1.5,
                                      letterSpacing: 0.8),
                            ),
                            Text(
                              _leavecontroller.totaldate.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.textblack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      height: 1.5,
                                      letterSpacing: 0.8),
                            ),
                          ],
                        ),
                      ),
                widget.leave == true
                    ? SelecteLeavePurpose(context)
                    : Container(),

                // SizedBox(
                //   height: 10.h,
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: LeaveDescriotion(
                    controller: _leavecontroller,
                    leave: widget.leave,
                  ),
                ),
                LeaveApprovel(context),
                // widget.leave == true
                //     ? Container()
                //     : SizedBox(
                //         height: MediaQuery.of(context).size.height * 0.3,
                //       ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding Notificationsection() {
    return Padding(
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
    );
  }

  Padding SubmitButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Obx(
          () => Container(
            // height: 76.h,
            // width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.grey4.withOpacity(0.2),
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                      offset: const Offset(1, 0)),
                  BoxShadow(
                      color: AppColor.grey4.withOpacity(0.2),
                      blurRadius: 0.1,
                      spreadRadius: 0.1,
                      offset: const Offset(1, 0)),
                ]),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: CustomButton(
              ontap: () {
                print("widget data = ${widget.leave}");
                widget.leave == true
                    ? _leavecontroller.selectedDay.isEmpty &&
                            _leavecontroller.selectedPurpose.text.isEmpty
                        ? Utils.showToast(
                            message: "Please Select Date & Purpose of Leave.",
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            fontsize: 16,
                          )
                        : _leavecontroller.SubmitLeaveApplication()
                    : _leavecontroller.SubmitLateComingApplication();
              },
              Title: 'Send For Approval',
              Textsize: 15,
              isloaging: _leavecontroller.LeaveCreating.value == true ||
                  _leavecontroller.LateComingCreating.value == true,
              BoxColor: _leavecontroller.LeaveCreating.value == true ||
                      _leavecontroller.LateComingCreating.value == true
                  ? AppColor.white
                  : null,
            ),
          ),
        ));
  }

  Padding SelecteLeavePurpose(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "SELECT PURPOSE OF LEAVE*",
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.textgrey,
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => _leavecontroller.leavecategoryloading == true
                ? const Loader()
                : SizedBox(
                    width: double.infinity,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (100 / 20),
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: _leavecontroller.Categorydata.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSelected =
                            _leavecontroller.selectedPurpose.text ==
                                _leavecontroller.Categorydata[index].sId;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _leavecontroller.selectedPurpose.text =
                                  _leavecontroller.Categorydata[index].sId!;
                            });
                          },
                          child: Container(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.secondary
                                  : AppColor.grey6,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  _leavecontroller.Categorydata[index].name!
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
                    //   spacing: 20.0,
                    //   runSpacing: 10.0,
                    //   children: _leavecontroller.Categorydata.map((purpose) {
                    //     bool isSelected =
                    //         _leavecontroller.selectedPurpose.text ==
                    //             purpose.sId;
                    //     return GestureDetector(
                    //       onTap: () {
                    //         setState(() {
                    //           _leavecontroller.selectedPurpose.text =
                    //               purpose.sId!;
                    //         });
                    //       },
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //             vertical: 8, horizontal: 10),
                    //         decoration: BoxDecoration(
                    //           color: isSelected
                    //               ? AppColor.secondary
                    //               : AppColor.grey6,
                    //           borderRadius: BorderRadius.circular(20),
                    //         ),
                    //         child: Text(
                    //           purpose.name!.toUpperCase(),
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyLarge
                    //               ?.copyWith(
                    //                 color: AppColor.textblack,
                    //                 fontWeight: FontWeight.w700,
                    //               ),
                    //         ),
                    //       ),
                    //     );

                    //   }).toList(),
                    // ),
                  ),
          )
        ],
      ),
    );
  }

  Future<void> selectDateRange(BuildContext context) async {
    DateTimeRange? picked = _leavecontroller.selectedDay.isNotEmpty
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
          );

    if (picked != null) {
      _leavecontroller.selectedDay.clear();
      // Do something with the selected range

      setState(() {
        _leavecontroller.selectedDay.add(picked.start);
        _leavecontroller.selectedDay.add(picked.end);
        if (_leavecontroller.selectedDay.isEmpty) {
          _leavecontroller.selectDaterang.clear();
          _leavecontroller.totaldate.clear();
        } else {
          _leavecontroller.selectDaterang.text =
              _leavecontroller.formatDateRange(
                  _leavecontroller.selectedDay.first ?? DateTime.now(),
                  _leavecontroller.selectedDay.last ?? DateTime.now());
        }
      });
    }
  }

  Container TimeSection(BuildContext context, bool? latecoming) {
    DateTime? picker;
    return Container(
      decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r))),
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    widget.leave == false
                        ? {
                            picker = _leavecontroller.selectedDay.isNotEmpty
                                ? await showDatePicker(
                                    helpText: "Select Start Date",
                                    context: context,
                                    initialDate:
                                        _leavecontroller.selectedDay.first,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101),
                                  )
                                : await showDatePicker(
                                    helpText: "Select Start Date",
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101),
                                  ),
                            if (picker != null)
                              {
                                setState(() {
                                  _leavecontroller.selectedDay.clear();
                                  _leavecontroller.selectedDay.add(picker);
                                }),
                              }
                          }
                        : selectDateRange(context);
                  },
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
                GestureDetector(
                  onTap: () async {
                    widget.leave == false
                        ? {
                            picker = _leavecontroller.selectedDay.isNotEmpty
                                ? await showDatePicker(
                                    helpText: "Select Start Date",
                                    context: context,
                                    initialDate:
                                        _leavecontroller.selectedDay.first,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101),
                                  )
                                : await showDatePicker(
                                    helpText: "Select Start Date",
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2101),
                                  ),
                            if (picker != null)
                              {
                                setState(() {
                                  _leavecontroller.selectedDay.clear();
                                  _leavecontroller.selectedDay.add(picker);
                                }),
                              }
                          }
                        : selectDateRange(context);
                  },
                  child: Text(
                    "Select date",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.grey3, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.chevron_back,
                    color: AppColor.white),
                onPressed: () {
                  setState(() {
                    // Move to the previous month
                    if (_focusedDay.month > 1) {
                      _focusedDay =
                          DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
                    } else {
                      // If it's January, go to December of the previous year
                      _focusedDay = DateTime(_focusedDay.year - 1, 12, 1);
                    }
                    lastDayOfMonth =
                        DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
                  });
                },
              ),
              SizedBox(
                width: 270.w,
                height: 65.h, // Ensure the ListView has a fixed height
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
                    DateTime date =
                        // _focusedDay.month == DateTime.now().month &&
                        //         _focusedDay.year == DateTime.now().year
                        //     ? DateTime.now().add(Duration(days: index))
                        //     :
                        DateTime(_focusedDay.year, _focusedDay.month, 1)
                            .add(Duration(days: index));
                    bool isSelected = _leavecontroller.selectedDay.isNotEmpty &&
                        ((date.year ==
                                    _leavecontroller.selectedDay.first!.year &&
                                date.month ==
                                    _leavecontroller.selectedDay.first!.month &&
                                date.day ==
                                    _leavecontroller.selectedDay.first!.day) ||
                            (date.year ==
                                    _leavecontroller.selectedDay.last!.year &&
                                date.month ==
                                    _leavecontroller.selectedDay.last!.month &&
                                date.day ==
                                    _leavecontroller.selectedDay.last!.day) ||
                            (date.isAfter(DateTime(
                                    _leavecontroller.selectedDay.first!.year,
                                    _leavecontroller.selectedDay.first!.month,
                                    _leavecontroller.selectedDay.first!.day)) &&
                                date.isBefore(DateTime(
                                    _leavecontroller.selectedDay.last!.year,
                                    _leavecontroller.selectedDay.last!.month,
                                    _leavecontroller.selectedDay.last!.day))) ||
                            Utils.isDateInList(
                                date, _leavecontroller.selectedDay));

                    if (isSelected) {
                      // Automatically scroll to the selected date
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToSelectedDate(index);
                      });
                    }

                    return GestureDetector(
                      onTap: () {
                        date.isAfter(DateTime.now()) ||
                                (date.year == DateTime.now().year &&
                                    date.month == DateTime.now().month &&
                                    date.day == DateTime.now().day)
                            ? setState(() {
                                _scrollToSelectedDate(index);
                                if (_leavecontroller.selectedDay.isNotEmpty) {
                                  if (latecoming == true) {
                                    _leavecontroller.selectedDay.clear();
                                    _leavecontroller.selectedDay.add(date);
                                  } else if (Utils.isDateInList(
                                      date, _leavecontroller.selectedDay)) {
                                    Utils.removeDate(
                                        date, _leavecontroller.selectedDay);
                                  } else if (date.isBefore(
                                      _leavecontroller.selectedDay.first!)) {
                                    _leavecontroller.selectedDay.first = date;
                                  } else if (date.isAfter(_leavecontroller
                                          .selectedDay.first!) &&
                                      date.isBefore(
                                          _leavecontroller.selectedDay.last!)) {
                                    _leavecontroller.selectedDay.last = date;
                                  } else {
                                    _leavecontroller.selectedDay.add(date);
                                  }
                                } else {
                                  _leavecontroller.selectedDay.add(date);
                                }
                                if (_leavecontroller.selectedDay.isEmpty) {
                                  _leavecontroller.selectDaterang.clear();
                                  _leavecontroller.totaldate.clear();
                                } else {
                                  _leavecontroller.selectDaterang.text =
                                      _leavecontroller.formatDateRange(
                                          _leavecontroller.selectedDay.first ??
                                              DateTime.now(),
                                          _leavecontroller.selectedDay.last ??
                                              DateTime.now());
                                }
                              })
                            : Utils.showToast(
                                message: "You Can't Select Back Date!",
                                gravity: ToastGravity.CENTER,
                                timeduration: 1,
                                toastlength: Toast.LENGTH_SHORT,
                                textColor: Colors.white,
                                fontsize: 16,
                              );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColor.white
                              : Utils.isSelectedDayisSameAsTodayDate(date)
                                  ? AppColor.secondary
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              DateFormat.E().format(date),
                              style:
                                  AppTextTheme.textTheme.displayLarge?.copyWith(
                                fontSize: 16,
                                color: isSelected
                                    ? AppColor.primary
                                    : Utils.isSelectedDayisSameAsTodayDate(date)
                                        ? AppColor.primary
                                        : AppColor.white,
                              ),
                            ),
                            Text(
                              date.day.toString(),
                              style:
                                  AppTextTheme.textTheme.displayLarge?.copyWith(
                                color: isSelected
                                    ? AppColor.primary
                                    : Utils.isSelectedDayisSameAsTodayDate(date)
                                        ? AppColor.primary
                                        : AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.chevron_forward,
                    color: AppColor.white),
                onPressed: () {
                  setState(() {
                    // Move to the next month
                    _focusedDay =
                        DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
                    lastDayOfMonth =
                        DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          )
        ],
      ),
    );
  }

  Container LeaveApprovel(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
}

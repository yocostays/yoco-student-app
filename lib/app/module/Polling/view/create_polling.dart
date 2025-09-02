import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/custom_dropdowm.dart';
import 'package:yoco_stay_student/app/core/values/custom_textformfield.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class CreatePolling extends StatefulWidget {
  const CreatePolling({super.key});

  @override
  State<CreatePolling> createState() => _CreatePollingState();
}

class _CreatePollingState extends State<CreatePolling> {
  String? selectedReason;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  List<Widget> dynamicFields = [];
  int dynamicFieldCounter = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _addDynamicField() {
    setState(() {
      dynamicFields.add(_createDynamicField(dynamicFieldCounter));
      dynamicFieldCounter++;
    });
  }

  void _removeDynamicField(int index) {
    setState(() {
      dynamicFields.removeAt(index);
      dynamicFieldCounter--;
    });
  }

  Widget _createDynamicField(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColor.lightpurple,
          radius: 22.r,
          child: Text(String.fromCharCode(65 + index + 2)),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomTextFormField(
            hintText: 'Type here...',
            suffixIcon: Icons.close,
            onSuffixIconPressed: () => _removeDynamicField(index),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titlewidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/drawer/polling.png",
                width: 60.w,
                height: 60.h,
              ),
              Text(
                "CREATE POLL".toUpperCase(),
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
                child: InkWell(
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
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: stackcontainer(
              writedata: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 520.h,
                      child: SingleChildScrollView(
                        // physics: NeverScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'REASON',
                                style: AppTextTheme.textTheme.labelLarge
                                    ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.grey3),
                              ),
                              CustomDropdownFormField(
                                backgroundColor: AppColor.lightyellow,
                                borderColor: AppColor.lightyellow,
                                hintText: "Reason",
                                items: const [
                                  "Mess Management",
                                  "EV Slot",
                                  "Paymnet",
                                  "Gate Pass",
                                  "Other"
                                ],
                                selectedItem: selectedReason,
                                onChanged: (value) {
                                  setState(() {
                                    selectedReason = value;
                                  });
                                },
                              ),
                              SizedBox(height: 10.h),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'START DATE',
                                        style: AppTextTheme.textTheme.labelLarge
                                            ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.grey3),
                                      ),
                                      const Icon(FeatherIcons.calendar,
                                          color: AppColor.primary),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: Container(
                                          width: 150.w,
                                          height: 35.h,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightyellow,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Center(
                                            child: Text(
                                              DateFormat('d MMMM, yyyy')
                                                  .format(selectedDate),
                                              style: const TextStyle(
                                                  color: AppColor.textblack),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _selectTime(context),
                                        child: Container(
                                          width: 120.w,
                                          height: 35.h,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightyellow,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Center(
                                            child: Text(
                                              selectedTime.format(context),
                                              style: const TextStyle(
                                                  color: AppColor.textblack),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'END DATE',
                                        style: AppTextTheme.textTheme.labelLarge
                                            ?.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.grey3),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Icon(
                                        FeatherIcons.calendar,
                                        color: AppColor.primary,
                                        size: 18.h,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _selectDate(context),
                                        child: Container(
                                          width: 150.w,
                                          height: 35.h,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightyellow,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Center(
                                            child: Text(
                                              DateFormat('d MMMM, yyyy')
                                                  .format(selectedDate),
                                              style: const TextStyle(
                                                  color: AppColor.textblack),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _selectTime(context),
                                        child: Container(
                                          width: 120.w,
                                          height: 35.h,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: AppColor.lightyellow,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Center(
                                            child: Text(
                                              selectedTime.format(context),
                                              style: const TextStyle(
                                                  color: AppColor.textblack),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'ENTER QUESTION',
                                    style: AppTextTheme.textTheme.labelLarge
                                        ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.grey3),
                                  ),
                                  SizedBox(height: 10.h),
                                  const CustomTextFormField(
                                    hintText: "Type Here...",
                                    hintTextColor: AppColor.grey3,
                                  ),
                                  SizedBox(height: 10.h),
                                  // Fixed Answer A
                                  Text(
                                    'ENTER OPTIONS',
                                    style: AppTextTheme.textTheme.labelLarge
                                        ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColor.grey3),
                                  ),
                                  SizedBox(height: 15.h),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColor.lightpurple,
                                        radius: 22.r,
                                        child: const Text('A'),
                                      ),
                                      SizedBox(width: 8.w),
                                      const Expanded(
                                        child: CustomTextFormField(
                                          hintText: 'Type here...',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  // Fixed Answer B
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColor.lightpurple,
                                        radius: 22.r,
                                        child: const Text('B'),
                                      ),
                                      SizedBox(width: 8.w),
                                      const Expanded(
                                        child: CustomTextFormField(
                                          hintText: 'Type here...',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  // Dynamic Fields
                                  Column(
                                    children: dynamicFields,
                                  ),
                                  // Add Field Button
                                  Center(
                                    child: IconButton(
                                      onPressed: _addDynamicField,
                                      icon: Icon(
                                        CupertinoIcons.add_circled_solid,
                                        color: AppColor.primary,
                                        size: 30.h,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  CustomButton(ontap: () {}, Title: "Submit"),
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: SizedBox(height: 100.h, child: const CustomBottomNavbar()),
          ),
        ],
      ),
    );
  }
}

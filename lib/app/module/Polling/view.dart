// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/polling/view/create_polling.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class PollingScreen extends StatefulWidget {
  const PollingScreen({super.key});

  @override
  State<PollingScreen> createState() => _PollingScreenState();
}

class _PollingScreenState extends State<PollingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedOption = '';
  bool myresponse = false;
  Map<String, int> pollingResults = {
    'Anshul': 20,
    'Harsh': 20,
    'Rajan': 20,
    'Gautam': 20,
    'Jack': 20,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updatePollingResults() {
    setState(() {
      if (selectedOption.isNotEmpty) {
        pollingResults.updateAll(
            (key, value) => (key == selectedOption ? value + 1 : value - 1));
        print("dkkfnlskfd : $selectedOption");
      }
    });
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
                width: 50.w,
                height: 50.h,
              ),
              Text(
                "POLLING",
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () async {
            Get.to(const CreatePolling());
          },
          child: Icon(
            Icons.add,
            size: 30.h,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: stackcontainer(
              NoBackgroundcolor: true,
              writedata: Column(
                children: [
                  Container(
                    height: 40.h,
                    width: 280.w,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: AppColor.textwhite,
                      borderRadius: BorderRadius.circular(40.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      onTap: (value) {
                        setState(() {
                          _tabController.index;
                        });
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Active'),
                        Tab(text: 'My Response'),
                      ],
                      indicatorPadding: const EdgeInsets.all(2),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: AppColor.primary,
                      ),
                      labelColor: AppColor.white,
                      unselectedLabelColor: AppColor.primary,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [ActivePollingStatus(), MyResponseOptions()],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(height: 100.h, child: const CustomBottomNavbar()),
          ),
        ],
      ),
    );
  }

  ActivePollingStatus() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 200),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Student head",
                style: AppTextTheme.textTheme.labelLarge?.copyWith(
                  color: AppColor.textwhite,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20.h),
              PollingResult('Anshul', pollingResults['Anshul']!),
              PollingResult('Harsh', pollingResults['Harsh']!),
              PollingResult('Rajan', pollingResults['Rajan']!),
              PollingResult('Gautam', pollingResults['Gautam']!),
              PollingResult('Jack', pollingResults['Jack']!),
            ],
          ),
        ),
      );

  MyResponseOptions() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 200),
        child: Container(
          height: 360.h,
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: selectedOption.isEmpty
                ? [
                    Text(
                      "Student head",
                      style: AppTextTheme.textTheme.labelLarge?.copyWith(
                        color: AppColor.textwhite,
                        fontSize: 18,
                      ),
                    ),
                    PollingOption('Anshul'),
                    PollingOption('Harsh'),
                    PollingOption('Rajan'),
                    PollingOption('Gautam'),
                    PollingOption('Jack'),
                  ]
                : [
                    Text(
                      "Student head",
                      style: AppTextTheme.textTheme.labelLarge?.copyWith(
                        color: AppColor.textwhite,
                        fontSize: 18,
                      ),
                    ),
                    PollingResult('Anshul', pollingResults['Anshul']!),
                    PollingResult('Harsh', pollingResults['Harsh']!),
                    PollingResult('Rajan', pollingResults['Rajan']!),
                    PollingResult('Gautam', pollingResults['Gautam']!),
                    PollingResult('Jack', pollingResults['Jack']!),
                  ],
          ),
        ),
      );

  Widget PollingResult(String name, int percentage) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tabController.index == 0
                ? LinearProgressIndicator(
                    minHeight: 15.h,
                    borderRadius: BorderRadius.circular(20.r),
                    value: percentage / 100,
                    backgroundColor: Colors.white,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColor.secondary),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: AppTextTheme.textTheme.labelLarge?.copyWith(
                      color: selectedOption == name
                          ? AppColor.secondary
                          : AppColor.textwhite,
                      fontSize: _tabController.index == 0 ? 15 : 20,
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  '$percentage%',
                  style: AppTextTheme.textTheme.labelLarge?.copyWith(
                      color: selectedOption == name
                          ? AppColor.secondary
                          : AppColor.textwhite,
                      fontSize: _tabController.index == 0 ? 15 : 20,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      );

  Widget PollingOption(String name) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: ListTile(
          title: Text(
            name,
            style: AppTextTheme.textTheme.labelLarge?.copyWith(
              color: AppColor.textwhite,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          leading: Radio<String>(
            value: name,
            groupValue: selectedOption,
            activeColor: AppColor.textwhite,
            fillColor: MaterialStateColor.resolveWith((states) {
              if (!states.contains(MaterialState.selected)) {
                return AppColor.textwhite;
              }
              return AppColor.textwhite;
            }),
            onChanged: (value) {
              setState(() {
                print("hellodkfj : $value");
                selectedOption = value!;
                updatePollingResults();
              });
            },
          ),
        ),
      );
}

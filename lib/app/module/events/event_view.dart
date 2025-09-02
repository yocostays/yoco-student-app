import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/view/my_booking_page.dart';
import 'package:yoco_stay_student/app/module/events/view/past_booking_page.dart';
import 'package:yoco_stay_student/app/module/events/view/up_coming_page.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class EventStatusPage extends StatefulWidget {
  const EventStatusPage({super.key});

  @override
  State<EventStatusPage> createState() => _EventStatusPageState();
}

class _EventStatusPageState extends State<EventStatusPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
              "assets/images/starimage.png",
              width: 50.w,
              height: 50.h,
            ),
            Text(
              "EVENTS STATUS",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColor.white, fontSize: 12),
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
            child: stackcontainer(
              customheight: 510.h,
              NoBackgroundcolor: true,
              writedata: Column(
                children: [
                  Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.textwhite,
                      borderRadius: BorderRadius.circular(40.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Upcoming'),
                        Tab(text: 'My booking'),
                        Tab(text: 'Past'),
                      ],
                      indicatorPadding: const EdgeInsets.all(1),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.primary,
                      ),
                      labelColor: AppColor.white,
                      unselectedLabelColor: AppColor.primary,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        UpComingPage(),
                        MyBookingEventpage(),
                        PastBookingEventpage(),
                      ],
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
}

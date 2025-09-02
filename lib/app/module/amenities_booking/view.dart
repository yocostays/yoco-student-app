import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/env.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/views/active_booking.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/views/archive_booking.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/views/select_aminities.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class AmenitiesBooking extends StatefulWidget {
  const AmenitiesBooking({super.key});

  @override
  State<AmenitiesBooking> createState() => _AmenitiesBookingState();
}

class _AmenitiesBookingState extends State<AmenitiesBooking>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "BOOKING STATUS", trailingwidget: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: InkWell(
            onTap: () {
              Get.to(const NotificationView());
            },
            child: Container(
              width: 31.w,
              height: 31.h,
              decoration: BoxDecoration(
                color: AppColor.lightpurple.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: const Icon(
                CupertinoIcons.bell,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () async {
            Get.to(() => const AmenitiesselectionPage());
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
            physics: const NeverScrollableScrollPhysics(),
            child: stackcontainer(
              customheight: 550.h,
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
                        // BoxShadow(
                        //   color: AppColor.primary.withOpacity(0.2),
                        //   spreadRadius: 1,
                        //   blurRadius: 5,
                        //   offset: Offset(-1, -2), // changes position of shadow
                        // ),
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
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Active Bookings'),
                        Tab(text: 'Archive'),
                      ],
                      indicatorPadding: const EdgeInsets.all(3),
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
                      children: const [ActiveBooking(), ArchiveBookingPage()],
                    ),
                  ),
                  SizedBox(
                    height: screenwidth * 0.1,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.h,
            left: 0.h,
            right: 0.h,
            child: SizedBox(
              height: 100.h,
              child: const CustomBottomNavbar(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';

import 'package:yoco_stay_student/app/module/home/view/book_meal_view.dart';
import 'package:yoco_stay_student/app/module/home/view/cancel_meal_view.dart';
import 'package:yoco_stay_student/app/module/home/widgets/custom_drawer.dart';
import 'package:yoco_stay_student/app/module/home/widgets/dashboard.dart';
import 'package:yoco_stay_student/app/module/home/widgets/info_widget.dart';
import 'package:yoco_stay_student/app/module/home/widgets/today_menu_section.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';

import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/globals.dart' as globals;

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ProfileController profileController = ProfileController();
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    profileController.GetProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<ScaffoldState> scaffoldKey;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: AppColor.primary,
            drawerScrimColor: Colors.black.withOpacity(0.3),
            endDrawer: const CustomDrawer(),
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 5.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const InfoWidget(),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        SizedBox(
                          // height: globals.globalheight*0.8,
                          height: globals.globalheight,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Text(
                                    'THOUGHT FOR THE DAY',
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                            color: AppColor.textgrey,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColor
                                        .midpurple, // Lighter purple for the quote background
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '"Success is the sum of small efforts repeated day in and day out." — Robert Collier',
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(color: AppColor.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Dashboard(scaffoldKey: scaffoldKey),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(const BookMealScreen());
                                      },
                                      child: Container(
                                          height: 42.h,
                                          width: 156.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: AppColor.white,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "+ Book Meal",
                                            style: AppTextTheme
                                                .textTheme.displayMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColor.textblack),
                                          ))),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        DateTime firstDayOfMonth = DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            1);
                                        await homeController.GetBookedData(
                                            firstDayOfMonth);

                                        Get.to(const MessManagementScreen());
                                      },
                                      child: Container(
                                          height: 42.h,
                                          width: 156.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: AppColor.white,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "- Cancel Meal",
                                            style: AppTextTheme
                                                .textTheme.displayMedium
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColor.textblack),
                                          ))),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoute.leavepage);
                                        },
                                        child: Container(
                                            height: 42.h,
                                            width: 156.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              color: AppColor.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/drawer/leave.png",
                                                  scale: 6,
                                                ),
                                                SizedBox(
                                                  width: 5.h,
                                                ),
                                                Text(
                                                  "Leave",
                                                  style: AppTextTheme
                                                      .textTheme.displayMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColor
                                                              .textblack),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     // Utils.showAlertDialog(context, 'Alert',
                                    //     //     'Emergency Section coming soon.');

                                    //     // module not ready so comment it
                                    //     // Get.toNamed(AppRoute.Emergencytabpage);
                                    //   },
                                    //   child: Container(
                                    //       height: 42.h,
                                    //       width: 156.w,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(10.r),
                                    //         color: AppColor.white,
                                    //       ),
                                    //       child: Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment.center,
                                    //         children: [
                                    //           Image.asset(
                                    //             'assets/images/drawer/smallEmergencyLogo.png',
                                    //             scale: 2,
                                    //           ),
                                    //           SizedBox(
                                    //             width: 5.h,
                                    //           ),
                                    //           Text(
                                    //             "Emergency",
                                    //             style: AppTextTheme
                                    //                 .textTheme.displayMedium
                                    //                 ?.copyWith(
                                    //                     fontWeight:
                                    //                         FontWeight.bold,
                                    //                     color:
                                    //                         AppColor.textblack),
                                    //           ),
                                    //         ],
                                    //       )),
                                    // )
                                  ],
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),
                                TodayMenuSection(),
                                SizedBox(
                                  height: 40.h,
                                ),

                                // // Notification ==================================
                                // NotificationSection(),
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // PollSection(),
                                // //Event =================
                                // SizedBox(
                                //   height: 10.h,
                                // ),
                                // EventSection(),
                                // SizedBox(height: 30),
                                // SizedBox(
                                //   height: 80.h,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: -10.h,
                //   left: 0.h,
                //   right: 0.h,
                //   child: Container(
                //     height: 100.h,
                //     child: CustomBottomNavbar(),
                //   ),
                // ),
                Positioned(
                  right: 15,
                  top: 340.h,
                  child: GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                    child: Container(
                      width: 30.h,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 24.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // floatingActionButtonLocation:
            //     FloatingActionButtonLocation.miniCenterDocked,
            // floatingActionButton: const CenterButton(
            //   home: true,
            // ),
            // bottomNavigationBar: const BottomNavigation(
            //   home: true,
            // ),
          ),
        );
      },
    );
  }
}

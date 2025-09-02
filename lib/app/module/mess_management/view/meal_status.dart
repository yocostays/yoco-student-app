import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/mess_management/repository.dart';
import 'package:yoco_stay_student/app/module/mess_management/view/booked_meal_status.dart';
import 'package:yoco_stay_student/app/module/mess_management/view/cancel_meal_status.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';

class MealStatus extends StatefulWidget {
  const MealStatus({
    super.key,
  });

  @override
  State<MealStatus> createState() => _MealStatusState();
}

class _MealStatusState extends State<MealStatus>
    with SingleTickerProviderStateMixin {
  final MessController messController = Get.put(MessController());

  @override
  void initState() {
    super.initState();
    messController.mealstatusController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    messController.mealstatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // prevent back
      onPopInvoked: (_) async {
        // Manually navigate back
        Get.to(() => const DashboardPage());
      },
      child: Scaffold(
        appBar: CustomAppBar(
            onLeadingPressed: () {
              Get.to(() => const DashboardPage());
            },
            titlewidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/mess_managment/delicious-cartoon-style-food 1 (1).png",
                  width: 50.w,
                  height: 50.h,
                ),
                Text(
                  "MESS MANAGEMENT",
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
                      Get.to(() => const NotificationView());
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
            Container(
              height: 100.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 60.h,
                    // width: 280.w,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(40.r),
                      boxShadow: const [],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TabBar(
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: Colors.white),
                        insets: EdgeInsets.only(
                            bottom: 60,
                            left: 50,
                            right: 50), // Adjust this value as needed
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      controller: messController.mealstatusController,
                      tabs: const [
                        Tab(text: 'BOOKED MEAL'),
                        Tab(text: 'CANCELED MEAL'),
                      ],
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: AppColor.white,
                      unselectedLabelColor: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 90,
              left: 11,
              right: 10,
              child: SizedBox(
                // width: 339.w,
                height: 460.h,
                child: TabBarView(
                  controller: messController.mealstatusController,
                  children: const [
                    BookedMealStatus(),
                    CancelMealStatus(),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: -15,
            //   child: Container(height: 100.h, child: CustomBottomNavbar()),
            // ),
          ],
        ),
        // floatingActionButtonLocation:
        //     FloatingActionButtonLocation.miniCenterDocked,
        // floatingActionButton: CenterButton(),
        // bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

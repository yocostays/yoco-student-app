import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/controller/controller.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/view/pending_page.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/view/resolved_page.dart';
import 'package:yoco_stay_student/app/module/home/view.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class ComplaintManagmentpage extends StatefulWidget {
  const ComplaintManagmentpage({super.key});

  @override
  State<ComplaintManagmentpage> createState() => _ComplaintManagmentpageState();
}

class _ComplaintManagmentpageState extends State<ComplaintManagmentpage>
    with SingleTickerProviderStateMixin {
  final CompliantController compliantController =
      Get.put(CompliantController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-hit the API each time you return to the page
    compliantController.GetComplaintedListData("pending");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => const DashboardPage());
        return false; // Prevent default back navigation
      },
      child: Scaffold(
        appBar: CustomAppBar(
            title: "COMPLAINT STATUS",
            onLeadingPressed: () {
              Get.to(() => const DashboardPage());
            },
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
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: stackcontainer(
                customheight: 510.h,
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
                            offset: const Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TabBar(
                        // labelStyle: Theme.of(context)
                        //     .textTheme
                        //     .bodyLarge
                        //     ?.copyWith(fontWeight: FontWeight.w500),
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'Pending'),
                          Tab(text: 'Resolved'),
                        ],
                        indicatorPadding: const EdgeInsets.all(3),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              20.r), // Creates border for the tab bar
                          color: AppColor
                              .primary, // Change background color from here
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
                        children: const [
                          PendingComplaintPage(),
                          ResolvedComplaintPage()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: -10,
            //   child: Container(height: 100.h, child: CustomBottomNavbar()),
            // ),
          ],
        ),
        // floatingActionButtonLocation:
        // FloatingActionButtonLocation.miniCenterDocked,
        // floatingActionButton: CenterButton(),
        // bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

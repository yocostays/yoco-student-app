import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/widgets/bottom_navigation.dart';
import 'package:yoco_stay_student/app/widgets/bottom_navigation_center_botton.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
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
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: const CenterButton(),
      bottomNavigationBar: const BottomNavigation(),
      body: Stack(
        children: [
          CutomAppBarContainer(
              title: "COMMUNITY",
              messmanagment: false,
              isScroll: false,
              height: 80.h,
              contentWidgets: [
                TabBar(
                  controller: _tabController,
                  unselectedLabelColor: AppColor.textwhite,
                  labelColor: AppColor.textwhite,
                  dividerHeight: 0,
                  indicator: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                  tabs: const [
                    Tab(text: 'Poll Status'),
                    Tab(text: 'Group'),
                  ],
                ),
                SizedBox(
                  height: 480.h,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      Center(child: PollStatusTab()),
                      Center(child: GroupTab()),
                    ],
                  ),
                ),
              ]),
          // Positioned(
          //   bottom: 0.h,
          //   left: 0.h,
          //   right: 0.h,
          //   child: Container(
          //     height: 100.h,
          //     child: CustomBottomNavbar(),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// Poll Status Tb
class PollStatusTab extends StatefulWidget {
  const PollStatusTab({super.key});

  @override
  State<PollStatusTab> createState() => _PollStatusTabState();
}

class _PollStatusTabState extends State<PollStatusTab>
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
    return Column(
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
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: TabBar(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            tabs: const [
              Tab(text: 'Active'),
              Tab(text: 'My Response'),
            ],
            indicatorPadding: const EdgeInsets.all(1),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(50), // Creates border for the tab bar
              color: AppColor.primary, // Change background color from here
            ),
            labelColor: AppColor.white,
            unselectedLabelColor: AppColor.primary,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              Center(
                child: ActivePollTab(),
              ),
              Center(
                child: MyResponsePollTab(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActivePollTab extends StatelessWidget {
  const ActivePollTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Community Comming Soon.",
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColor.primary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
    // ListView.builder(
    //   itemCount: 0,
    //   itemBuilder: (context, index) {
    //     return Column(
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(
    //             top: 20.h,
    //           ),
    //           child: EvTicketCard(
    //             iconPath: 'assets/images/drawer/polling.png',
    //             title: 'Question',
    //             vihicelname: 'Mess Management',
    //             date: "9th Mar, 2024 - 9th Mar, 2024",
    //             time: "10:30 AM - 01:00 PM",
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}

class MyResponsePollTab extends StatelessWidget {
  const MyResponsePollTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Community Comming Soon.",
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColor.primary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
    // ListView.builder(
    //   itemCount: 6,
    //   itemBuilder: (context, index) {
    //     return Column(
    //       children: [
    //         Padding(
    //           padding: EdgeInsets.only(
    //             top: 20.h,
    //           ),
    //           child: EvTicketCard(
    //             iconPath: 'assets/images/drawer/polling.png',
    //             title: 'Question',
    //             vihicelname: 'Mess Management',
    //             date: "9th Mar, 2024 - 9th Mar, 2024",
    //             time: "10:30 AM - 01:00 PM",
    //           ),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}

// GroupStatus Tab
class GroupTab extends StatelessWidget {
  const GroupTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity.w,
        height: 510.h,
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: const [
              BoxShadow(color: AppColor.grey3, spreadRadius: 1, blurRadius: 1)
            ]),
        padding: EdgeInsets.only(left: 11.w, right: 11.w, top: 16.h),
        child: Center(
          child: Text(
            "Group Comming Soon.",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: 3,
        //   itemBuilder: (context, index) {
        //     return Column(
        //       children: [
        //         SizedBox(
        //           height: 2.h,
        //         ),
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             CircleAvatar(),
        //             SizedBox(
        //               width: 15.w,
        //             ),
        //             Container(
        //               width: 200.w,
        //               // height: 300.h,
        //               decoration: BoxDecoration(
        //                 color: AppColor.white,
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: AppColor.primary.withOpacity(0.7),
        //                     spreadRadius: 1,
        //                     blurRadius: 1,
        //                     offset: Offset(-1, -1),
        //                   ),
        //                   BoxShadow(
        //                     color: AppColor.primary.withOpacity(0.7),
        //                     spreadRadius: 1,
        //                     blurRadius: 1,
        //                     offset: Offset(1, 0),
        //                   ),
        //                   BoxShadow(
        //                     color: AppColor.grey2.withOpacity(0.2),
        //                     spreadRadius: 1,
        //                     blurRadius: 2,
        //                     offset: Offset(1, 2),
        //                   ),
        //                   BoxShadow(
        //                     color: AppColor.grey2.withOpacity(0.2),
        //                     spreadRadius: 1,
        //                     blurRadius: 2,
        //                     offset: Offset(-1, 2),
        //                   ),
        //                 ],
        //                 borderRadius: BorderRadius.only(
        //                     topRight: Radius.circular(10.r),
        //                     bottomLeft: Radius.circular(10.r),
        //                     bottomRight: Radius.circular(10.r)),
        //               ),
        //               child: Padding(
        //                 padding: EdgeInsets.all(8.0),
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Padding(
        //                       padding: EdgeInsets.symmetric(horizontal: 10.w),
        //                       child: Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text(
        //                             "Anshul Gurnani",
        //                             style: AppTextTheme.textTheme.displayLarge
        //                                 ?.copyWith(
        //                                     fontSize: 13,
        //                                     fontWeight: FontWeight.w700,
        //                                     color: AppColor.primary),
        //                           ),
        //                           SizedBox(
        //                             height: 10.h,
        //                           ),
        //                           Text(
        //                             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
        //                             textAlign: TextAlign.justify,
        //                             style: AppTextTheme.textTheme.displayLarge
        //                                 ?.copyWith(
        //                                     fontSize: 13,
        //                                     fontWeight: FontWeight.w400,
        //                                     color: AppColor.primary),
        //                           ),
        //                           SizedBox(height: 10.h),
        //                           Row(
        //                             mainAxisAlignment: MainAxisAlignment.end,
        //                             children: [
        //                               Text(
        //                                 "11:00 pm",
        //                                 textAlign: TextAlign.end,
        //                                 style: AppTextTheme
        //                                     .textTheme.displayLarge
        //                                     ?.copyWith(
        //                                         fontSize: 13,
        //                                         fontWeight: FontWeight.w700,
        //                                         color: AppColor.grey3),
        //                               ),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 20.h,
        //         )
        //       ],
        //     );
        //   },
        // ),
      ),
    );
  }
}

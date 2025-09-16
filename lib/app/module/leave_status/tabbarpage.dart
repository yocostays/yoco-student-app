import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';

import 'package:yoco_stay_student/app/module/leave_status/views/Approved_page.dart';
import 'package:yoco_stay_student/app/module/leave_status/views/Rejected_page.dart';
import 'package:yoco_stay_student/app/module/leave_status/views/pending_page.dart';

class LeaveStatusPage extends StatefulWidget {
  final bool leave;
  const LeaveStatusPage({super.key, required this.leave});

  @override
  State<LeaveStatusPage> createState() => _LeaveStatusStatePage();
}

class _LeaveStatusStatePage extends State<LeaveStatusPage>
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
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            height: 40.h,
            width: MediaQuery.of(context).size.width * 0.88,
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
              labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'Approved'),
                Tab(text: 'Rejected'),
              ],
              indicatorPadding: const EdgeInsets.all(2),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    20.r), // Creates border for the tab bar
                color: AppColor.primary, // Change background color from here
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
              children: [
                LeavePendingPage(
                  leave: widget.leave,
                ),
                LeaveApprovedPage(
                  leave: widget.leave,
                ),
                LeaveRejectPage(
                  leave: widget.leave,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

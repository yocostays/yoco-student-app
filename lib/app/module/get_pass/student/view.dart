import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/get_pass/pending_resolved_rejecte/approved.dart';
import 'package:yoco_stay_student/app/module/get_pass/pending_resolved_rejecte/pending.dart';
import 'package:yoco_stay_student/app/module/get_pass/pending_resolved_rejecte/rejected.dart';
import 'package:yoco_stay_student/app/globals.dart' as globals;

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage>
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
    return Column(
      children: [
        Container(
          height: 40.h,
          width: globals.globalheight * 0.88,
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
              borderRadius:
                  BorderRadius.circular(20.r), // Creates border for the tab bar
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
            children: const [
              PendingPage(),
              ApprovedPassPage(),
              RejectedPassPage()
            ],
          ),
        ),
      ],
    );
  }
}

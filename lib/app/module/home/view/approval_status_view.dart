import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';
import 'package:yoco_stay_student/app/module/leave_status/widgets/leave_status_page.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';
import 'package:yoco_stay_student/app/widgets/useble_component/approval_qrcode.dart';

class ApprovalStatusPage extends StatefulWidget {
  const ApprovalStatusPage({super.key});

  @override
  State<ApprovalStatusPage> createState() => _ApprovalStatusPageState();
}

class _ApprovalStatusPageState extends State<ApprovalStatusPage>
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
      appBar: CustomAppBar(
          titlewidget: Text(
            "APPROVAL STATUS",
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColor.white, fontSize: 15),
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
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Pending'),
                        Tab(text: 'Approved'),
                      ],
                      indicatorPadding: const EdgeInsets.all(1),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            50), // Creates border for the tab bar
                        color: AppColor
                            .primary, // Change background color from here
                      ),
                      labelColor: AppColor.white,
                      unselectedLabelColor: AppColor.primary,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        PendingStatus(),
                        ApprovedStaus(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: CenterButton(),
      // bottomNavigationBar: BottomNavigation(),
    );
  }
}

class PendingStatus extends StatefulWidget {
  const PendingStatus({super.key});

  @override
  State<PendingStatus> createState() => _PendingStatusState();
}

class _PendingStatusState extends State<PendingStatus> {
  final LeaveController _leavecontroller = Get.put(LeaveController());
  final ScrollController _scrollController = ScrollController();

@override
void initState() {
  super.initState();

  // Defer API call until after first frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _leavecontroller.GetAllLeaveDataList("pending", "all", false);
  });

  // Scroll listener for pagination
  _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _leavecontroller.GetAllLeaveDataList("pending", "all", true); // Load more
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Using WidgetsBinding to avoid calling setState in the build cycle
      if (_leavecontroller.leaveListloading.value) {
        return const Loader();
      } else if (_leavecontroller.AllLeaveListData.isEmpty) {
        return Center(
          child: Text(
            "No Leave Application Found.",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
          ),
        );
      } else {
        return ListView.builder(
          controller: _scrollController,
          itemCount: _leavecontroller.AllLeaveListData.length +
              1, // Add one for the loading indicator
          itemBuilder: (context, index) {
            if (index < _leavecontroller.AllLeaveListData.length) {
              return _buildLeaveItem(index);
            } else {
              return Obx(() => _leavecontroller.leaveListloading.value
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox.shrink());
            }
          },
        );
      }
    });
  }

  Widget _buildLeaveItem(int index) {
    final leaveData = _leavecontroller.AllLeaveListData[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16.h),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LeaveStatusDilogBox(leaveId: leaveData.sId ?? "");
                    },
                  );
                },
                child: TicketCard(
                  iconPath: "assets/images/drawer/leave.png",
                  title: leaveData.category ??
                      leaveData.description ??
                      "".toUpperCase(),
                  ticketId: leaveData.ticketId ?? "",
                  date: leaveData.days == 1
                      ? Utils.formatDatebynd(
                          DateTime.parse(leaveData.startDate ?? ""))
                      : '${Utils.formatDatebynd(DateTime.parse(leaveData.startDate ?? ""))} to ${Utils.formatDatebynd(DateTime.parse(leaveData.endDate ?? ""))}',
                  dateFontSize: 12,
                  time: leaveData.leaveType == "late coming"
                      ? '${leaveData.hours} Hours'
                      : leaveData.days == 1
                          ? '${leaveData.days} Day'
                          : '${leaveData.days} Days',
                  timeFontSize: 12,
                ),
              ),
            ],
          ),
          Positioned(
            right: 10,
            top: 25,
            child: InkWell(
              onTap: () {
                _showLogoutDialog(context, leaveData.sId ?? "");
              },
              child: const Icon(
                Icons.close,
                size: 25,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you sure to remove this Leave?",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppColor.textblack,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            CustomButton(
              Title: "Yes",
              ontap: () async {
                _leavecontroller.AllRemoveLeave(id);
              },
              width: 100.w,
              BoxColor: AppColor.primary,
              textcolor: AppColor.white,
              Textsize: 20,
            ),
            CustomButton(
              Title: "No",
              ontap: () {
                Get.back();
              },
              width: 100.w,
              BoxColor: AppColor.primary,
              textcolor: AppColor.white,
              Textsize: 20,
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class ApprovedStaus extends StatefulWidget {
  const ApprovedStaus({super.key});

  @override
  State<ApprovedStaus> createState() => _ApprovedStausState();
}

class _ApprovedStausState extends State<ApprovedStaus> {
  final LeaveController _leavecontroller = Get.put(LeaveController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _leavecontroller.GetAllApprovedLeaveDataList("approved", "all", false);

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      // Check if the scroll is at the bottom
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Trigger loading more data
        if (!_leavecontroller.GetApprovedleaveListloading.value) {
          _leavecontroller.GetAllApprovedLeaveDataList("approved", "all", true); // Load more data
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _leavecontroller.GetApprovedleaveListloading.value
          ? const Loader()
          : _leavecontroller.GetAllApprovedleaveListloading.isNotEmpty
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: _leavecontroller.GetAllApprovedleaveListloading.length + 1, // Add one for the loading indicator
                  itemBuilder: (context, index) {
                    if (index < _leavecontroller.GetAllApprovedleaveListloading.length) {
                      return _buildLeaveItem(index);
                    } else {
                      // Show loading indicator at the bottom of the list
                      return _leavecontroller.GetApprovedleaveListloading.value
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox.shrink();
                    }
                  },
                )
              : Center(
                  child: Text(
                    "No Leave Application Found.",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
    );
  }

  Widget _buildLeaveItem(int index) {
    final leaveData = _leavecontroller.GetAllApprovedleaveListloading[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          InkWell(
            onTap: () {
              _leavecontroller.GetLeaveDataDetails(leaveData.sId ?? "");
              _leavecontroller.selectedindex.value =
                  _leavecontroller.selectedindex.value == index + 1 ? 0 : index + 1;
            },
            child: TicketCard(
              iconPath: "assets/images/drawer/leave.png",
              title: leaveData.category ?? leaveData.description ?? "".toUpperCase(),
              ticketId: leaveData.ticketId ?? "",
              date: leaveData.days == 1
                  ? Utils.formatDatebynd(DateTime.parse(leaveData.startDate ?? ""))
                  : '${Utils.formatDatebynd(DateTime.parse(leaveData.startDate ?? ""))} to ${Utils.formatDatebynd(DateTime.parse(leaveData.endDate ?? ""))}',
              dateFontSize: 12,
              time: leaveData.leaveType == "late coming"
                  ? '${leaveData.hours} Hours'
                  : leaveData.days == 1
                      ? '${leaveData.days} Day'
                      : '${leaveData.days} Days',
              timeFontSize: 12,
            ),
          ),
          if (_leavecontroller.selectedindex == index + 1) SizedBox(height: 5.h),
          if (_leavecontroller.selectedindex == index + 1)
            Obx(() => PassQrCode(
                  loading: _leavecontroller.DayOutApprovedloading.value,
                  gatepassnumber: _leavecontroller.leaveapprovedData.value.gatepassNumber,
                )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

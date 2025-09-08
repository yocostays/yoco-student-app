import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

class LeaveRejectPage extends StatefulWidget {
  final bool leave;
  const LeaveRejectPage({super.key, required this.leave});

  @override
  State<LeaveRejectPage> createState() => _LeaveRejectPageState();
}

class _LeaveRejectPageState extends State<LeaveRejectPage>
    with SingleTickerProviderStateMixin {
  final LeaveController _leavecontroller = Get.put(LeaveController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ScrollController _scrollController;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scrollController = ScrollController()..addListener(_scrollListener);

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _leavecontroller.getpasstabController.index == 0
          ? _leavecontroller.GetRejectedLeaveListData("rejected", "leave", false)
          : _leavecontroller.GetRejectedLeaveListData("rejected", "late coming", false);

      Future.delayed(const Duration(milliseconds: 100), () {
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Future.delayed(const Duration(seconds: 1), () {
        _loadMoreData();
      });
    }
  }

  Future<void> _loadMoreData() async {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });

      _leavecontroller.getpasstabController.index == 0
          ? _leavecontroller.GetRejectedLeaveListData("rejected", "leave", true)
          : _leavecontroller.GetRejectedLeaveListData("rejected", "late coming", true);

      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (_leavecontroller.RejectedleaveListloading.value) {
          return AnimatedList(
            key: _listKey,
            initialItemCount: 8,
            itemBuilder: (context, index, animation) {
              return _loderItem(context, index, animation);
            },
          );
        } else if (_leavecontroller.RejectedLeaveListData.isEmpty) {
          return _leavecontroller.getpasstabController.index == 1
              ? Center(
                  child: Text(
                    "There no Late coming Data.",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
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
                );
        } else {
          return AnimatedList(
            key: _listKey,
            initialItemCount: _leavecontroller.RejectedLeaveListData.length,
            itemBuilder: (context, index, animation) {
              if (index < _leavecontroller.RejectedLeaveListData.length) {
                return _buildItem(context, index, animation);
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        }
      }),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    final leaveData = _leavecontroller.RejectedLeaveListData[index];

    // ✅ Convert UTC → Local before formatting
    DateTime? startDate = leaveData.startDate != null
        ? DateTime.parse(leaveData.startDate!).toLocal()
        : null;
    DateTime? endDate = leaveData.endDate != null
        ? DateTime.parse(leaveData.endDate!).toLocal()
        : null;

    String dateText = "";
    if (leaveData.days == 1) {
      dateText = startDate != null ? Utils.formatDatebynd(startDate) : "";
    } else {
      dateText =
          "${startDate != null ? Utils.formatDatebynd(startDate) : ""} to ${endDate != null ? Utils.formatDatebynd(endDate) : ""}";
    }

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              TicketCard(
                iconPath: widget.leave == true
                    ? "assets/images/drawer/leave.png"
                    : "assets/icons/late_entry.png",
                title: leaveData.category ??
                    leaveData.description ??
                    "".toUpperCase(),
                ticketId: leaveData.ticketId,
                date: dateText,
                dateFontSize: 12,
                time: leaveData.leaveType == "late coming"
                    ? '${leaveData.hours} Hours'
                    : leaveData.days == 1
                        ? '${leaveData.days} Day'
                        : '${leaveData.days} Days',
                timeFontSize: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loderItem(
      BuildContext context, int index, Animation<double> animation) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 16.h),
                  CustomShimmer(
                    height: MediaQuery.of(context).size.height * 0.14,
                  )
                ],
              ),
              Positioned(
                right: 10,
                top: 25,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.close,
                    size: 25,
                    weight: 20.sp,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

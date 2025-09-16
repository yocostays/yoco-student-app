import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';
import 'package:yoco_stay_student/app/module/leave_status/views/leave_from.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';
import 'package:yoco_stay_student/app/widgets/useble_component/approval_qrcode.dart';

class LeaveApprovedPage extends StatefulWidget {
  final bool leave;
  const LeaveApprovedPage({super.key, required this.leave});

  @override
  State<LeaveApprovedPage> createState() => _LeaveApprovedPageState();
}

class _LeaveApprovedPageState extends State<LeaveApprovedPage>
    with SingleTickerProviderStateMixin {
  final LeaveController _leavecontroller = Get.put(LeaveController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ScrollController _scrollController;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  bool isLoadingMore = false;

  int selectedindex = 0;

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
          ? _leavecontroller.GetApprovedLeaveListData("approved", "leave", false)
          : _leavecontroller.GetApprovedLeaveListData("approved", "late coming", false);

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
          ? _leavecontroller.GetApprovedLeaveListData("approved", "leave", true)
          : _leavecontroller.GetApprovedLeaveListData("approved", "late coming", true);

      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        /// 1. LOADING STATE
        if (_leavecontroller.ApprovedleaveListloading.value) {
          return AnimatedList(
            key: _listKey,
            initialItemCount: 8,
            itemBuilder: (context, index, animation) {
              return _loderItem(context, index, animation);
            },
          );
        }

        /// 2. EMPTY STATE
        if (_leavecontroller.ApprovedLeaveListData.isEmpty) {
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
        }

        /// 3. DATA LIST
        return AnimatedList(
          key: _listKey,
          initialItemCount: _leavecontroller.ApprovedLeaveListData.length,
          itemBuilder: (context, index, animation) {
            if (index < _leavecontroller.ApprovedLeaveListData.length) {
              return _buildItem(context, index, animation);
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      }),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    if (index >= _leavecontroller.ApprovedLeaveListData.length) {
      return const SizedBox.shrink();
    }

    final item = _leavecontroller.ApprovedLeaveListData[index];

    final startDate =
        item.startDate != null ? DateTime.parse(item.startDate!).toLocal() : null;
    final endDate =
        item.endDate != null ? DateTime.parse(item.endDate!).toLocal() : null;

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 8),
          child: Stack(
            children: [
              SizedBox(height: 16.h),
              InkWell(
                onTap: () {
                  _leavecontroller.GetLeaveDataDetails(item.sId ?? "");
                  setState(() {
                    selectedindex == index + 1
                        ? selectedindex = 0
                        : selectedindex = index + 1;
                  });
                },
                child: TicketCard(
                  iconPath: widget.leave
                      ? "assets/images/drawer/leave.png"
                      : "assets/icons/late_entry.png",
                  title: item.category ?? item.description ?? "".toUpperCase(),
                  ticketId: item.ticketId ?? "",
                  date: item.days == 1
                      ? Utils.formatDatebynd(startDate!)
                      : '${Utils.formatDatebynd(startDate!)} to ${Utils.formatDatebynd(endDate!)}',
                  dateFontSize: 12,
                  time: item.leaveType == "late coming"
                      ? '${item.hours} Hours'
                      : item.days == 1
                          ? '${item.days} Day'
                          : '${item.days} Days',
                  timeFontSize: 12,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: InkWell(
                  onTap: () =>  _leavecontroller.getpasstabController.index == 0
                ? Get.to(() => const LeaveFromPage(leave: true))
                : Get.to(() => const LeaveFromPage(leave: false)),
                  child: Container(
                    height: 20.w,
                    width: 20.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(shape: BoxShape.rectangle,color: AppColor.primary,borderRadius: BorderRadius.circular(5)),
                   
                     child:  const Icon(Icons.edit, size: 15, color: AppColor.white)),
                ),
              ),
           
              if (selectedindex == index + 1) SizedBox(height: 5.h),
              if (selectedindex == index + 1)
                /// 👇 Wrap only the QR Code in Obx since it uses reactive vars
                Obx(() => PassQrCode(
                      loading: _leavecontroller.DayOutApprovedloading.value,
                      gatepassnumber:
                          _leavecontroller.leaveapprovedData.value.gatepassNumber,
                    ))
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

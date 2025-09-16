import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';
import 'package:yoco_stay_student/app/module/leave_status/views/leave_from.dart';
import 'package:yoco_stay_student/app/module/leave_status/widgets/leave_status_page.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

class LeavePendingPage extends StatefulWidget {
  final bool leave;
  const LeavePendingPage({super.key, required this.leave});

  @override
  State<LeavePendingPage> createState() => _LeavePendingPageState();
}

class _LeavePendingPageState extends State<LeavePendingPage>
    with SingleTickerProviderStateMixin {
  final LeaveController _leavecontroller = Get.put(LeaveController());
  late ScrollController _scrollController;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // ✅ Run after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_leavecontroller.getpasstabController.index == 0) {
        _leavecontroller.getLeaveDataList("pending", "leave", loadMore: false);
      } else {
        _leavecontroller.getLeaveDataList("pending", "late coming", loadMore: false);
      }

      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (_leavecontroller.hasMoreData.value &&
        !_leavecontroller.isMoreLoading.value &&
        !_leavecontroller.leaveListloading.value) {
      if (_leavecontroller.getpasstabController.index == 0) {
        await _leavecontroller.getLeaveDataList("pending", "leave", loadMore: true);
      } else {
        await _leavecontroller.getLeaveDataList("pending", "late coming", loadMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () async {
            _leavecontroller.getpasstabController.index == 0
                ? Get.to(() => const LeaveFromPage(leave: true))
                : Get.to(() => const LeaveFromPage(leave: false));
          },
          child: Icon(Icons.add, size: 30.h, color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (_leavecontroller.leaveListloading.value) {
          return ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) => _loderItem(context, index),
          );
        }

        if (_leavecontroller.LeaveListData.isEmpty) {
          return Center(
            child: Text(
              _leavecontroller.getpasstabController.index == 1
                  ? "There is no Late coming Data."
                  : "No Leave Application Found.",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColor.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: _leavecontroller.LeaveListData.length + 1,
          itemBuilder: (context, index) {
            if (index < _leavecontroller.LeaveListData.length) {
              return _buildItem(context, index);
            } else {
              if (_leavecontroller.isMoreLoading.value) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (!_leavecontroller.hasMoreData.value) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "No more data",
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }
          },
        );
      }),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final item = _leavecontroller.LeaveListData[index];

    final startDate = item.startDate != null
        ? DateTime.parse(item.startDate!).toLocal()
        : null;
    final endDate = item.endDate != null
        ? DateTime.parse(item.endDate!).toLocal()
        : null;

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        LeaveStatusDilogBox(leaveId: item.sId ?? ""),
                  );
                },
                child: TicketCard(
                  iconPath: widget.leave
                      ? "assets/images/drawer/leave.png"
                      : "assets/icons/late_entry.png",
                  title: item.category ??
                      item.description ??
                      "".toUpperCase(),
                  ticketId: item.ticketId,
                  // ✅ Always show range if start != end
                  date: (startDate != null && endDate != null)
                      ? (startDate.isAtSameMomentAs(endDate)
                          ? Utils.formatDatebynd(startDate)
                          : '${Utils.formatDatebynd(startDate)} to ${Utils.formatDatebynd(endDate)}')
                      : '',
                  dateFontSize: 12,
                  time: item.leaveType == "late coming"
                      ? '${item.hours} Hours'
                      : '${item.days} Day${item.days! > 1 ? 's' : ''}',
                  timeFontSize: 12,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: InkWell(
                  onTap: () => _showLogoutDialog(context, item.sId ?? ""),
                  child: const Icon(Icons.close, size: 25, color: AppColor.primary),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _loderItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      child: CustomShimmer(
        height: MediaQuery.of(context).size.height * 0.14,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          "Are you Sure to Remove This Leave?",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColor.textblack,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          CustomButton(
            Title: "Yes",
            ontap: () => _leavecontroller.RemoveLeave(id),
            width: 100.w,
            BoxColor: AppColor.primary,
            textcolor: AppColor.white,
            Textsize: 20,
          ),
          CustomButton(
            Title: "No",
            ontap: () => Get.back(),
            width: 100.w,
            BoxColor: AppColor.primary,
            textcolor: AppColor.white,
            Textsize: 20,
          ),
        ],
      ),
    );
  }
}

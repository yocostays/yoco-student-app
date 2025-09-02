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
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // final List<int> _items = List<int>.generate(6, (int index) => index);
  late ScrollController _scrollController;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _leavecontroller.getpasstabController.index == 0
        ? _leavecontroller.GetLeaveDataList(
            "pending", "leave", false) // true is load more option
        : _leavecontroller.GetLeaveDataList(
            "pending", "late coming", false); // true is load more option
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
          ? _leavecontroller.GetLeaveDataList(
              "pending", "leave", false) // true is load more option
          : _leavecontroller.GetLeaveDataList(
              "pending", "late coming", false); // true is load more option
      Future.delayed(const Duration(milliseconds: 100), () {
        _controller.forward(); // Trigger the animation after a slight delay
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
      print("loade more");

      // Fetch more data
      _leavecontroller.getpasstabController.index == 0
          ? _leavecontroller.GetLeaveDataList(
              "pending", "leave", true) // true is load more option
          : _leavecontroller.GetLeaveDataList(
              "pending", "late coming", true); // true is load more option

      setState(() {
        isLoadingMore = false;
      });
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
                ? Get.to(() => const LeaveFromPage(
                      leave: true,
                    ))
                : Get.to(() => const LeaveFromPage(
                      leave: false,
                    ));
          },
          child: Icon(
            Icons.add,
            size: 30.h,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        // Avoid unnecessary controller state updates within the build phase
        if (_leavecontroller.leaveListloading.value) {
          return AnimatedList(
            key: _listKey,
            initialItemCount: 8,
            itemBuilder: (context, index, animation) {
              return _loderItem(context, index, animation);
            },
          );
        } else if (_leavecontroller.LeaveListData.isEmpty) {
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
          // Ensure any AnimatedList actions happen after the widget is built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // If needed, you can perform additional checks or updates here
          });

          return _leavecontroller.getpasstabController.index == 1
              ? AnimatedList(
                  key: _listKey,
                  initialItemCount: _leavecontroller.LeaveListData
                      .length, // Ensure this matches the list size
                  itemBuilder: (context, index, animation) {
                    if (index < _leavecontroller.LeaveListData.length) {
                      return _buildItem(context, index, animation);
                    } else {
                      return const SizedBox
                          .shrink(); // Return an empty widget for invalid indices
                    }
                  },
                )
              : AnimatedList(
                  key: _listKey,
                  initialItemCount: _leavecontroller.LeaveListData
                      .length, // Ensure this matches the list size
                  itemBuilder: (context, index, animation) {
                    if (index < _leavecontroller.LeaveListData.length) {
                      return _buildItem(context, index, animation);
                    } else {
                      return const SizedBox
                          .shrink(); // Return an empty widget for invalid indices
                    }
                  },
                );
        }
      }),
    );
  }

  Widget _buildItem(
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
                  SizedBox(
                    height: 16.h,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LeaveStatusDilogBox(
                            leaveId:
                                _leavecontroller.LeaveListData[index].sId ?? "",
                          );
                        },
                      );
                    },
                    child: TicketCard(
                      iconPath: widget.leave == true
                          ? "assets/images/drawer/leave.png"
                          : "assets/icons/late_entry.png",
                      title: _leavecontroller.LeaveListData[index].category ??
                          _leavecontroller.LeaveListData[index].description ??
                          "".toUpperCase(),
                      ticketId: _leavecontroller.LeaveListData[index].ticketId,
                      date: _leavecontroller.LeaveListData[index].days == 1
                          ? Utils.formatDatebynd(DateTime.parse(
                              _leavecontroller.LeaveListData[index].startDate ??
                                  ""))
                          : '${Utils.formatDatebynd(DateTime.parse(_leavecontroller.LeaveListData[index].startDate ?? ""))} to ${Utils.formatDatebynd(DateTime.parse(_leavecontroller.LeaveListData[index].endDate ?? ""))} ',
                      dateFontSize: 12,
                      time: _leavecontroller.LeaveListData[index].leaveType ==
                              "late coming"
                          ? '${_leavecontroller.LeaveListData[index].hours} Hours'
                          : _leavecontroller.LeaveListData[index].days == 1
                              ? '${_leavecontroller.LeaveListData[index].days} Day'
                              : '${_leavecontroller.LeaveListData[index].days} Days',
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
                    setState(() {
                      _showLogoutDialog(context,
                          _leavecontroller.LeaveListData[index].sId ?? "");
                    });
                  },
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
                  SizedBox(
                    height: 16.h,
                  ),
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

  void _showLogoutDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you Sure to Remove This Complaint?",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColor.textblack,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            CustomButton(
              Title: "Yes",
              ontap: () async {
                _leavecontroller.RemoveLeave(id);
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
}

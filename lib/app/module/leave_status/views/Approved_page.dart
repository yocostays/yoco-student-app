import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';
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
  // final List<int> _items = List<int>.generate(6, (int index) => index);
  late ScrollController _scrollController;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  bool isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    // _leavecontroller.GetLeaveDataList("approved", "leave");
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
          ? _leavecontroller.GetApprovedLeaveListData(
              "approved", "leave", false) // true/false is dor loadmore data
          : _leavecontroller.GetApprovedLeaveListData("approved", "late coming",
              false); // true/false is dor loadmore data
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
          ? _leavecontroller.GetApprovedLeaveListData(
              "approved", "leave", true) // true/false is dor loadmore data
          : _leavecontroller.GetApprovedLeaveListData("approved", "late coming",
              true); // true/false is dor loadmore data

      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // Avoid unnecessary controller state updates within the build phase
        if (_leavecontroller.ApprovedleaveListloading.value) {
          return AnimatedList(
            key: _listKey,
            initialItemCount: 8,
            itemBuilder: (context, index, animation) {
              return _loderItem(context, index, animation);
            },
          );
        } else if (_leavecontroller.ApprovedLeaveListData.isEmpty) {
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
                  initialItemCount: _leavecontroller.ApprovedLeaveListData
                      .length, // Ensure this matches the list size
                  itemBuilder: (context, index, animation) {
                    if (index < _leavecontroller.ApprovedLeaveListData.length) {
                      return _buildItem(context, index, animation);
                    } else {
                      return const SizedBox
                          .shrink(); // Return an empty widget for invalid indices
                    }
                  },
                )
              : AnimatedList(
                  key: _listKey,
                  initialItemCount: _leavecontroller.ApprovedLeaveListData
                      .length, // Ensure this matches the list size
                  itemBuilder: (context, index, animation) {
                    print(
                        "hhehbe : ${_leavecontroller.ApprovedLeaveListData.length} and : $index");
                    if (index < _leavecontroller.ApprovedLeaveListData.length) {
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

  int selectedindex = 0;
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    if (index >= _leavecontroller.ApprovedLeaveListData.length) {
      return const SizedBox.shrink(); // Prevent access if index is out of range
    }
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                InkWell(
                  onTap: () {
                    _leavecontroller.GetLeaveDataDetails(
                        _leavecontroller.ApprovedLeaveListData[index].sId ??
                            "");
                    setState(() {
                      selectedindex == index + 1
                          ? selectedindex = 0
                          : selectedindex = index + 1;
                    });
                  },
                  child: TicketCard(
                    iconPath: widget.leave == true
                        ? "assets/images/drawer/leave.png"
                        : "assets/icons/late_entry.png",
                    title: _leavecontroller
                            .ApprovedLeaveListData[index].category ??
                        _leavecontroller
                            .ApprovedLeaveListData[index].description ??
                        "".toUpperCase(),
                    ticketId: _leavecontroller
                            .ApprovedLeaveListData[index].ticketId ??
                        "",
                    date: (_leavecontroller.ApprovedLeaveListData.isNotEmpty &&
                            index <
                                _leavecontroller.ApprovedLeaveListData.length)
                        ? (_leavecontroller.ApprovedLeaveListData[index].days ==
                                1
                            ? Utils.formatDatebynd(DateTime.parse(
                                _leavecontroller.ApprovedLeaveListData[index]
                                        .startDate ??
                                    ""))
                            : '${Utils.formatDatebynd(DateTime.parse(_leavecontroller.ApprovedLeaveListData[index].startDate ?? ""))} to ${Utils.formatDatebynd(DateTime.parse(_leavecontroller.ApprovedLeaveListData[index].endDate ?? ""))}')
                        : '',

                    //  _leavecontroller.ApprovedLeaveListData[index].days == 1
                    //     ? '${Utils.formatDatebynd(DateTime.parse(_leavecontroller.ApprovedLeaveListData[index].startDate ?? ""))}'
                    //     : '${Utils.formatDatebynd(DateTime.parse(_leavecontroller.ApprovedLeaveListData[index].startDate ?? ""))} to ${Utils.formatDatebynd(DateTime.parse(_leavecontroller.LeaveListData[index].endDate ?? ""))} ',
                    dateFontSize: 12,
                    time: _leavecontroller
                                .ApprovedLeaveListData[index].leaveType ==
                            "late coming"
                        ? '${_leavecontroller.ApprovedLeaveListData[index].hours} Hours'
                        : _leavecontroller.ApprovedLeaveListData[index].days ==
                                1
                            ? '${_leavecontroller.ApprovedLeaveListData[index].days} Day'
                            : '${_leavecontroller.ApprovedLeaveListData[index].days} Days',
                    timeFontSize: 12,
                  ),
                ),
                if (selectedindex == index + 1)
                  SizedBox(
                    height: 5.h,
                  ),
                if (selectedindex == index + 1)
                  PassQrCode(
                    loading: _leavecontroller.DayOutApprovedloading.value,
                    gatepassnumber:
                        _leavecontroller.leaveapprovedData.value.gatepassNumber,
                  )
              ],
            ),
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
}

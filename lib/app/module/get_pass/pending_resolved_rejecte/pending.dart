import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/get_pass/repository.dart';
import 'package:yoco_stay_student/app/module/get_pass/student/student_form.dart';
import 'package:yoco_stay_student/app/module/leave_status/widgets/leave_status_page.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({super.key});

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage>
    with SingleTickerProviderStateMixin {
  final GetPassController getPassController = Get.put(GetPassController());
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
    getPassController.GayOutDataList(
        "pending", "day out", false); // fasle is load more
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
      getPassController.GayOutDataList(
          "pending", "day out", false); // fasle is load more
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
      await getPassController.GayOutDataList("pending", "day out", true);

      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () async {
            getPassController.getpasstabController.index == 0
                ? Get.to(() => const PassFromPage())
                : 0;
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
        if (getPassController.DayOutListloading.value) {
          return AnimatedList(
            key: _listKey,
            initialItemCount: 8,
            itemBuilder: (context, index, animation) {
              return _loderItem(context, index, animation);
            },
          );
        } else if (getPassController.PendingDayOutListData.isEmpty) {
          return Center(
            child: Text(
              "No Day Out/Night Out Found.",
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

          return getPassController.getpasstabController.index == 1
              ? Center(
                  child: Text(
                    "No Visitor Data Found.",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                )
              : AnimatedList(
                  key: _listKey,
                  controller: _scrollController,
                  initialItemCount: getPassController.PendingDayOutListData
                      .length, // Ensure this matches the list size
                  itemBuilder: (context, index, animation) {
                    if (index <
                        getPassController.PendingDayOutListData.length) {
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
                              leaveId: getPassController
                                      .PendingDayOutListData[index].sId ??
                                  "",
                            );
                          },
                        );
                      },
                      child: TicketCard(
                        iconPath: getPassController
                                    .getpasstabController.index ==
                                0
                            ? "assets/images/get_pass/Student app_Icon-04 2.png"
                            : "assets/images/get_pass/6306475 1.png",
                        title: getPassController
                            .PendingDayOutListData[index].category!
                            .toUpperCase(),
                        ticketId: getPassController
                            .PendingDayOutListData[index].ticketId,
                        date: Utils.formatDatebynd(DateTime.parse(
                            getPassController
                                    .PendingDayOutListData[index].startDate ??
                                "")),
                        dateFontSize: 12,
                        time: getPassController
                                    .PendingDayOutListData[index].hours ==
                                "1:00"
                            ? '${getPassController.PendingDayOutListData[index].hours} Hour'
                            : '${getPassController.PendingDayOutListData[index].hours} Hours',
                        timeFontSize: 12,
                      )),
                ],
              ),
              Positioned(
                right: 10,
                top: 25,
                child: InkWell(
                  onTap: () {
                    _showLogoutDialog(
                        context,
                        getPassController.PendingDayOutListData[index].sId ??
                            "");
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
                getPassController.Removedayout(id);
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

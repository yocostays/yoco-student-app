// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/get_pass/repository.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';
import 'package:yoco_stay_student/app/widgets/useble_component/approval_qrcode.dart';

class ApprovedPassPage extends StatefulWidget {
  const ApprovedPassPage({super.key});

  @override
  State<ApprovedPassPage> createState() => _ApprovedPassPageState();
}

class _ApprovedPassPageState extends State<ApprovedPassPage>
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
        "approved", "day out", false); // fasle is load more
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
          "approved", "day out", false); // fasle is load more
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

  int selectedindex = 0;
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
      await getPassController.GayOutDataList("approved", "day out", true);

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
        if (getPassController.DayOutListloading.value) {
          return AnimatedList(
            key: _listKey,
            initialItemCount: 8,
            itemBuilder: (context, index, animation) {
              return _loderItem(context, index, animation);
            },
          );
        } else if (getPassController.ApprovedDayOutListData.isEmpty) {
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
                  initialItemCount: getPassController.ApprovedDayOutListData
                      .length, // Ensure this matches the list size
                  itemBuilder: (context, index, animation) {
                    if (index <
                        getPassController.ApprovedDayOutListData.length) {
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
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              InkWell(
                onTap: () async {
                  await getPassController.GetLeaveDataList(
                      getPassController.ApprovedDayOutListData[index].sId!);
                  setState(() {
                    selectedindex == index + 1
                        ? selectedindex = 0
                        : selectedindex = index + 1;
                  });
                },
                child: TicketCard(
                  iconPath: getPassController.getpasstabController.index == 0
                      ? "assets/images/get_pass/Student app_Icon-04 2.png"
                      : "assets/images/get_pass/6306475 1.png",
                  title: getPassController
                      .ApprovedDayOutListData[index].category!
                      .toUpperCase(),
                  ticketId:
                      getPassController.ApprovedDayOutListData[index].ticketId,
                  date: Utils.formatDatebynd(DateTime.parse(getPassController
                          .ApprovedDayOutListData[index].startDate ??
                      "")),
                  dateFontSize: 12,
                  time: getPassController.ApprovedDayOutListData[index].hours ==
                          "1:00"
                      ? '${getPassController.ApprovedDayOutListData[index].hours} Hour'
                      : '${getPassController.ApprovedDayOutListData[index].hours} Hours',
                  timeFontSize: 12,
                ),
              ),
              selectedindex == index + 1
                  ? SizedBox(
                      height: 5.h,
                    )
                  : SizedBox(
                      height: 0.h,
                    ),
              selectedindex == index + 1
                  ? PassQrCode(
                      loading: getPassController.DayOutApprovedloading.value,
                      gatepassnumber: getPassController
                          .DayOutapprovedData.value.gatepassNumber,
                    )
                  : Container(),
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
}

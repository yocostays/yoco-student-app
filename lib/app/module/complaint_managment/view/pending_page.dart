// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/controller/controller.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/utils.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/widgets/trackingbox.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';

import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

class PendingComplaintPage extends StatefulWidget {
  const PendingComplaintPage({super.key});

  @override
  _PendingComplaintPageState createState() => _PendingComplaintPageState();
}

class _PendingComplaintPageState extends State<PendingComplaintPage>
    with SingleTickerProviderStateMixin {
  final CompliantController controller = CompliantController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // final List<int> _items = List<int>.generate(6, (int index) => index);
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-hit the API each time you return to the page
    controller.GetComplaintedListData("pending");
  }

  @override
  void initState() {
    super.initState();
    controller.GetComplaintedListData("pending");
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

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

    _controller.forward();
  }

  void onResume() {
    // Re-hit the API when the page is resumed
    GetComplaintedListData();
  }

  void GetComplaintedListData() {
    // Your API call logic here
    controller.GetComplaintedListData("pending");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () async {
            // await compliantController.GetComplaintTypeList();
            Get.toNamed(AppRoute.complaintListpage);
            // Get.to(ComplaintSelectPage());
          },
          child: Icon(
            Icons.add,
            size: 30.h,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => controller.Complainteddataload.value == true
            ? AnimatedList(
                key: _listKey,
                initialItemCount: 8,
                itemBuilder: (context, index, animation) {
                  return _loderItem(context, index, animation);
                },
              )
            : controller.ComplaintStatusListdata.isEmpty
                ? Center(
                    child: Text(
                      "No Complaint Here.",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColor.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                : AnimatedList(
                    key: _listKey,
                    initialItemCount: controller.ComplaintStatusListdata.length,
                    itemBuilder: (context, index, animation) {
                      if (index < controller.ComplaintStatusListdata.length) {
                        return _buildItem(context, index, animation);
                      } else {
                        return const SizedBox
                            .shrink(); // Return an empty widget if out of bounds
                      }
                    },
                  ),
      ),
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
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ComplaintTimeLineDialogBox(
                              Complaintid: controller
                                      .ComplaintStatusListdata[index].sId ??
                                  "");
                        },
                      );
                    },
                    child: TicketCard(
                      iconPath: ComplaintUtils.getImageNameFromCategory(
                          controller.ComplaintStatusListdata[index].category ??
                              ""),
                      title:
                          controller.ComplaintStatusListdata[index].category ??
                              "",
                      ticketId:
                          controller.ComplaintStatusListdata[index].ticketId ??
                              "",
                      date: Utils.formatDatebynd(DateTime.parse(
                          "${controller.ComplaintStatusListdata[index].createdAt}")),
                      time: Utils.formatTimePass(DateTime.parse(
                          "${controller.ComplaintStatusListdata[index].createdAt}")),
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
                          controller.ComplaintStatusListdata[index].sId ?? "");
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
            "Are you sure you want to Remove This Leave?",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColor.textblack,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            CustomButton(
              Title: "Yes",
              ontap: () async {
                controller.RemoveComplaint(id, "pending");
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

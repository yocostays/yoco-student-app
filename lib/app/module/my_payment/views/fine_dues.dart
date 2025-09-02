import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/my_payment/controller.dart';
import 'package:yoco_stay_student/app/module/my_payment/model.dart';
import 'package:yoco_stay_student/app/module/my_payment/widgets/custom_ticket.dart';
import 'package:yoco_stay_student/app/module/my_payment/widgets/deselected_widgets.dart';
import 'package:yoco_stay_student/app/module/my_payment/widgets/fee_details_for_payment.dart';
import 'package:yoco_stay_student/app/module/my_payment/widgets/selected_widgets.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class FineduesPage extends StatefulWidget {
  const FineduesPage({super.key});

  @override
  State<FineduesPage> createState() => _FineduesPageState();
}

class _FineduesPageState extends State<FineduesPage>
    with SingleTickerProviderStateMixin {
  final MyPaymentController controller = Get.put(MyPaymentController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items =
      List<int>.generate(finedueslist.length, (int index) => index);
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  bool selecteddues = false;
  bool outstanding = false;
  bool totalselectdue = false;
  bool totalselectoutdate = false;
  int selectedticket = 0;

  @override
  void initState() {
    super.initState();
    selecteddues = false;
    outstanding = false;
    controller.Fineduestotal.value = 0;
    controller.Finedues.value = 0;
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "FINE DUES", trailingwidget: [
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
      body: SingleChildScrollView(
        child: stackcontainer(
          writedata: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ALL FINE DUES",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColor.grey3,
                          // fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.finedueSelecteallfile(totalselectdue);
                        });
                      },
                      child: Text(
                        "Select All",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.grey3,
                            // fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 373.h,
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _items.length,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(context, index, animation);
                  },
                ),
              ),
              Container(
                  width: double.infinity,
                  // color: Colors.amber,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Obx(
                    () => Column(
                      children: [
                        ListTile(
                          onTap: () {
                            setState(() {
                              outstanding == true
                                  ? {
                                      outstanding = false,
                                      controller.Finedues.value -=
                                          controller.Outstandingfee.value,
                                    }
                                  : {
                                      outstanding = true,
                                      controller.Finedues.value +=
                                          controller.Outstandingfee.value,
                                    };
                            });
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          leading: outstanding == true
                              ? const Selectedwidgets()
                              : const NotSelected(),
                          title: Text(
                            "Total Outstanding",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppColor.textblack,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "₹${controller.Fineduestotal.value}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppColor.textblack,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            setState(() {
                              selecteddues == true
                                  ? {
                                      totalselectdue = false,
                                      selecteddues = false,
                                      controller.Finedues.value = 0,
                                    }
                                  : {
                                      totalselectdue = true,
                                      selecteddues = true,
                                      controller.Finedues.value +=
                                          controller.SelectedFinedue.value,
                                    };
                            });
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          leading: selecteddues == true
                              ? const Selectedwidgets()
                              : const NotSelected(),
                          title: Text(
                            "Selected Dues",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppColor.textblack,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            "(Due date on 31st March)",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppColor.textblack,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700),
                          ),
                          trailing: Text(
                            "₹ ${controller.SelectedFinedue.value}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppColor.textblack,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: AppColor.primary,
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            title: Text(
                              "Total Amount: ₹${controller.Finedues.value}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      color: AppColor.textblack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                            ),
                            trailing: CustomButton(
                              height: 33.h,
                              width: 81.w,
                              ontap: () {},
                              Title: 'Pay Now',
                              fontWeight: FontWeight.normal,
                              Textsize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
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
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: FineDuesTicketCard(
                  ontap: () {
                    print("hello");
                  },
                  ontapcircule: () {
                    setState(() {
                      controller.fineselected.contains(index)
                          ? {
                              selectedticket = 0,
                              controller.fineselected.remove(index),
                              finedueslist[index].selected = false,
                              controller.SelectedFinedue.value -=
                                  finedueslist[index].price,
                              totalselectdue == true
                                  ? controller.Finedues.value =
                                      controller.SelectedFinedue.value
                                  : 0,
                            }
                          : {
                              selectedticket == 0
                                  ? selectedticket = index + 1
                                  : selectedticket = 0,
                              controller.fineselected.add(index),
                              finedueslist[index].selected = true,
                              controller.SelectedFinedue.value +=
                                  finedueslist[index].price,
                              totalselectdue == true
                                  ? controller.Finedues.value =
                                      controller.SelectedFinedue.value
                                  : 0,
                            };
                    });
                  },
                  selected: controller.fineselected.contains(index) == true
                      ? true
                      : false,
                  iconPath: "assets/icons/late_entry.png",
                  title: finedueslist[index].name,
                  date: finedueslist[index].date,
                  dateFontSize: 12,
                  Price: finedueslist[index].price,
                  reason: finedueslist[index].reason,
                  timeFontSize: 12,
                ),
              ),
              selectedticket == index + 1
                  ? SizedBox(
                      height: 5.h,
                    )
                  : Container(),
              selectedticket == index + 1
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: FeeDetailsBox(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

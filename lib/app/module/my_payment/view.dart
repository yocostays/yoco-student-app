import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/my_payment/model.dart';
import 'package:yoco_stay_student/app/module/my_payment/views/fine_dues.dart';
import 'package:yoco_stay_student/app/module/my_payment/views/pay_event_page.dart';
import 'package:yoco_stay_student/app/module/my_payment/views/payment_history.dart';
import 'package:yoco_stay_student/app/module/my_payment/views/rent_biling.dart';
import 'package:yoco_stay_student/app/module/my_payment/views/transactions_page.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class MyPaymentPage extends StatelessWidget {
  const MyPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titlewidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/drawer/payment.png",
                width: 50.w,
                height: 50.h,
              ),
              Text(
                "MY PAYMENT",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColor.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              )
            ],
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
                child: GestureDetector(
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
        // physics: NeverScrollableScrollPhysics(),
        child: stackcontainer(
          writedata: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.622,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paymenttitlelist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: GestureDetector(
                            onTap: () {
                              index == 0
                                  ? Get.to(() => const RentBilingPage())
                                  : index == 1
                                      ? Get.to(() => const FineduesPage())
                                      : index == 2
                                          ? Get.to(
                                              () => const PayForEventPage())
                                          : index == 3
                                              ? Get.to(() =>
                                                  const PayMentHistoryPage())
                                              : 0;
                            },
                            child: Container(
                              // height: 66.h,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                  const BoxShadow(
                                    color: AppColor.primary,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, -1),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(1, 0),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                title: Text(
                                  paymenttitlelist[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                          color: AppColor.textblack,
                                          fontWeight: FontWeight.w500),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.purple,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        leading: CircleAvatar(
                          radius: 9,
                          backgroundColor: Colors.white,
                          child: Radio(
                            value: 1,
                            groupValue:
                                null, // Adjust this value based on your logic
                            onChanged: (value) {},
                            activeColor: AppColor.grey3,
                          ),
                          // Icon(
                          //   Icons.check,
                          //   color: Colors.white,
                          //   size: 16,
                          // ),
                        ),
                        title: Text(
                          "Total Outstanding",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: AppColor.textblack,
                                  fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          "₹16,000",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: AppColor.textblack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                        ),
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
                          "Total Outstanding: ₹16,000",
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
                          ontap: () {
                            Get.to(() => const TransactionPage());
                          },
                          Title: 'Pay Now',
                          fontWeight: FontWeight.normal,
                          Textsize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

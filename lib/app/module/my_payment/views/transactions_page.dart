import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/quicksand_text_primary.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/icons.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_utils.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/my_payment/widgets/custom_ticket.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titlewidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "TRANSACTION SUCCESSFUL",
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
        // physics: NeverScrollableScrollPhysics(),
        child: stackcontainer(
          writedata: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
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
                        "ALL EVENT",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.grey3,
                            // fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Select All",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColor.grey3,
                                  // fontSize: 13,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                const FineDuesTicketCard(
                  iconPath: 'assets/images/Complaints/electricity_logo.png',
                  title: 'Harsh Jogi',
                  reason: "CCTV Damage Fine",
                  date: "9th Mar, 2024",
                  Price: 340,
                ),
                SizedBox(
                  height: 10.h,
                ),
                ClipPath(
                  clipper: MyCustomclipper(),
                  child: Container(
                    // height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        )),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 9),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Column(
                                          children: [
                                            QSPrimary10(
                                              Title: 'Invoice No.',
                                            ),
                                            QSPrimary21W700(
                                              Title: '200',
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1.w,
                                        ),
                                        const DottedVerticalDivider(),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const QSPrimary16(
                                              Title: "Payment Details",
                                            ),
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "Hostel premises CCTV ",
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                        color: AppColor
                                                            .textprimary,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const DottedHorizontalDivider(),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListTile(
                                  leading: Column(
                                    children: [
                                      Text(
                                        "PAID TO",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                      CircleAvatar(
                                        radius: 19,
                                        backgroundColor: AppColor.textprimary,
                                        child:
                                            AppIcon.user(color: AppColor.white),
                                      )
                                    ],
                                  ),

                                  title: Text(
                                    "YOCOSTAYS BOYS HOSTRL",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  leadingAndTrailingTextStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  // ?.copyWith(
                                  //     color: AppColor.textprimary,
                                  //     fontSize: 16.sp,
                                  //     fontWeight: FontWeight.w400),
                                  trailing: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: "₹",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400),
                                      // ?.copyWith(
                                      //     color: AppColor.textprimary,
                                      //     fontSize: 16.sp,
                                      //     fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: "320",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700),
                                    )
                                  ])),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    color: AppColor.textprimary,
                                  ),
                                ),
                                // transacion info
                                ListTile(
                                  titleTextStyle: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                  title: const Text("TRANSACTION ID"),
                                  subtitleTextStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                  subtitle:
                                      const Text("T24060XXXXXXXXXXXX8768"),
                                  trailing: Image.asset(
                                    "assets/icons/Group 350.png",
                                    height: 13.h,
                                    width: 11.w,
                                  ),
                                ),
                                // bank account number
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 19),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "DEBITED FROM",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppColor.white,
                                                child: Image.asset(
                                                  "assets/images/SBI-logo 1.png",
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "XXXXXX8768",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge
                                                        ?.copyWith(
                                                            color: AppColor
                                                                .textprimary,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    "UTR:415385742872",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayLarge
                                                        ?.copyWith(
                                                            color: AppColor
                                                                .textprimary,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                              text: "₹",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                      color: AppColor
                                                          .textprimary,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            TextSpan(
                                              text: "320",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall
                                                  ?.copyWith(
                                                      color: AppColor
                                                          .textprimary,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            )
                                          ])),
                                          Image.asset(
                                            "assets/icons/Group 350.png",
                                            height: 13.h,
                                            width: 11.w,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                // divider
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    color: AppColor.textprimary,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppIcon.download(
                                            color: AppColor.primary),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Download Receipt",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppIcon.share(color: AppColor.primary),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Share Receipt",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppIcon.circlequestion(
                                            color: AppColor.primary),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "Payment Support",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    color: AppColor.textprimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

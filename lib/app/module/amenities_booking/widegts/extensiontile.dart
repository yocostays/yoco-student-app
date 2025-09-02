import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/env.dart';
import 'package:yoco_stay_student/app/core/theme/quicksand_text_primary.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/core/values/icons.dart';
import 'package:yoco_stay_student/app/module/events/controller/event_controller.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_utils.dart';

// ignore: must_be_immutable
class aminitiesExtensionClass extends StatelessWidget {
  EventController eventcontroller = Get.put(EventController());

  aminitiesExtensionClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              QSPrimary10(
                                Title: 'Booking No.',
                              ),
                              QSPrimary21W700(
                                Title: '200',
                              ),
                            ],
                          ),
                          SizedBox(
                            width: screenwidth * 0.06,
                          ),
                          const DottedVerticalDivider(),
                          SizedBox(
                            width: screenwidth * 0.08,
                          ),
                          const QSPrimary16(
                            Title: "Payment Details",
                          ),
                          SizedBox(
                            width: screenwidth * 0.14,
                          ),
                          InkWell(
                              onTap: () {
                                eventcontroller.ticketDetails.value == true
                                    ? eventcontroller.ticketDetails(false)
                                    : eventcontroller.ticketDetails(true);
                              },
                              child: eventcontroller.ticketDetails == false
                                  ? AppIcon.DownarrowOutline(
                                      color: AppColor.textprimary)
                                  : AppIcon.UparrowOutline(
                                      color: AppColor.textprimary))
                        ],
                      ),
                    ),
                    const DottedHorizontalDivider(),
                  ],
                ),
              ),
              CustomPaint(
                painter: BookingStatusSideCutsDesign(),
                child: const SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.,
                  width: double.infinity,
                ),
              ),
            ],
          ),
          Visibility(
            visible: eventcontroller.ticketDetails.value,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                ListTile(
                  leading: Column(
                    children: [
                      Text(
                        "PAID TO",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      CircleAvatar(
                        radius: 19,
                        backgroundColor: AppColor.textprimary,
                        child: AppIcon.user(color: AppColor.white),
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
                          ?.copyWith(fontWeight: FontWeight.w400),
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
                          ?.copyWith(fontWeight: FontWeight.w700),
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
                  subtitle: const Text("T24060XXXXXXXXXXXX8768"),
                  trailing: Image.asset(
                    "assets/icons/Group 350.png",
                    height: 13.h,
                    width: 11.w,
                  ),
                ),
                // bank account number
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DEBITED FROM",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColor.white,
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
                                            color: AppColor.textprimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
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
                                            color: AppColor.textprimary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "₹",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: AppColor.textprimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: "320",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: AppColor.textprimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppIcon.download(color: AppColor.primary),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Download Receipt",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              ?.copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppIcon.circlequestion(color: AppColor.primary),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Payment Support",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
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
          )
        ],
      ),
    );
  }
}

class DottedMiddlePath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9;
    double dashSpace = 7;
    double startX = 10;
    final paint = Paint()
      ..color = AppColor.white
      ..strokeWidth = 1;

    while (startX < size.width - 10) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BookingStatusSideCutsDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // var h = size.height;
    var w = size.width;

    // canvas.drawArc(
    //   Rect.fromCircle(center: Offset(w / 3.5, h), radius: 7),
    //   0,
    //   10,
    //   false,
    //   Paint()
    //     ..style = PaintingStyle.fill
    //     ..color = Colors.white,
    // );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(w / 3.5, 0), radius: 7),
      0,
      10,
      false,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

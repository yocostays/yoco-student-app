// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/parcel_status/controller/parcel_controller.dart';
import 'package:yoco_stay_student/app/module/parcel_status/model/parcel-model.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

import '../../../widgets/custum_app_bar.dart';

class DeliveryBoyPage extends StatelessWidget {
  final ParcelController parcelcontroller = Get.put(ParcelController());
  DeliveryBoyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // title: "COMPLAINT MANAGEMENT",
        titlewidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Parcelitems[parcelcontroller.parcelid.value - 1].imageName,
              width: 50.w,
              height: 50.h,
            ),
            Text(
              Parcelitems[parcelcontroller.parcelid.value - 1].title,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColor.white, fontSize: 12),
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
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: stackcontainer(
              customheight: 510.h,
              NoBackgroundcolor: false,
              writedata: Column(
                children: [
                  SizedBox(
                    height: 440.h,
                    child: SingleChildScrollView(
                      // physics: NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              Parcelitems[parcelcontroller.parcelid.value - 1]
                                          .title ==
                                      'Delivery Boy'
                                  ? "DELIVERY FORM"
                                  : "NAME OF ${Parcelitems[parcelcontroller.parcelid.value - 1].title.toUpperCase()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.grey3,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                      letterSpacing: 0.8),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Custom_textfield(
                              TextController: parcelcontroller.parceltypename,
                              hint: "Type here...",
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  Parcelitems[parcelcontroller.parcelid.value -
                                                  1]
                                              .title ==
                                          'Delivery Boy'
                                      ? "When"
                                      : "PERIOD TO MEET (DATE & TIME)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: AppColor.grey3,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                          letterSpacing: 0.8),
                                ),
                                SizedBox(
                                  width: 5.h,
                                ),
                                const Icon(
                                  FeatherIcons.calendar,
                                  size: 15,
                                  color: AppColor.primary,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Parcelitems[parcelcontroller.parcelid.value - 1]
                                        .title ==
                                    'Delivery Boy'
                                ? InkWell(
                                    onTap: () async {
                                      await parcelcontroller
                                          .selectDate(context);
                                      await parcelcontroller.selectTime(context,
                                          parcelcontroller.Dateandtime);
                                    },
                                    child: TextField(
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: AppColor.textblack,
                                              fontWeight: FontWeight.w700),
                                      enabled: false,
                                      controller: parcelcontroller.Dateandtime,
                                      maxLength: 100,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: AppColor.textblack,
                                                fontWeight: FontWeight.w700),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: AppColor.textgrey,
                                                fontWeight: FontWeight.w700),
                                        hintText: 'Date and Time',
                                        filled: true,
                                        fillColor: const Color(
                                            0xFFFFF4D8), // Background color
                                        contentPadding: const EdgeInsets
                                            .symmetric(
                                            vertical: 11.0,
                                            horizontal:
                                                20.0), // Padding inside the text field
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              30.0), // Rounded corners
                                          borderSide:
                                              BorderSide.none, // No border
                                        ),
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 32.h,
                                        width: 120.h,
                                        // decoration: BoxDecoration(
                                        //     color: Color(0xFFFFF4D8),
                                        //     borderRadius:
                                        //         BorderRadius.circular(20.r)),
                                        child: InkWell(
                                          onTap: () async {
                                            await parcelcontroller
                                                .selectDate(context);
                                            await parcelcontroller.selectTime(
                                                context,
                                                parcelcontroller.fromdate);
                                          },
                                          child: Custom_textfield(
                                            enable: false,
                                            TextController:
                                                parcelcontroller.fromdate,
                                            hint: "From",
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 32.h,
                                        width: 120.h,
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFFFF4D8),
                                            borderRadius:
                                                BorderRadius.circular(20.r)),
                                        child: InkWell(
                                          onTap: () async {
                                            await parcelcontroller
                                                .selectDate(context);
                                            await parcelcontroller.selectTime(
                                                context,
                                                parcelcontroller.todate);
                                          },
                                          child: Custom_textfield(
                                            enable: false,
                                            TextController:
                                                parcelcontroller.todate,
                                            hint: "To",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "MONEY TO BE PAID (Optional)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.grey3,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                      letterSpacing: 0.8),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Custom_textfield(
                              TextController: parcelcontroller.moneypaid,
                              hint: "Type here...",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 1.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                -1, -2), // changes position of shadow
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      ontap: () {},
                      Title: 'SEND',
                      Textsize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(height: 100.h, child: const CustomBottomNavbar()),
          ),
        ],
      ),
    );
  }
}

class Custom_textfield extends StatelessWidget {
  final String? hint;
  final bool? enable;
  final TextEditingController TextController;

  const Custom_textfield({
    super.key,
    required this.hint,
    this.enable,
    required this.TextController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: AppColor.textblack, fontWeight: FontWeight.w700),
      enabled: enable ?? true,
      controller: TextController,
      maxLength: 100,
      maxLines: null,
      decoration: InputDecoration(
        counterText: "",
        labelStyle: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColor.textblack, fontWeight: FontWeight.w700),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColor.textgrey, fontWeight: FontWeight.w700),
        hintText: hint ?? '',
        filled: true,
        fillColor: const Color(0xFFFFF4D8), // Background color
        contentPadding: const EdgeInsets.symmetric(
            vertical: 11.0, horizontal: 20.0), // Padding inside the text field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
          borderSide: BorderSide.none, // No border
        ),
      ),
    );
  }
}

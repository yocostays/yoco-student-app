// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_card.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/eventpaymentpage.dart';

class MyBookingEventpage extends StatefulWidget {
  const MyBookingEventpage({super.key});

  @override
  State<MyBookingEventpage> createState() => _MyBookingEventpageState();
}

class _MyBookingEventpageState extends State<MyBookingEventpage> {
  int selectedtab = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 510.h,
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              children: [
                EventTimeNameCard(
                  paymentsectoion: () {
                    setState(() {
                      selectedtab == index + 1
                          ? selectedtab = 0
                          : selectedtab = index + 1;
                    });
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
                selectedtab == index + 1 ? const paymentDitails() : Container(),
                selectedtab == index + 1
                    ? SizedBox(
                        height: 5.h,
                      )
                    : Container(),
                3 == index + 1
                    ? SizedBox(
                        height: 20.h,
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}

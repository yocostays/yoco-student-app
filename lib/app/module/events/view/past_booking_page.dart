import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_card.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/eventpaymentpage.dart';

class PastBookingEventpage extends StatefulWidget {
  const PastBookingEventpage({super.key});

  @override
  State<PastBookingEventpage> createState() => _PastBookingEventpageState();
}

class _PastBookingEventpageState extends State<PastBookingEventpage> {
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

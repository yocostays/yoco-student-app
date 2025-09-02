// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class Action_Assign_Card extends StatelessWidget {
  final String name;
  final DateTime date;
  final String title;
  final String discription;
  final bool? fine;
  final int? fineamount;
  const Action_Assign_Card({
    super.key,
    required this.name,
    required this.date,
    required this.title,
    required this.discription,
    this.fine,
    this.fineamount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        // height: 102.h,
        // width: 327.w,
        padding:
            const EdgeInsets.only(left: 21, right: 43, top: 19, bottom: 19),
        decoration: BoxDecoration(
          color: AppColor.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
                fine == true
                    ? Text(
                        "Fine :  ₹$fineamount",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                                color: AppColor.textprimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700),
                      )
                    : const Text(""),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: AppColor.primary,
                ),
                // AppIcon.calendar(
                //   color: AppColor.primary,
                // ),
                SizedBox(
                  width: 4.h,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    Utils.formatDatebynd(date),
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: AppColor.textprimary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  // text: 'Hello ',
                  // style:
                  //     DefaultTextStyle.of(context).style, // Default style
                  children: <TextSpan>[
                    TextSpan(
                      text: title,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: AppColor.textprimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    TextSpan(
                      text: discription,
                      //' Unethical behavior in hostel premises.',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: AppColor.textprimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

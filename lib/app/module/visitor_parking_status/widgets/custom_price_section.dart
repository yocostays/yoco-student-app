import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';

class PriceContainerButton extends StatelessWidget {
  const PriceContainerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Total Amount: ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textblack, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "₹",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textblack, fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: "350",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textblack, fontWeight: FontWeight.bold),
                )
              ])),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: AppColor.primary.withOpacity(0.2)),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: Text(
                  "Total Hours: 3 hrs",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColor.textblack, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          CustomButton(
            height: 33.h,
            width: 85.w,
            ontap: () {},
            Title: 'Pay Now',
            Textsize: 15,
          ),
        ],
      ),
    );
  }
}

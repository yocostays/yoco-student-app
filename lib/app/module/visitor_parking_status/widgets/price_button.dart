import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';

class EminitiesContainerButton extends StatelessWidget {
  const EminitiesContainerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          const BoxShadow(
            color: AppColor.primary, // Shadow color
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(-1, -2), // Shadow position
          ),
          BoxShadow(
            color: AppColor.black.withOpacity(0.2), // Shadow color
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(1, 2), // Shadow position
          )
        ],
      ),
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
                      fontSize: 14,
                      color: AppColor.textblack,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "₹",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      color: AppColor.textblack,
                      fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: "350",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      color: AppColor.textblack,
                      fontWeight: FontWeight.bold),
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
                      fontSize: 12,
                      color: AppColor.textblack,
                      fontWeight: FontWeight.w700),
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

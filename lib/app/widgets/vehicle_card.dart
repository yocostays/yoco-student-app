import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class VihcelCard extends StatelessWidget {
  final String image;
  final String Name;
  final bool selected;
  final Function()? ontap;
  const VihcelCard({
    super.key,
    required this.image,
    required this.Name,
    required this.selected,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: selected == true
                    ? AppColor.primary
                    : AppColor.midpurple.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(image),
                ],
              )),
          SizedBox(
            height: 13.h,
          ),
          Text(
            Name,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColor.textblack,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

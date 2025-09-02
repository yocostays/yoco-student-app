import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? Boderradius;
  final double? Textsize;
  final FontWeight? fontWeight;
  final Color? BoxColor;
  final Color? textcolor;
  final double? fontsize;
  final Color? borderColor;

  final Function() ontap;
  final String Title;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final bool showLeftIcon;
  final bool showRightIcon;
  final bool? isloaging;

  const CustomButton(
      {super.key,
      this.height,
      this.width,
      this.Boderradius,
      this.BoxColor,
      this.textcolor,
      this.fontsize,
      this.borderColor,
      required this.ontap,
      required this.Title,
      this.leftIcon,
      this.rightIcon,
      this.showLeftIcon = false,
      this.showRightIcon = false,
      this.fontWeight,
      this.Textsize,
      this.isloaging});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: height ?? 32.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          color: BoxColor ?? AppColor.textprimary,
          borderRadius: BorderRadius.circular(Boderradius ?? 20.r),
        ),
        child: isloaging == true
            ? Center(
                child: LoadingAnimationWidget.discreteCircle(
                  size: 50,
                  color: AppColor.primary,
                ),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showLeftIcon && leftIcon != null)
                      Padding(
                        padding: EdgeInsets.only(right: 8.0.w),
                        child: Icon(
                          leftIcon,
                          color: textcolor ?? AppColor.white,
                          size: fontsize ?? 12,
                        ),
                      ),
                    Text(
                      Title,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: textcolor ?? AppColor.white,
                            fontSize: fontsize ?? Textsize ?? 12,
                            fontWeight:
                                fontWeight ?? fontWeight ?? FontWeight.bold,
                          ),
                    ),
                    if (showRightIcon && rightIcon != null)
                      Padding(
                        padding: EdgeInsets.only(left: 8.0.w),
                        child: Icon(
                          rightIcon,
                          color: textcolor ?? AppColor.white,
                          size: fontsize ?? 12,
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

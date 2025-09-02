import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? leadingImagePath;
  final String? trailingImagePath;
  final String? trailinglatter;
  final List<Widget>? trailingwidget;
  final Widget? leadingwidget;
  final Widget? titlewidget;
  final VoidCallback? onLeadingPressed;
  final VoidCallback? onTrailingPressed;

  const CustomAppBar(
      {super.key,
      this.title,
      this.leadingImagePath,
      this.trailingImagePath,
      this.onLeadingPressed,
      this.onTrailingPressed,
      this.trailinglatter,
      this.trailingwidget,
      this.leadingwidget,
      this.titlewidget});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // foregroundColor: Colors.white,
      // backgroundColor: Colors.white,
      backgroundColor: AppColor.primary,
      centerTitle: true,
      elevation: 0.h,
      title: titlewidget ??
          Text(
            title?.toUpperCase() ?? "",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColor.white,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
      leading: leadingwidget ??
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
                onTap: onLeadingPressed ??
                    () {
                      Get.back();
                    },
                child: const Icon(
                  CupertinoIcons.chevron_back,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
      actions: trailingwidget ??
          [
            const Text(""),
          ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

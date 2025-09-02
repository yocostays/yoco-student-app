import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';

class EvTicketCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? vihicelname;
  final String? date;
  final String? time;
  final Widget? timeSection;

  const EvTicketCard({
    super.key,
    required this.iconPath,
    required this.title,
    this.date,
    this.time,
    this.timeSection,
    this.vihicelname,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTrackingDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.midpurple.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20.r),
        ),
        height: MediaQuery.of(context).size.height * 0.18,
        width: double.infinity,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Center(
                    child: Image.asset(iconPath),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.h),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColor.textprimary,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            const Icon(
                              FeatherIcons.calendar,
                              color: Colors.transparent,
                              size: 20,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              vihicelname ?? "",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColor.textprimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            const Icon(
                              FeatherIcons.calendar,
                              color: AppColor.primary,
                              size: 20,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              date ?? "",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColor.textprimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        timeSection == null
                            ? Row(
                                children: [
                                  const Icon(
                                    FeatherIcons.clock,
                                    color: AppColor.primary,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    time ?? "",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textprimary,
                                    ),
                                  ),
                                ],
                              )
                            : timeSection ?? Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            CustomPaint(
              painter: SideCutsDesign(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
              ),
            ),
            CustomPaint(
              painter: DottedMiddlePath(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTrackingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tracking',
                          style: AppTextTheme.textTheme.displayLarge
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 5.h),
                  const Divider(
                    color: AppColor.grey2,
                  ),
                  SizedBox(height: 10.h),
                  // Example content similar to your screenshot
                  Row(
                    children: [
                      Image.asset(
                        iconPath,
                        width: 50.w,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: AppTextTheme.textTheme.displayLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.textblack)),
                          Text(vihicelname ?? "",
                              style: AppTextTheme.textTheme.displayMedium
                                  ?.copyWith(
                                      // fontWeight: FontWeight.w700,
                                      color: AppColor.textblack)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  const Divider(
                    color: AppColor.grey2,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(
                        size: 15.h,
                        FeatherIcons.calendar,
                        color: AppColor.primary,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        date ?? "",
                        style: AppTextTheme.textTheme.displayMedium
                            ?.copyWith(fontSize: 13, color: AppColor.textblack),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        size: 15.h,
                        FeatherIcons.clock,
                        color: AppColor.primary,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        time ?? "",
                        style: AppTextTheme.textTheme.displayMedium
                            ?.copyWith(fontSize: 13, color: AppColor.textblack),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      style: AppTextTheme.textTheme.displayMedium
                          ?.copyWith(color: AppColor.textblack, fontSize: 14)),
                  // maxLines: 2,

                  Image.asset(
                    'assets/images/qrimage.png', // Example QR code image
                    width: 200.w,
                    height: 150.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

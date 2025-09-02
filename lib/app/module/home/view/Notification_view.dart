import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return CutomAppBarContainer(
      title: 'NOTIFICATION',
      messmanagment: false,
      contentWidgets: [
        Container(
          height: 570.h,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(color: AppColor.grey3, spreadRadius: 1, blurRadius: 1)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Center(
              child: Text(
                "No Notification Right Now.",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColor.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),

            //  ListView.builder(
            //   padding: EdgeInsets.all(0),
            //   // physics: NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: 3, // Assuming you have 3 items in your list
            //   itemBuilder: (context, index) {
            //     return Column(
            //       children: [
            //         Container(
            //           height: 60.h,
            //           width: double.infinity.w,
            //           decoration: BoxDecoration(
            //               color: AppColor.lightpurple,
            //               borderRadius: BorderRadius.circular(10.r)),
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 10.w, vertical: 10.h),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Text(
            //                 "Your leave application has been approved sucessfully",
            //                 overflow: TextOverflow.ellipsis,
            //                 style: GoogleFonts.getFont("Roboto",
            //                     color: AppColor.primary,
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w400),
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 children: [
            //                   Icon(
            //                     Icons.circle_rounded,
            //                     size: 8,
            //                     color: AppColor.primary,
            //                   ),
            //                   SizedBox(
            //                     width: 5.w,
            //                   ),
            //                   Text(
            //                     "5 Min ago",
            //                     overflow: TextOverflow.ellipsis,
            //                     style: AppTextTheme.textTheme.displayLarge
            //                         ?.copyWith(
            //                             color: AppColor.primary,
            //                             fontSize: 10,
            //                             fontWeight: FontWeight.w400),
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //         SizedBox(
            //           height: 20.h,
            //         )
            //       ],
            //     );
            //   },
            // ),
          ),
        )
      ],
      isTrailing: false,
    );
  }
}

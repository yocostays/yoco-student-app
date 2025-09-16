// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';
import 'package:yoco_stay_student/app/widgets/bottom_navigation.dart';
import 'package:yoco_stay_student/app/widgets/bottom_navigation_center_botton.dart';
import 'package:yoco_stay_student/app/widgets/custom_appbar_container.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

// ignore: must_be_immutable
class HostelDetailView extends StatelessWidget {
  HomeController homeController = HomeController();
  HostelDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    homeController.GetHostelData();
    return Scaffold(
      // body: Obx(
      //   () => CutomAppBarContainer(
      //     // isScroll: false,
      //     title: "HOSTEL DETAILS",
      //     messmanagment: false,
      //     contentWidgets: [
      //       homeController.HosteldataLoading.value == true
      //           ? CustomShimmer(
      //               height: 340.w,
      //             )
      //           : FlutterCarousel(
      //               options: CarouselOptions(
      //                 height: 340.w,
      //                 viewportFraction: 1.0,
      //                 showIndicator: true,
      //                 slideIndicator: CircularSlideIndicator(
      //                   slideIndicatorOptions: SlideIndicatorOptions(
      //                     padding: EdgeInsets.only(bottom: 20.h),
      //                     currentIndicatorColor: AppColor.primary,
      //                     indicatorBackgroundColor: AppColor.white,
      //                   ),

      //                   // Hypothetical corrected parameter names
      //                 ),
      //               ),
      //               items: [1, 2, 3].map(
      //                 (i) {
      //                   return Builder(
      //                     builder: (BuildContext context) {
      //                       return Container(
      //                         width: 340.w,
      //                         margin: EdgeInsets.symmetric(horizontal: 7.w),
      //                         decoration: BoxDecoration(
      //                           color: Colors.amber,
      //                           borderRadius: BorderRadius.circular(20.r),
      //                         ),
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(20.r),
      //                           child: Image.asset(
      //                             "assets/images/hosteldetail.png",
      //                             fit: BoxFit.fill,
      //                           ),
      //                         ),
      //                       );
      //                     },
      //                   );
      //                 },
      //               ).toList(),
      //             ),
      //       SizedBox(height: 10.h),
      //       homeController.HosteldataLoading.value == true
      //           ? const CustomShimmer()
      //           : Container(
      //               height: 250.h,
      //               width: 323.w,
      //               decoration: BoxDecoration(
      //                 color: AppColor.white,
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: AppColor.primary.withOpacity(0.9),
      //                     spreadRadius: 0.6,
      //                     blurRadius: 0.6,
      //                     offset: const Offset(-1, -1),
      //                   ),
      //                   BoxShadow(
      //                     color: AppColor.primary.withOpacity(0.9),
      //                     spreadRadius: 0.6,
      //                     blurRadius: 0.6,
      //                     offset: const Offset(1, -0),
      //                   ),
      //                   BoxShadow(
      //                     color: AppColor.grey2.withOpacity(0.5),
      //                     spreadRadius: 2,
      //                     blurRadius: 3,
      //                     offset: const Offset(1, 2),
      //                   ),
      //                   BoxShadow(
      //                     color: AppColor.grey2.withOpacity(0.5),
      //                     spreadRadius: 2,
      //                     blurRadius: 3,
      //                     offset: const Offset(-1, 2),
      //                   ),
      //                 ],
      //                 borderRadius: BorderRadius.circular(20.r),
      //               ),
      //               child: Padding(
      //                 padding: EdgeInsets.symmetric(
      //                     horizontal: 16.w, vertical: 16.h),
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Text(
      //                           homeController.hostelDetailsDatas.value.name ??
      //                               "",
      //                           style:
      //                               AppTextTheme.textTheme.titleSmall?.copyWith(
      //                             fontWeight: FontWeight.w700,
      //                           ),
      //                         ),
      //                         SizedBox(
      //                           child: Row(
      //                             children: [
      //                               const Icon(
      //                                 FeatherIcons.star,
      //                                 color: AppColor.secondary,
      //                               ),
      //                               SizedBox(width: 8.w),
      //                               Text(
      //                                 "5.0",
      //                                 style: AppTextTheme.textTheme.displayLarge
      //                                     ?.copyWith(
      //                                   fontWeight: FontWeight.w400,
      //                                   fontSize: 14,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(height: 20.h),
      //                     Row(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         const Icon(FeatherIcons.mapPin),
      //                         SizedBox(width: 10.w),
      //                         SizedBox(
      //                           width: 260.w,
      //                           child: Text(
      //                             homeController
      //                                     .hostelDetailsDatas.value.address ??
      //                                 "",
      //                             maxLines: 4,
      //                             style: AppTextTheme.textTheme.displayLarge
      //                                 ?.copyWith(
      //                               fontWeight: FontWeight.w400,
      //                               fontSize: 13,
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(height: 10.h),
      //                     Divider(
      //                       height: 1.h,
      //                       thickness: 1,
      //                       color: AppColor.black,
      //                     ),
      //                     SizedBox(height: 10.h),
      //                     Text(
      //                       "Description",
      //                       style:
      //                           AppTextTheme.textTheme.displayLarge?.copyWith(
      //                         fontWeight: FontWeight.w700,
      //                         fontSize: 16,
      //                       ),
      //                     ),
      //                     Text(
      //                       homeController
      //                               .hostelDetailsDatas.value.description ??
      //                           "",
      //                       maxLines: 4,
      //                       style:
      //                           AppTextTheme.textTheme.displayLarge?.copyWith(
      //                         fontWeight: FontWeight.w400,
      //                         fontSize: 13,
      //                       ),
      //                     ),
      //                     SizedBox(height: 10.h),
      //                     Text(
      //                       "Phone Number",
      //                       style:
      //                           AppTextTheme.textTheme.displayLarge?.copyWith(
      //                         fontWeight: FontWeight.w700,
      //                         fontSize: 16,
      //                       ),
      //                     ),
      //                     Text(
      //                       "${homeController.hostelDetailsDatas.value.phone}",
      //                       style:
      //                           AppTextTheme.textTheme.displayLarge?.copyWith(
      //                         fontWeight: FontWeight.w400,
      //                         fontSize: 13,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //       // SizedBox(height: 100.h),
      //     ],
      //   ),
      // ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: const CenterButton(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

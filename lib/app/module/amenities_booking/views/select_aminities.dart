import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/controller.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/model.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/views/aminities_form.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';
import 'dart:math' as math;

class AmenitiesselectionPage extends StatefulWidget {
  const AmenitiesselectionPage({super.key});

  @override
  State<AmenitiesselectionPage> createState() => _AmenitiesselectionPageState();
}

class _AmenitiesselectionPageState extends State<AmenitiesselectionPage>
    with SingleTickerProviderStateMixin {
  final AmenitiesController controller = Get.put(AmenitiesController());
  late AnimationController _animationController;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimations = List.generate(aminitiesItemslist.length, (index) {
      return Tween<Offset>(
        begin: Offset((index % 2 == 0) ? -1.0 : 1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          (1 / aminitiesItemslist.length) * index,
          1.0,
          curve: Curves.easeInOut,
        ),
      ));
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titlewidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/drawer/amenities.png',
              width: 50.w,
              height: 50.h,
            ),
            SizedBox(width: 10.w),
            Text(
              "AMENITIES BOOKING",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColor.white,
                    fontSize: 12.sp,
                  ),
            ),
          ],
        ),
        trailingwidget: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: GestureDetector(
              onTap: () {
                Get.to(const NotificationView());
              },
              child: Container(
                width: 31.w,
                height: 31.h,
                decoration: BoxDecoration(
                  color: AppColor.belliconbackround,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: const Icon(
                  CupertinoIcons.bell,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: stackcontainer(
        writedata: Padding(
          padding: EdgeInsets.only(top: 25.h, left: 32.w, right: 10.w),
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            panEnabled: true,
            scaleEnabled: true,
            // minScale: 1.0,
            // maxScale: 3.0,
            child: Transform(
              alignment: Alignment.topRight,
              transform: Matrix4.skewY(-0.6)..rotateZ(-math.pi / 100.0),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: aminitiesItemslist.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 25,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      controller.minusbutton(true);
                      controller.plusbutton(true);
                      controller.Selectedaminieties.value = index;
                      Get.to(const AmietiesFormPage());
                    },
                    child: SlideTransition(
                      position: _slideAnimations[index],
                      child: Transform(
                        alignment: Alignment.topRight,
                        transform: Matrix4.skewY(0.5)..rotateZ(-math.pi / -6.0),
                        child: Container(
                          // height: 150.h,
                          // width: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                              bottomLeft: Radius.circular(5.r),
                              topRight: Radius.circular(5.r),
                            ),
                            color: AppColor.grey9,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.skewY(0.2)
                              ..rotateZ(math.pi / -5.0),
                            child: Container(
                              width: 50.w,
                              padding: EdgeInsets.all(3.w),
                              child: Image.asset(
                                aminitiesItemslist[index].imageName,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

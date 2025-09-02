import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/complain_model.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/parcel_status/controller/parcel_controller.dart';
import 'package:yoco_stay_student/app/module/parcel_status/model/parcel-model.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class AddParcel extends StatefulWidget {
  const AddParcel({super.key});

  @override
  State<AddParcel> createState() => _AddParcelState();
}

class _AddParcelState extends State<AddParcel>
    with SingleTickerProviderStateMixin {
  ParcelController parcelcontroller = Get.put(ParcelController());
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize the list of animations based on the length of complaintItems
    _slideAnimations = List.generate(complaintItems.length, (index) {
      return Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          (1 / complaintItems.length) *
              index, // Adjust the interval to stagger animations
          1.0,
          curve: Curves.easeInOut,
        ),
      ));
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // title: "COMPLAINT MANAGEMENT",
        titlewidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/parcel/Parcel_icon.png',
              width: 50.w,
              height: 50.h,
            ),
            Text(
              "PARCEL MANAGEMENT",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColor.white, fontSize: 12),
            )
          ],
        ),
        trailingwidget: [
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
                onTap: () {
                  Get.to(const NotificationView());
                },
                child: const Icon(
                  CupertinoIcons.bell,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          stackcontainer(
            writedata: GridView.builder(
              itemCount: Parcelitems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                return SlideTransition(
                  position: _slideAnimations[index],
                  child: InkWell(
                    onTap: () {
                      parcelcontroller.parcelid.value = Parcelitems[index].id;
                      parcelcontroller.Dateandtime.clear();
                      parcelcontroller.fromdate.clear();
                      parcelcontroller.todate.clear();
                      Get.toNamed(AppRoute.parcelform);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Parcelitems[index].imageName,
                                  height: 50.h,
                                  width: 50.w,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            Parcelitems[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.textblack),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(height: 100.h, child: const CustomBottomNavbar()),
          ),
        ],
      ),
    );
  }
}

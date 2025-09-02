import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/model/ev_model.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/visitor_parking_status/controller/ve_slot_controller.dart';
import 'package:yoco_stay_student/app/module/visitor_parking_status/model/ev_model.dart';
import 'package:yoco_stay_student/app/module/visitor_parking_status/view/vehicle_pass_from.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class VehiclePassBookpage extends StatefulWidget {
  const VehiclePassBookpage({super.key});

  @override
  State<VehiclePassBookpage> createState() => _VehiclePassBookpageState();
}

class _VehiclePassBookpageState extends State<VehiclePassBookpage>
    with SingleTickerProviderStateMixin {
  vehiclepassController EvController = Get.put(vehiclepassController());
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
    _slideAnimations = List.generate(vehiclepassitems.length, (index) {
      return Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          (1 / vehiclepassitems.length) *
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
            // Image.asset(
            //   'assets/images/ev_slot_image/ev_slot_charger.png',
            //   width: 50.w,
            //   height: 50.h,
            // ),
            Text(
              "VISITOR PARKING PASS",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColor.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        trailingwidget: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: InkWell(
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
                child: GestureDetector(
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
          ),
        ],
      ),
      body: Stack(
        children: [
          stackcontainer(
            writedata: GridView.builder(
              itemCount: vehiclepassitems.length,
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
                      EvController.Selectebooking.value =
                          vehiclepassitems[index].id;
                      Get.to(() => VehiclePassForm());
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 8.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Evitems[index].imageName,
                                  height: 56.h,
                                  width: 78.w,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            Evitems[index].title,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/emergency_support/model/emergency_list_model.dart';
import 'package:yoco_stay_student/app/module/emergency_support/view/chat_page.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class EmergencySupportPge extends StatefulWidget {
  const EmergencySupportPge({super.key});

  @override
  State<EmergencySupportPge> createState() => _EmergencySupportPgeState();
}

class _EmergencySupportPgeState extends State<EmergencySupportPge>
    with SingleTickerProviderStateMixin {
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
    _slideAnimations = List.generate(EmergencydataList.length, (index) {
      return index % 2 == 0
          ? Tween<Offset>(
              begin: const Offset(-1.0, 1.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(
                (1 / EmergencydataList.length) *
                    index, // Adjust the interval to stagger animations
                1.0,
                curve: Curves.easeInOut,
              ),
            ))
          : Tween<Offset>(
              begin: const Offset(1.0, -1.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(
                (1 / EmergencydataList.length) *
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
          titlewidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/drawer/emergency.png',
                width: 40.w,
                height: 40.h,
              ),
              Text(
                "EMERGENCY SUPPORT",
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
          ]),
      body: stackcontainer(
        writedata: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: GridView.builder(
            itemCount: EmergencydataList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return SlideTransition(
                position: _slideAnimations[index],
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.textprimary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        EmergencydataList[index].image,
                        height: 70.h,
                        width: 100.w,
                      ),
                      Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          EmergencydataList[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.white),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(const EmergencyChatPage());
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                            0.5), // Black color with opacity
                                        offset:
                                            const Offset(0, 1), // Shadow offset
                                        blurRadius: 2, // Shadow blur radius
                                        spreadRadius: 1, // Shadow spread radius
                                      )
                                    ]),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  FeatherIcons.messageCircle,
                                  size: 25,
                                  color: AppColor.primary,
                                )),
                          ),
                          InkWell(
                            onTap: () async {
                              final Uri launchUri = Uri(
                                scheme: 'tel',
                                path: "123456789",
                              );
                              await launchUrl(launchUri);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(
                                            0.5), // Black color with opacity
                                        offset:
                                            const Offset(0, 1), // Shadow offset
                                        blurRadius: 2, // Shadow blur radius
                                        spreadRadius: 1, // Shadow spread radius
                                      )
                                    ]),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  CupertinoIcons.phone_fill,
                                  size: 25,
                                  color: AppColor.primary,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

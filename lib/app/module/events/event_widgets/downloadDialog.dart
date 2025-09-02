import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/widgets/stepper_class.dart';

class EventDialogBox extends StatefulWidget {
  const EventDialogBox({
    super.key,
  });

  @override
  State<EventDialogBox> createState() => _EventDialogBoxState();
}

class _EventDialogBoxState extends State<EventDialogBox>
    with SingleTickerProviderStateMixin {
  var currentStep = 1;
  var totalSteps = 0;
  late List<StepperData> stepsData;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

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
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 190),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Download",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AppColor.textprimary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Flexible(
                      child: Column(
                        children: [
                          Container(
                            height: 150.h,
                            decoration: BoxDecoration(
                                color: AppColor.lightgray,
                                borderRadius: BorderRadius.circular(20.r)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: AppColor.textblack),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            height: 32.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                              color: AppColor.yellow4,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "DOWNLOAD NOW",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                          color: AppColor.textblack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          InkWell(
                            onTap: () async {
                              final box =
                                  context.findRenderObject() as RenderBox?;
                              await Share.shareUri(
                                Uri.parse(
                                    "https://simple.wikipedia.org/wiki/Mountain#/media/File:Everest,_Nepal,_Himalayas.jpg"),
                                sharePositionOrigin:
                                    box!.localToGlobal(Offset.zero) & box.size,
                              );
                              // Get.back();
                            },
                            child: Container(
                              height: 32.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                                color: AppColor.yellow4,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "SHARE",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                            color: AppColor.textblack,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DottedDivider extends StatelessWidget {
  final Color? Dottedcolor;
  const DottedDivider({
    super.key,
    required this.Dottedcolor,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Adjust height as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            7,
            (index) => Container(
                  width: 2,
                  height: 5,
                  color: Dottedcolor, // Adjust color as needed
                )),
      ),
    );
  }
}

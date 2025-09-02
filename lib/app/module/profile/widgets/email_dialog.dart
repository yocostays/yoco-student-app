import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/widgets/stepper_class.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';

class EmailDialogBox extends StatefulWidget {
  const EmailDialogBox({
    super.key,
  });

  @override
  State<EmailDialogBox> createState() => _EmailDialogBoxState();
}

class _EmailDialogBoxState extends State<EmailDialogBox>
    with SingleTickerProviderStateMixin {
  final ProfileController profileController = Get.put(ProfileController());
  var currentStep = 1;
  var totalSteps = 0;
  late List<StepperData> stepsData;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    stepsData = [
      StepperData(
        label: 'Order Placed',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
      ),
      StepperData(
        label: 'Order Confirmed',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
      ),
      StepperData(
        label: 'Order Processed',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
      ),
      StepperData(
        label: 'Ready to Pickup',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec efficitur risus est, sed consequat libero luctus vitae. Duis ultrices magna quis risus porttitor luctus. Nulla vel tempus nisl, ultricies congue lectus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
      ),
    ];
    totalSteps = stepsData.length;

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
    return FadeTransition(
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
                      "Email Edit",
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
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: profileController.EmailName,
                            maxLength: 100,
                            maxLines: null,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              counterText: "",
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.textblack,
                                      fontWeight: FontWeight.w700),
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppColor.textgrey,
                                      fontWeight: FontWeight.w700),
                              hintText: 'Type here...',
                              filled: true,
                              fillColor:
                                  const Color(0xFFFFF4D8), // Background color
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 11.0,
                                  horizontal:
                                      20.0), // Padding inside the text field
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Rounded corners
                                borderSide: BorderSide.none, // No border
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
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

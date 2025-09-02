import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

import 'package:yoco_stay_student/app/module/onboarding/model/skipablescreen_content.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/login_signup.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';

class SkipableScreen extends StatefulWidget {
  const SkipableScreen({super.key});

  @override
  _SkipableScreenState createState() => _SkipableScreenState();
}

class _SkipableScreenState extends State<SkipableScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late PageController _controller;
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<Offset> _offsetRightAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _offsetRightAnimation = Tween<Offset>(
      begin: const Offset(1, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (_, i) {
                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 170.h),
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: SlideTransition(
                              position: i == 1
                                  ? _offsetRightAnimation
                                  : _offsetAnimation,
                              child: SizedBox(
                                width: double.infinity,
                                child: SvgPicture.asset(
                                  "${contents[i].image}",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 230.h,
                    decoration: BoxDecoration(
                      boxShadow: const [BoxShadow(color: AppColor.primary)],
                      color: AppColor.primary,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: _opacityAnimation,
                                child: SlideTransition(
                                  position: _offsetAnimation,
                                  child: Text(
                                    "${contents[currentIndex].title}",
                                    textAlign: TextAlign.center,
                                    style: AppTextTheme.textTheme.displayLarge
                                        ?.copyWith(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: _opacityAnimation,
                                child: SlideTransition(
                                  position: _offsetAnimation,
                                  child: Text(
                                    "${contents[currentIndex].discription}",
                                    textAlign: TextAlign.center,
                                    style: AppTextTheme.textTheme.displayLarge
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  contents.length,
                                  (index) => buildDot(index, context),
                                ),
                              ),
                              CustomButton(
                                BoxColor: AppColor.secondary,
                                height: 48.h,
                                Boderradius: 32.r,
                                showRightIcon: true,
                                fontsize: 16,
                                rightIcon: Icons.arrow_forward,
                                fontWeight: FontWeight.w700,
                                textcolor: AppColor.textblack,
                                width: 117.w,
                                ontap: () {
                                  if (currentIndex == contents.length - 1) {
                                    Get.to(const LoginSignUp());
                                  } else {
                                    _controller.nextPage(
                                      duration: const Duration(milliseconds: 5),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                },
                                Title: currentIndex == contents.length - 1
                                    ? "Login"
                                    : "Next",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? AppColor.secondary : Colors.white,
      ),
    );
  }
}

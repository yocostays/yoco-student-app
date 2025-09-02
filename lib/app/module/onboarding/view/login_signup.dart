// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/Storage/get_storage.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/onboarding/auth_controller.dart';

import 'package:yoco_stay_student/app/module/onboarding/view/login_page.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/register_page.dart';
import 'package:yoco_stay_student/app/globals.dart' as globals;

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({super.key});

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp>
    with TickerProviderStateMixin {
  final AuthController authController = Get.put(AuthController());
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  bool _isChecked = false;

  double _containerHeight = globals.globalheight * 0.6;
  double welcomeheight = globals.globalheight * 0.3;
  String? loginname;
  String? Password;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    authController.tabController = TabController(length: 2, vsync: this);

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    loginname = TokenStorage.getLoginid();
    loginname == "" ? 0 : authController.UserId.text = loginname ?? "";

    Password = TokenStorage.getPassword();
    Password == "" ? 0 : authController.Password.text = Password ?? "";
    // Start the animation when the screen is loaded
    _animationController.forward();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    print("heloo ");
    setState(() {
      print("scroll controller : ${_scrollController.offset}");
      // _containerHeight = 250.h + _scrollController.offset * 0.5;
      // welcomeheight = 240.h - _scrollController.offset * 0.5.h;
      _containerHeight = _scrollController.offset >= globals.globalheight * 0.6
          ? globals.globalheight * 0.6
          : _scrollController.offset >= globals.globalheight * 0.6
              ? globals.globalheight * _scrollController.offset
              : globals.globalheight * 0.6;
      welcomeheight = max(100.h, 200.h - _scrollController.offset * 0.45.h);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    authController.tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleRememberMe(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightpurple2,
      body: Column(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                  height: authController.tabController.index == 0
                      ? globals.globalheight * 0.3
                      : welcomeheight,
                  padding: EdgeInsets.only(top: 45.h, bottom: 5.h),
                  child: Image.asset("assets/images/login.png"),
                ),
              );
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Container(
              width: double.infinity.w,
              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //     color: AppColor.midpurple,
                //     blurRadius: 1.h,
                //     spreadRadius: 0.h,
                //   ),
                // ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40.r),
                ),
                color: AppColor.white,
              ),
              padding: EdgeInsets.all(15.h),
              child: Column(
                children: [
                  Container(
                    height: 45.h,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: AppColor.lightpurple2,
                      borderRadius: BorderRadius.circular(40.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: authController.tabController,
                      onTap: (value) {
                        setState(() {
                          value == 0
                              ? {
                                  welcomeheight = 240.h,
                                  _containerHeight = 260.h
                                }
                              : _containerHeight = 260.h;
                        });
                      },
                      tabs: const [
                        Tab(text: 'Login'),
                        Tab(text: 'Register'),
                      ],
                      indicatorPadding: const EdgeInsets.all(3),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: AppColor.primary,
                      ),
                      labelColor: AppColor.white,
                      unselectedLabelColor: AppColor.textblack,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: authController.tabController,
                      children: [
                        Login(
                          isChecked: _isChecked,
                          onCheckedChanged: _toggleRememberMe,
                        ),
                        Register(
                          scrollController: _scrollController,
                          height: _containerHeight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view.dart';
import 'package:yoco_stay_student/app/module/profile/view.dart';
import 'package:yoco_stay_student/app/widgets/DialogPage.dart';

class CustomBottomNavbarpageless extends StatefulWidget {
  const CustomBottomNavbarpageless({super.key});

  @override
  State<CustomBottomNavbarpageless> createState() =>
      _CustomBottomNavbarpagelessState();
}

class _CustomBottomNavbarpagelessState
    extends State<CustomBottomNavbarpageless> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const DashboardPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: pages,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Positioned(
            left: 15.w,
            right: 15.w,
            bottom: 15.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _onItemTapped(0),
                  child: Container(
                    width: 130.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(90),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipPath(
                      clipper: CustomClipPathOpposite(),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffFDFAFF),
                        ),
                        child: Center(
                          child: Icon(
                            FeatherIcons.home,
                            color: _selectedIndex == 0
                                ? AppColor.primary
                                : AppColor.grey4,
                            size: 24.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _showBlurredDialog();
                  },
                  child: Container(
                    width: 65.h,
                    height: 65.h,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 60.h,
                        height: 60.h,
                        decoration: const BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            "assets/icons/qricon.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _onItemTapped(1),
                  child: Container(
                    width: 120.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(90),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffFDFAFF),
                        ),
                        child: Center(
                          child: Icon(
                            FeatherIcons.users,
                            color: _selectedIndex == 1
                                ? AppColor.primary
                                : AppColor.grey4,
                            size: 24.h,
                          ),
                        ),
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

  void _showBlurredDialog() {
    Get.dialog(
      const DialogPage(),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.8, 0);
    path.quadraticBezierTo(
        size.width, size.height / 2, size.width * 0.8, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.1, size.height / 2, 0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipPathOpposite extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.15, 0);
    path.quadraticBezierTo(
        0, size.height / 1.5, size.width * 0.18, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width * 0.9, size.height / 2, size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

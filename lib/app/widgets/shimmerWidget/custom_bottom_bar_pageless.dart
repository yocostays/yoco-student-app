import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view.dart';
import 'package:yoco_stay_student/app/module/profile/view.dart';
import 'package:yoco_stay_student/app/widgets/DialogPage.dart';

/// Controller for bottom navigation
class BottomNavController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final PageController pageController = PageController();

  final pages = [
    const DashboardPage(),
    ProfilePage(),
  ];

  void onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}

/// Main widget
class CustomBottomNavbarpageless extends StatelessWidget {
  const CustomBottomNavbarpageless({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            children: controller.pages,
            onPageChanged: (index) {
              controller.selectedIndex.value = index;
            },
          ),
          Positioned(
            left: 15.w,
            right: 15.w,
            bottom: 15.w,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavItem(
                    icon: FeatherIcons.home,
                    isSelected: controller.selectedIndex.value == 0,
                    onTap: () => controller.onItemTapped(0),
                    clipper: const CustomClipPathOpposite(),
                    width: 130.w,
                  ),
                  InkWell(
                    onTap: () => Get.dialog(const DialogPage()),
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
                  _NavItem(
                    icon: FeatherIcons.users,
                    isSelected: controller.selectedIndex.value == 1,
                    onTap: () => controller.onItemTapped(1),
                    clipper: const CustomClipPath(),
                    width: 120.w,
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

/// Reusable nav item widget
class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final CustomClipper<Path> clipper;
  final double width;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.clipper,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 38.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipPath(
          clipper: clipper,
          child: Container(
            color: const Color(0xffFDFAFF),
            child: Center(
              child: Icon(
                icon,
                color: isSelected ? AppColor.primary : AppColor.grey4,
                size: 24.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Clipper classes
class CustomClipPath extends CustomClipper<Path> {
  const CustomClipPath();
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.8, 0);
    path.quadraticBezierTo(size.width, size.height / 2, size.width * 0.8, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.1, size.height / 2, 0, 0);
    return path..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomClipPathOpposite extends CustomClipper<Path> {
  const CustomClipPathOpposite();
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.15, 0);
    path.quadraticBezierTo(0, size.height / 1.5, size.width * 0.18, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width * 0.9, size.height / 2, size.width, 0);
    return path..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

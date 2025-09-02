import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCustomclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 20;
    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(Offset(curXPos, curYPos),
          radius: const Radius.circular(5));
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(oldClipper) => false;
}

class DottedVerticalDivider extends StatelessWidget {
  const DottedVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Adjust height as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(10, (index) => const DottedLine()),
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  const DottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 5,
      color: Colors.white, // Adjust color as needed
    );
  }
}

class DottedHorizontalDivider extends StatelessWidget {
  const DottedHorizontalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(30, (index) => const DottedSegment()),
    );
  }
}

class DottedSegment extends StatelessWidget {
  const DottedSegment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.w,
      height: 1.h,
      color: Colors.white, // Adjust color as needed
    );
  }
}

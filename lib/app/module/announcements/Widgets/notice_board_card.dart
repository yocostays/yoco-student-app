import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class NoticeBoardCarousel extends StatelessWidget {
  final List<Widget> noticeCards;

  const NoticeBoardCarousel({super.key, required this.noticeCards});

  @override
  Widget build(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        height: 150.h,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        autoPlay: true,
      ),
      items: noticeCards.map((card) {
        return Builder(
          builder: (BuildContext context) {
            return card;
          },
        );
      }).toList(),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String time;
  final Color backgroundColor;
  final void Function()? onPressed;

  const NoticeCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        width: 250.w,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTextTheme.textTheme.labelLarge?.copyWith(
                  fontSize: 15,
                  color: AppColor.textblack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                description,
                style: AppTextTheme.textTheme.labelLarge?.copyWith(
                  fontSize: 12,
                  color: AppColor.textblack,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            const Icon(Icons.calendar_today,
                                color: Colors.black54),
                            const SizedBox(width: 5.0),
                            Text(
                              date,
                              style:
                                  AppTextTheme.textTheme.labelLarge?.copyWith(
                                fontSize: 10,
                                color: AppColor.textblack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.access_time,
                                color: Colors.black54),
                            const SizedBox(width: 5.0),
                            Text(
                              time,
                              style:
                                  AppTextTheme.textTheme.labelLarge?.copyWith(
                                fontSize: 10,
                                color: AppColor.textblack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: AppColor.white,
                    onPressed: onPressed,
                    child: const Icon(
                      Icons.call_made,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

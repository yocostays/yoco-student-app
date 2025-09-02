import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/controller.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/model.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/views/aminities_form.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/widegts/dilivery_date_table.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/widegts/extensiontile.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/widegts/selected_list_table.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/event_utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';

class ArchiveBookingPage extends StatefulWidget {
  const ArchiveBookingPage({super.key});

  @override
  State<ArchiveBookingPage> createState() => _ArchiveBookingPageState();
}

class _ArchiveBookingPageState extends State<ArchiveBookingPage>
    with SingleTickerProviderStateMixin {
  AmenitiesController Controller = Get.put(AmenitiesController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items =
      List<int>.generate(aminitieslist.length, (int index) => index);
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(context, index, animation);
        },
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.to(AmitiesticketsDetal());
                          setState(() {
                            selectedindex == index + 1
                                ? selectedindex = 0
                                : selectedindex = index + 1;
                          });
                        },
                        child: Stack(
                          children: [
                            TicketCard(
                              iconPath: aminitieslist[index].imageName,
                              title: aminitieslist[index].title,
                              date: aminitieslist[index].date,
                              timeSection: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        FeatherIcons.clock,
                                        color: AppColor.primary,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        aminitieslist[index].time,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.textprimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                bottom: 25,
                                right: 10,
                                child: InkWell(
                                  onTap: () {
                                    Controller.minusbutton(false);
                                    Controller.plusbutton(false);
                                    Controller.Selectedaminieties.value = index;
                                    Get.to(const AmietiesFormPage());
                                  },
                                  child: const Icon(
                                    FeatherIcons.edit,
                                    size: 20,
                                    color: AppColor.primary,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      selectedindex == index + 1
                          ? SizedBox(
                              height: 5.h,
                            )
                          : SizedBox(
                              height: 0.h,
                            ),
                      selectedindex == index + 1
                          ? ClipPath(
                              clipper: MyCustomclipper(),
                              child: Container(
                                // height: 100.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColor.primary.withOpacity(0.2),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                    )),
                                child: Column(
                                  children: [
                                    aminitiesExtensionClass(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    const Listofselectedtable(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Diliverydatetable(),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 10,
                top: 25,
                child: InkWell(
                  onTap: () {
                    _removeItem(index);
                  },
                  child: Icon(
                    Icons.close,
                    size: 25,
                    weight: 20.sp,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _removeItem(int index) {
    _items.removeAt(index);

    // Remove the item from parcelList
    aminitieslist.removeAt(index);

    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        return SlideTransition(
          position: _offsetAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: _buildItem(context, index, animation),
          ),
        );
      },
      // duration: const Duration(milliseconds: 10),
    );

    setState(() {});
  }
}

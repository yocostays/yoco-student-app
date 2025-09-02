import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/parcel_status/controller/parcel_controller.dart';
import 'package:yoco_stay_student/app/module/parcel_status/model/parcel-model.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/widgets/custom_ticket_widget.dart';

class ActiveTicket extends StatefulWidget {
  const ActiveTicket({super.key});

  @override
  State<ActiveTicket> createState() => _ActiveTicketState();
}

class _ActiveTicketState extends State<ActiveTicket>
    with SingleTickerProviderStateMixin {
  ParcelController parcelcontroller = Get.put(ParcelController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items =
      List<int>.generate(parcelList.length, (int index) => index);
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
                  TicketCard(
                    iconPath: parcelList[index].imageName,
                    title: parcelList[index].title,
                    date: parcelList[index].date,
                    timeSection: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              parcelList[index].time,
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
                ],
              ),
              Positioned(
                right: 10,
                top: 25,
                child: InkWell(
                  onTap: () {
                    _removeItem(index);
                    // setState(() {
                    //   parcelList.removeAt(index);
                    //   _items = List<int>.generate(
                    //       parcelList.length, (int index) => index);
                    // });
                  },
                  child: const Icon(
                    Icons.close,
                    size: 25,
                    weight: 20,
                    color: AppColor.primary,
                  ),
                ),
              ),
              Positioned(
                  right: 10,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () {
                      print("hello kiti");
                      parcelcontroller.parcelid.value = parcelList[index].id;
                      parcelcontroller.Dateandtime.text =
                          parcelList[index].date;
                      parcelcontroller.fromdate.clear();
                      parcelcontroller.todate.clear();
                      Get.toNamed(AppRoute.parcelform);
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
      ),
    );
  }

  void _removeItem(int index) {
    int removedItem = _items.removeAt(index);

    // Remove the item from parcelList
    parcelList.removeAt(index);

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

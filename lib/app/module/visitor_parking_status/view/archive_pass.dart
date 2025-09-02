import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/model/ev_model.dart';
import 'package:yoco_stay_student/app/module/ev_slot_status/widgets/custom_ev_ticket.dart';
import 'package:yoco_stay_student/app/module/parcel_status/controller/parcel_controller.dart';
import 'package:yoco_stay_student/app/module/visitor_parking_status/model/ev_model.dart';

class ArchiveVehicalPasspage extends StatefulWidget {
  const ArchiveVehicalPasspage({super.key});

  @override
  State<ArchiveVehicalPasspage> createState() => _ArchiveVehicalPasspageState();
}

class _ArchiveVehicalPasspageState extends State<ArchiveVehicalPasspage>
    with SingleTickerProviderStateMixin {
  ParcelController parcelcontroller = Get.put(ParcelController());
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items =
      List<int>.generate(evactivepasslist.length, (int index) => index);
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
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              EvTicketCard(
                iconPath: evactivelist[index].icon,
                vihicelname: evactivelist[index].vehicleName,
                title: evactivelist[index].vehicleNumber,
                date: evactivelist[index].date,
                time: evactivelist[index].time,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

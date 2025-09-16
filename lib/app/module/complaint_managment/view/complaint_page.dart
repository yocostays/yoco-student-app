import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/controller/controller.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/complain_model.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';


import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class ComplaintSelectPage extends StatefulWidget {
  const ComplaintSelectPage({super.key});

  @override
  _ComplaintSelectPageState createState() => _ComplaintSelectPageState();
}

class _ComplaintSelectPageState extends State<ComplaintSelectPage>
    with SingleTickerProviderStateMixin {
  final CompliantController compliantController =
      Get.put(CompliantController());
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    compliantController.GetComplaintTypeList();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Initialize the list of animations based on the length of complaintItems
    _slideAnimations = List.generate(complaintItems.length, (index) {
      return
          // index % 2 == 0
          //     ? Tween<Offset>(
          //         begin: const Offset(1.0, 5.0),
          //         end: Offset.zero,
          //       ).animate(CurvedAnimation(
          //         parent: _controller,
          //         curve: Interval(
          //           (1 / complaintItems.length) *
          //               index, // Adjust the interval to stagger animations
          //           1.0,
          //           curve: Curves.easeInOut,
          //         ),
          //       ))
          //     :
          Tween<Offset>(
        begin: const Offset(0, 10),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          (1 / complaintItems.length) *
              index, // Adjust the interval to stagger animations
          1.0,
          curve: Curves.easeInOut,
        ),
      ));
    });

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
      appBar: CustomAppBar(
        title: "COMPLAINT MANAGEMENT",
        trailingwidget: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              width: 31.w,
              height: 31.h,
              decoration: BoxDecoration(
                color: AppColor.belliconbackround,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(const NotificationView());
                },
                child: const Icon(
                  CupertinoIcons.bell,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(
            () => stackcontainer(
              customheight: 510.h,
              writedata: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child:
                    // compliantController.Complaintdataload.value == true
                    //     ? Loader()
                    //     :
                    compliantController.Complainttypedata.isEmpty
                        ? const Text("there no data")
                        : GridView.builder(
                            itemCount:
                                compliantController.Complainttypedata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return SlideTransition(
                                position: _slideAnimations[index],
                                child: InkWell(
                                  onTap: () {
                                    compliantController.Complaitnid.value =
                                        compliantController
                                                .Complainttypedata[index].sId ??
                                            "";
                                    Get.toNamed(AppRoute.complaintForm,
                                        arguments: {
                                          'Logo': compliantController
                                                  .Complainttypedata[index]
                                                  .image ??
                                              "",
                                          'title': compliantController
                                                  .Complainttypedata[index]
                                                  .name ??
                                              "",
                                          'id': compliantController
                                                  .Complainttypedata[index]
                                                  .sId ??
                                              "",
                                          'Complaintdata':
                                              complaintItems[index].complaints,
                                        });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.primary.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: CachedNetworkImageProvider(
                                            compliantController
                                                    .Complaindatalist[index]
                                                    .image ??
                                                "",
                                            cacheManager: compliantController
                                                .cacheManager, // Use custom cache manager
                                            cacheKey:
                                                'complaint_image_$index', // Optional: Unique cache key
                                          ),
                                          fit: BoxFit.cover,
                                          height: 50.h,
                                          width: 50.w,
                                        ),
                                        // Image.network(
                                        //   compliantController
                                        //           .Complaindatalist[index]
                                        //           .image ??
                                        //       "",
                                        //   scale: 4,
                                        //   // height: 50.h,
                                        //   // width: 50.w,
                                        // ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            compliantController
                                                    .Complaindatalist[index]
                                                    .name ??
                                                "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColor.textblack),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
          ),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: -10,
          //   child: Container(height: 100.h, child: CustomBottomNavbar()),
          // ),
        ],
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      // floatingActionButton: const CenterButton(),
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}

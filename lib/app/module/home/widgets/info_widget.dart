import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/Storage/get_storage.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({
    super.key,
  });

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  final HomeController homeController = HomeController();

  String name = TokenStorage.getUsername() ?? "";

  final ProfileController profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    profileController.GetProfileData();
    return SafeArea(
      child: Column(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoute.profiledtail);
                      },
                      child: profileController.imagenothave.value == true
                          ? const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/9440456 1.png"),
                            )
                          : CircleAvatar(
                              key: UniqueKey(),
                              radius: 30,
                              foregroundImage: CachedNetworkImageProvider(
                                profileController.UserImage.value,
                                cacheManager: profileController.cacheManager,
                                cacheKey: 'images_Key',
                              ),
                              // CachedNetworkImageProvider(
                              //     profileController.profileDatas.value.image ??
                              //         "assets/images/9440456 1.png",
                              //     cacheManager: profileController.cacheManager,
                              //     cacheKey: 'images_Key'),
                              // backgroundImage: NetworkImage(
                              //     TokenStorage.getUserimage() ?? ""),
                            ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColor.white),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoute.profiledtail);
                          },
                          child: Text(
                            // "${TokenStorage.getUsername()}",
                            name,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w700),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoute.hosteldetail);
                          },
                          child: Row(
                            children: [
                              Text(
                                TokenStorage.getHostelname() ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColor.white),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.h),
                                child: const Icon(
                                  FeatherIcons.arrowUpRight,
                                  size: 14,
                                  color: AppColor.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // InkWell(
                    //   onTap: () {
                    //     Get.to(FaqView());
                    //   },
                    //   child: Icon(
                    //     Icons.help_outline,
                    //     color: Colors.white,
                    //   ),
                    // ),

                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Get.to(const NotificationView());
                      },
                      child: const Icon(
                        CupertinoIcons.bell,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}

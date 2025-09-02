import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/module/profile/widgets/profileAlertDilog.dart';
import 'package:yoco_stay_student/app/utils/media_utils.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

class userData extends StatefulWidget {
  const userData({
    super.key,
  });

  @override
  State<userData> createState() => _userDataState();
}

class _userDataState extends State<userData> {
  ProfileController profileController = ProfileController();
  String image = "";
  @override
  void initState() {
    super.initState();

    // profileController.Profiledetaildata();
    profileController.GetProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height:
              profileController.profileDatas.value.roomMatesData?.length == 0
                  ? 100.h
                  : 200.h,
          child: Stack(
            children: [
              Container(
                height: 120.h,
                decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 38, bottom: 28),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          profileController.imageupload.value == true
                              ? const Loader()
                              : Stack(
                                  children: [
                                    // profileController.imagenothave.value == true
                                    //     ? CircleAvatar(
                                    //         maxRadius: 60,
                                    //         backgroundColor: AppColor.white,
                                    //         backgroundImage: AssetImage(
                                    //             "assets/images/9440456 1.png"),
                                    //       )
                                    //     :
                                    Obx(
                                      () => CircleAvatar(
                                        key: UniqueKey(),
                                        maxRadius: 60,
                                        backgroundColor: AppColor.white,
                                        foregroundImage:
                                            CachedNetworkImageProvider(
                                          profileController.UserImage.value,
                                          cacheManager:
                                              profileController.cacheManager,
                                          cacheKey: 'images_Key',
                                        ),
                                        // CachedNetworkImageProvider(
                                        //     profileController
                                        //         .UserImage.value,
                                        //     cacheManager: profileController
                                        //         .cacheManager,
                                        //     cacheKey: 'images_Key'),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () async {
                                          // File? imageFile =
                                          //     await MediaUtils.pickImage();
                                          // if (imageFile != null) {
                                          //   imageCache.clear();
                                          //   imageCache.clearLiveImages();
                                          //   await profileController.PhotoUpdate(
                                          //       imageFile,
                                          //       profileController
                                          //           .profileDatas.value.email);
                                          // }

                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      leading: const Icon(
                                                        Icons.photo,
                                                        color: AppColor.primary,
                                                      ),
                                                      title: Text(
                                                        'Gallery',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                color: AppColor
                                                                    .textblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      onTap: () async {
                                                        Navigator.pop(context);

                                                        File? imageFile =
                                                            await MediaUtils
                                                                .pickImage();
                                                        if (imageFile != null) {
                                                          imageCache.clear();
                                                          imageCache
                                                              .clearLiveImages();
                                                          await profileController
                                                              .PhotoUpdate(
                                                                  imageFile,
                                                                  profileController
                                                                      .profileDatas
                                                                      .value
                                                                      .email);
                                                        }
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        color: AppColor.primary,
                                                      ),
                                                      title: Text(
                                                        'Camera',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                color: AppColor
                                                                    .textblack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      onTap: () async {
                                                        Navigator.pop(context);
                                                        File? imageFile =
                                                            await ImagePicker()
                                                                .pickImage(
                                                                    source: ImageSource
                                                                        .camera)
                                                                .then(
                                                                    (pickedFile) {
                                                          return pickedFile !=
                                                                  null
                                                              ? File(pickedFile
                                                                  .path)
                                                              : null;
                                                        });

                                                        if (imageFile != null) {
                                                          imageCache.clear();
                                                          imageCache
                                                              .clearLiveImages();
                                                          await profileController
                                                              .PhotoUpdate(
                                                            imageFile,
                                                            profileController
                                                                .profileDatas
                                                                .value
                                                                .email,
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                            color: AppColor.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: AppColor.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              CupertinoIcons.plus,
                                              color: AppColor.secondary,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            width: 20.w,
                          ),
                          profileController.profileLoading.value == true
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomShimmer(
                                      height: 10.h,
                                      width: 150.w,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomShimmer(
                                      height: 10.h,
                                      width: 150.w,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomShimmer(
                                      height: 10.h,
                                      width: 150.w,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CustomShimmer(
                                      height: 10.h,
                                      width: 150.w,
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      profileController
                                              .profileDatas.value.name ??
                                          "NA",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    Text(
                                      "${profileController.profileDatas.value.phone}",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    Text(
                                      profileController
                                              .profileDatas.value.uniqueId ??
                                          "NA",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.white,
                                      ),
                                    ),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: SizedBox(
                                              width: 150,
                                              child: Text(
                                                profileController.profileDatas
                                                        .value.email ??
                                                    "NA",
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 5.w,
                                          // ),
                                          InkWell(
                                            onTap: () {
                                              UpdateEmail(context);
                                            },
                                            child: const Icon(
                                              Icons.edit_square,
                                              size: 15,
                                              color: AppColor.secondary,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              profileController.profileDatas.value.roomMatesData?.length == 0
                  ? Container()
                  : Positioned(
                      bottom: 0,
                      left: 11,
                      child: profileController.profileLoading.value == true
                          ? CustomShimmer(
                              height: 94.h,
                              width: 339.w,
                              basecolor: AppColor.midpurple,
                              highcolor: AppColor.midpurple,
                            )
                          : Container(
                              height: 94.h,
                              width: 339.w,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, -2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 31,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "ROOM MATES",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                    color: AppColor.textgrey,
                                                    fontSize: 12),
                                          ),
                                          Text(
                                            "${profileController.profileDatas.value.roomMatesData?.length}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                    color: AppColor.textgrey,
                                                    fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: profileController
                                            .profileDatas
                                            .value
                                            .roomMatesData
                                            ?.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    barrierColor: AppColor
                                                        .primary
                                                        .withOpacity(0.8),
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return ProfileAlertDialog(
                                                        image: profileController
                                                                .profileDatas
                                                                .value
                                                                .roomMatesData?[
                                                                    index]
                                                                .image ??
                                                            "",
                                                        name: profileController
                                                                .profileDatas
                                                                .value
                                                                .roomMatesData?[
                                                                    index]
                                                                .name ??
                                                            "",
                                                        contactNumber:
                                                            "${profileController.profileDatas.value.roomMatesData?[index].phone ?? ""}",
                                                        emailId: profileController
                                                                .profileDatas
                                                                .value
                                                                .roomMatesData?[
                                                                    index]
                                                                .email ??
                                                            "",
                                                        roomNumber: profileController
                                                                .profileDatas
                                                                .value
                                                                .roomMatesData?[
                                                                    index]
                                                                .roomDetails ??
                                                            "",
                                                      );
                                                    },
                                                  );
                                                },
                                                child: profileController
                                                            .profileDatas
                                                            .value
                                                            .roomMatesData?[
                                                                index]
                                                            .image ==
                                                        null
                                                    ? CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            AppColor.primary
                                                                .withOpacity(
                                                                    0.5),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage: NetworkImage(
                                                            profileController
                                                                    .profileDatas
                                                                    .value
                                                                    .roomMatesData?[
                                                                        index]
                                                                    .image ??
                                                                ""),
                                                      ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
            ],
          ),
        ));
  }

  Future<dynamic> UpdateEmail(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: SizedBox(
          height: 200.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Edit Email",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: AppColor.textgrey, fontSize: 15),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextField(
                controller: profileController.EmailName,
                maxLines: null,
                decoration: InputDecoration(
                  counterText: "",
                  labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textblack, fontWeight: FontWeight.w700),
                  hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textgrey, fontWeight: FontWeight.w700),
                  hintText: 'Enter New Email',
                  filled: true,
                  fillColor: AppColor.grey6, // Background color
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 11.0,
                      horizontal: 20.0), // Padding inside the text field
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                    borderSide: BorderSide.none, // No border
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: CustomButton(
                  width: 100.w,
                  ontap: () {
                    profileController.EmailName.text == ""
                        ? Utils.showToast(
                            message: "Email Can't be Empty.",
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            fontsize: 16,
                          )
                        : profileController.EmailPhotoUpdate(profileController
                                    .profileDatas.value.image ==
                                null
                            ? "null"
                            : "${profileController.profileDatas.value.image}");
                  },
                  Title: 'Save Email',
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}

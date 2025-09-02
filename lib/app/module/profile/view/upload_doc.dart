// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/module/profile/model.dart';
import 'package:yoco_stay_student/app/module/profile/widgets/document_card.dart';
import 'package:yoco_stay_student/app/utils/media_utils.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/shimmerWidget/custom_shimmer.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({super.key});

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.GetKycDocData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'UPLOAD KYC DOCUMENT', trailingwidget: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: InkWell(
            onTap: () {
              Get.to(const NotificationView());
            },
            child: Container(
              width: 31.w,
              height: 31.h,
              decoration: BoxDecoration(
                color: AppColor.belliconbackround,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: const Icon(
                CupertinoIcons.bell,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ]),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            Obx(() => Positioned(
                  top: 25,
                  left: 11,
                  right: 10,
                  child: Container(
                      width: 339.w,
                      // height: 570.h,
                      decoration: BoxDecoration(
                        // color: AppColor.white,
                        borderRadius: BorderRadius.circular(15.0),
                        // border: Border.all(
                        //   color: Colors.blue,
                        //   width: 2,
                        // ),
                        boxShadow: const [
                          // BoxShadow(
                          //   color: AppColor.primary.withOpacity(0.2),
                          //   spreadRadius: 1,
                          //   blurRadius: 5,
                          //   offset:
                          //       Offset(-1, -2), // changes position of shadow
                          // ),
                          // BoxShadow(
                          //   color: Colors.black.withOpacity(0.2),
                          //   spreadRadius: 1,
                          //   blurRadius: 2,
                          //   offset: Offset(0, 2), // changes position of shadow
                          // ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: profileController.KYCDocLoading.value == true
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: kycitem.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    CustomShimmer(
                                      height: 50.h,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                );
                              },
                            )
                          : Column(
                              children: [
                                // Aadhaar Card Card
                                DocumentCard(
                                  cardname: "Aadhaar Card",
                                  image:
                                      "assets/images/profile_image/addhar_card.png",
                                  urlimage: profileController.profileDatas.value
                                      .documents?.aadhaarCard,
                                  Doctype: "png/jpg/jpeg",
                                  Status: profileController.profileDatas.value
                                              .documents?.aadhaarCard ==
                                          null
                                      ?
                                      // kycitem[index].uploaded == true
                                      //     ?
                                      "upload"
                                      : "uploaded",
                                  // : kycitem[index].error == true
                                  //     ? "notupload"
                                  //     : "upload",
                                  ontap: () async {
                                    final File? pickedFile =
                                        await MediaUtils.pickImage();

                                    if (pickedFile != null) {
                                      profileController.KycDocumentUpdate(
                                          pickedFile, "aadhaarCard", false);
                                    }
                                  },
                                  Delete: () async {
                                    _showLogoutDialog(context, "aadhaarCard");
                                    // final File? pickedFile =
                                    //     File('/path/to/voterCard.jpg');

                                    // profileController.KycDocumentUpdate(
                                    //     pickedFile, "aadhaarCard", true);
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                // Passport section
                                DocumentCard(
                                  cardname: "Passport",
                                  image:
                                      "assets/images/profile_image/passport.png",
                                  urlimage: profileController
                                      .profileDatas.value.documents?.passport,
                                  Doctype: "png/jpg/jpeg",
                                  Status: profileController.profileDatas.value
                                              .documents?.passport ==
                                          null
                                      ?
                                      // kycitem[index].uploaded == true
                                      //     ?
                                      "upload"
                                      : "uploaded",
                                  // : kycitem[index].error == true
                                  //     ? "notupload"
                                  //     : "upload",
                                  ontap: () async {
                                    final File? pickedFile =
                                        await MediaUtils.pickImage();

                                    if (pickedFile != null) {
                                      profileController.KycDocumentUpdate(
                                          pickedFile, "passport", false);
                                    }
                                  },
                                  Delete: () async {
                                    // final File? pickedFile =
                                    //     File('/path/to/voterCard.jpg');

                                    // profileController.KycDocumentUpdate(
                                    //     pickedFile, "passport", true);

                                    _showLogoutDialog(context, "passport");
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                // Voter Card section
                                DocumentCard(
                                  cardname: "Voter Card",
                                  image:
                                      "assets/images/profile_image/voter_id.png",
                                  urlimage: profileController
                                      .profileDatas.value.documents?.voterCard,
                                  Doctype: "png/jpg/jpeg",
                                  Status: profileController.profileDatas.value
                                              .documents?.voterCard ==
                                          null
                                      ?
                                      // kycitem[index].uploaded == true
                                      //     ?
                                      "upload"
                                      : "uploaded",
                                  // : kycitem[index].error == true
                                  //     ? "notupload"
                                  //     : "upload",
                                  ontap: () async {
                                    final File? pickedFile =
                                        await MediaUtils.pickImage();

                                    if (pickedFile != null) {
                                      profileController.KycDocumentUpdate(
                                          pickedFile, "voterCard", false);
                                    }
                                  },
                                  Delete: () async {
                                    _showLogoutDialog(context, "voterCard");
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                // Driving License section
                                DocumentCard(
                                  cardname: "Driving License",
                                  image:
                                      "assets/images/profile_image/driving_licence.png",
                                  urlimage: profileController.profileDatas.value
                                      .documents?.drivingLicense,
                                  Doctype: "png/jpg/jpeg",
                                  Status: profileController.profileDatas.value
                                              .documents?.drivingLicense ==
                                          null
                                      ?
                                      // kycitem[index].uploaded == true
                                      //     ?
                                      "upload"
                                      : "uploaded",
                                  // : kycitem[index].error == true
                                  //     ? "notupload"
                                  //     : "upload",
                                  ontap: () async {
                                    final File? pickedFile =
                                        await MediaUtils.pickImage();

                                    if (pickedFile != null) {
                                      profileController.KycDocumentUpdate(
                                          pickedFile, "drivingLicense", false);
                                    }
                                  },
                                  Delete: () async {
                                    // final File? pickedFile =
                                    //     File('/path/to/voterCard.jpg');

                                    // profileController.KycDocumentUpdate(
                                    //     pickedFile, "drivingLicense", true);
                                    _showLogoutDialog(
                                        context, "drivingLicense");
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),

                                // PAN Card section
                                DocumentCard(
                                  cardname: "PAN Card",
                                  image:
                                      "assets/images/profile_image/pen_card.png",
                                  urlimage: profileController
                                      .profileDatas.value.documents?.panCard,
                                  Doctype: "png/jpg/jpeg",
                                  Status: profileController.profileDatas.value
                                              .documents?.panCard ==
                                          null
                                      ?
                                      // kycitem[index].uploaded == true
                                      //     ?
                                      "upload"
                                      : "uploaded",
                                  // : kycitem[index].error == true
                                  //     ? "notupload"
                                  //     : "upload",
                                  ontap: () async {
                                    final File? pickedFile =
                                        await MediaUtils.pickImage();

                                    if (pickedFile != null) {
                                      profileController.KycDocumentUpdate(
                                          pickedFile, "panCard", false);
                                    }
                                  },
                                  Delete: () async {
                                    // final File? pickedFile =
                                    //     File('/path/to/voterCard.jpg');

                                    // profileController.KycDocumentUpdate(
                                    //     pickedFile, "panCard", true);
                                    _showLogoutDialog(context, 'panCard');
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                profileController.KYCDocUploadLoading.value ==
                                        true
                                    ? const Loader()
                                    : Container(),
                              ],
                            )),
                ))
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            "Are you Sure to Delete this?",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColor.textblack,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            CustomButton(
              Title: "Yes",
              ontap: () async {
                final File pickedFile = File('/path/to/voterCard.jpg');

                profileController.KycDocumentUpdate(pickedFile, type, true);
              },
              width: 100.w,
              BoxColor: AppColor.primary,
              textcolor: AppColor.white,
              Textsize: 20,
            ),
            CustomButton(
              Title: "No",
              ontap: () {
                Get.back();
              },
              width: 100.w,
              BoxColor: AppColor.primary,
              textcolor: AppColor.white,
              Textsize: 20,
            ),
          ],
        );
      },
    );
  }
}

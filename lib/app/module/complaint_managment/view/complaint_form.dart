// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/controller/controller.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/complain_model.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/widgets/complain_section_widegts.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/widgets/file_attach_section.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';
import 'package:yoco_stay_student/app/widgets/yellow_input_box.dart';

class CompliantFromPage extends StatefulWidget {
  // final String Logo;
  // final String title;
  // final String id;
  // final List<Complaint> Complaintdata;
  const CompliantFromPage({
    super.key,
  });

  @override
  State<CompliantFromPage> createState() => _CompliantFromPageState();
}

class _CompliantFromPageState extends State<CompliantFromPage> {
  final Logo = Get.arguments['Logo'];
  final title = Get.arguments['title'];
  final List<Complaint> Complaintdata = Get.arguments['Complaintdata'];
  final id = Get.arguments['id'];
  final CompliantController controller = Get.put(CompliantController());

  @override
  void initState() {
    super.initState();
    controller.recordingPath = null;
    controller.GetComplaintList(id);
    controller.SelectedComplaintid.clear();
    controller.Description.clear();
    controller.ImageUpload = "";
    controller.mp3fileUrl = "";
    controller.imageFileList.clear();
    controller.recordingStatus(false);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar(
              titlewidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    Logo,
                    width: 50.w,
                    height: 50.h,
                  ),
                  Text(
                    title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppColor.white, fontSize: 12),
                  )
                ],
              ),
              trailingwidget: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
              ]),
          body: stackcontainer(
            Shadow: true,
            writedata: Column(
              children: [
                SizedBox(
                  height: 500.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title == "others"
                                ? const SizedBox(
                                    height: 20,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9, vertical: 15),
                                    child: Text(
                                      "Common Complaints*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: AppColor.textgrey,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                            ComplaintList(
                              id: id,
                            ),
                            WriteDescriotion(controller: controller),
                            const AttachFile(),
                            Obx(() => controller.imageFileList.isEmpty
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 150.h,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Image.file(
                                              File(controller
                                                  .imageFileList[0].path),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Positioned(
                                              right: 10,
                                              child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      controller.imageFileList
                                                          .removeAt(0);
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: AppColor.primary,
                                                  )))
                                        ],
                                      ),
                                    ),
                                  )),
                            const SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      boxShadow: const [
                        // BoxShadow(
                        //     color: AppColor.black.withOpacity(0.1),
                        //     blurRadius: 0.5,
                        //     spreadRadius: 0.5,
                        //     offset: Offset(1, 0)),
                        // BoxShadow(
                        //     color: AppColor.black.withOpacity(0.1),
                        //     blurRadius: 0.1,
                        //     spreadRadius: 0.1,
                        //     offset: Offset(1, 0)),
                      ]),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => controller.ComplainLoading.value == true
                          ? const Loader()
                          : CustomButton(
                              ontap: () {
                                controller.CreateComplaint();
                              },
                              Title: 'SEND',
                              Textsize: 15,
                            ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

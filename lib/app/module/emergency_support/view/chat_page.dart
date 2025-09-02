import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/emergency_support/controller/emergency_controller.dart';
import 'package:yoco_stay_student/app/module/emergency_support/model/emergency_list_model.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';

import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class EmergencyChatPage extends StatefulWidget {
  const EmergencyChatPage({super.key});

  @override
  State<EmergencyChatPage> createState() => _EmergencyChatPageState();
}

class _EmergencyChatPageState extends State<EmergencyChatPage> {
  final EmergencyController controller = Get.put(EmergencyController());

  bool massages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
            titlewidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/drawer/emergency.png',
                  width: 40.w,
                  height: 40.h,
                ),
                Text(
                  "EMERGENCY SUPPORT",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColor.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
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
            ]),
        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: stackcontainer(
            Shadow: true,
            writedata: Column(
              children: [
                SizedBox(
                  height: 500.h,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: chates.length,
                        itemBuilder: (BuildContext context, int index) {
                          return chates[index].user == "Reciver"
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.midyello,
                                        borderRadius:
                                            BorderRadius.circular(19.r),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        chates[index].message,
                                        style: GoogleFonts.inter(
                                          fontSize: 13.66,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.textblack,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: Text(
                                        "12:15 PM",
                                        style: GoogleFonts.inter(
                                          fontSize: 10.93,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.textblack,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.peach,
                                        borderRadius:
                                            BorderRadius.circular(19.r),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        chates[index].message,
                                        style: GoogleFonts.inter(
                                          fontSize: 13.66,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.textblack,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
                                      child: Text(
                                        "12:15 PM",
                                        style: GoogleFonts.inter(
                                          fontSize: 10.93,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.textblack,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  // height: 50.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.grey5),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5),
                  child: TextField(
                    controller: controller.message,
                    maxLines: null,
                    onSubmitted: (value) {
                      chates.add(Chat(
                        id: chates.length + 1,
                        user: 'sender',
                        message: controller.message.text,
                      ));
                      controller.message.clear();
                    },
                    onChanged: (value) {
                      setState(() {
                        Value == '' ? massages = false : massages = true;
                      });
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      labelStyle:
                          Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColor.textblack,
                                fontWeight: FontWeight.w700,
                              ),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              color: AppColor.textgrey,
                              fontWeight: FontWeight.w700),
                      hintText: 'Type here...',
                      filled: true,
                      fillColor: AppColor.white, // Background color
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 25.0),
                      // Padding inside the text field
            
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            decoration: const BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.add,
                              color: AppColor.white,
                              size: 25.h,
                            )),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppColor.primary,
                              shape: BoxShape.circle),
                          child:
                              // massages ==false ?
                              InkWell(
                            onTap: () {
                              massages == false
                                  ? {}
                                  : {
                                      setState(() {
                                        chates.add(Chat(
                                          id: chates.length + 1,
                                          user: 'sender',
                                          message: controller.message.text,
                                        ));
                                        controller.message.clear();
                                        massages = false;
                                      })
                                    };
                            },
                            child: Icon(
                              massages == false
                                  ? Icons.mic
                                  : CupertinoIcons.chevron_forward,
                              size: 20.h,
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5),
            //   child: Text("hekko"),
            // ),
          ),
        ));
  }
}

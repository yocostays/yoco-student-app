import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';
import 'package:yoco_stay_student/app/module/profile/models/vehicle_add_class.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/input_center_textfield.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';
import 'package:yoco_stay_student/app/widgets/vehicle_card.dart';

class VihcleDetailPage extends StatefulWidget {
  const VihcleDetailPage({super.key});

  @override
  State<VihcleDetailPage> createState() => _VihcleDetailPageState();
}

class _VihcleDetailPageState extends State<VihcleDetailPage> {
  final ProfileController profilecontroller = ProfileController();

  @override
  void initState() {
    super.initState();
    profilecontroller.GetProfileData();
  }

  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: 'VEHICLE DETAILS', trailingwidget: [
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
        body: Obx(
          () => stackcontainer(
            writedata: profilecontroller.profileLoading.value == true
                ? const Loader()
                : Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  // color: Colors.amber,
                                  height: 140.h,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: profilecontroller
                                        .ProfilevehicleList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: VihcelCard(
                                              ontap: () {
                                                setState(() {
                                                  selected == index + 1
                                                      ? {
                                                          selected = 0,
                                                          profilecontroller
                                                              .vechicleType
                                                              .clear(),
                                                        }
                                                      : {
                                                          selected = index + 1,
                                                          profilecontroller
                                                                  .vechicleType
                                                                  .text =
                                                              profilecontroller
                                                                  .ProfilevehicleList[
                                                                      index]
                                                                  .value,
                                                        };
                                                });
                                              },
                                              image: profilecontroller
                                                  .ProfilevehicleList[index]
                                                  .image,
                                              Name: profilecontroller
                                                  .ProfilevehicleList[index]
                                                  .name,
                                              selected: selected == index + 1
                                                  ? true
                                                  : false,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                profilecontroller.vechicleType.text == "bycycle"
                                    ? Container()
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Selecte Vehicle type",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge
                                                  ?.copyWith(
                                                      color: AppColor.textgrey,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                profilecontroller.vechicleType.text == "bycycle"
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 80),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // Radio Button 1
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "ev",
                                                  groupValue: profilecontroller
                                                      .engineType.text,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      profilecontroller
                                                          .engineType
                                                          .text = value!;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "EV",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge
                                                      ?.copyWith(
                                                          color:
                                                              AppColor.textgrey,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),

                                            // Add spacing between the buttons

                                            // Radio Button 2
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: "fuel",
                                                  groupValue: profilecontroller
                                                      .engineType.text,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      profilecontroller
                                                          .engineType
                                                          .text = value!;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  "FUEL",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayLarge
                                                      ?.copyWith(
                                                          color:
                                                              AppColor.textgrey,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                profilecontroller.vechicleType.text == "bycycle"
                                    ? Container()
                                    : InputCenterTextfield(
                                        Controller:
                                            profilecontroller.vechicleNumber,
                                        onchange: (String) {},
                                        title: "VEHICLE NUMBER",
                                        hint: 'Vehicle Number',
                                      ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                InputCenterTextfield(
                                  Controller: profilecontroller.modelName,
                                  onchange: (String) {},
                                  title: "MODEL/COMPANY",
                                  hint: 'Vehicle Model',
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 21),
                                  child: CustomButton(
                                    ontap: () {
                                      profilecontroller.vechicleType.text == ""
                                          ? Utils.showToast(
                                              message:
                                                  "Please Select a Vehicle!",
                                              gravity: ToastGravity.CENTER,
                                              textColor: Colors.white,
                                              fontsize: 16,
                                            )
                                          : profilecontroller.VehicleDetailsdata
                                              .add(AddVechicleDetails(
                                              vechicleType: profilecontroller
                                                  .vechicleType.text,
                                              engineType: profilecontroller
                                                  .engineType.text,
                                              vechicleNumber: profilecontroller
                                                  .vechicleNumber.text,
                                              modelName: profilecontroller
                                                  .modelName.text,
                                            ));
                                      setState(() {
                                        selected = 0;
                                        profilecontroller.vechicleType.clear();
                                        profilecontroller.vechicleType.clear();
                                        profilecontroller.engineType.clear();
                                        profilecontroller.vechicleNumber
                                            .clear();
                                        profilecontroller.modelName.clear();
                                      });
                                      print(
                                          "add data : ${profilecontroller.VehicleDetailsdata[0].engineType}");
                                    },
                                    Title: 'ADD',
                                    textcolor: AppColor.primary,
                                    Textsize: 14,
                                    fontWeight: FontWeight.bold,
                                    BoxColor:
                                        AppColor.secondary.withOpacity(0.2),
                                    Boderradius: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                profilecontroller.VehicleDetailsdata.isEmpty
                                    ? Container()
                                    : ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: profilecontroller
                                            .VehicleDetailsdata.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue,
                                                        width:
                                                            2), // Set the border color and width
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20), // Optional: To make the border rounded
                                                  ),
                                                  child: ListTile(
                                                    leading: profilecontroller
                                                                .VehicleDetailsdata[
                                                                    index]
                                                                .vechicleType ==
                                                            "bycycle"
                                                        ? const Icon(
                                                            Icons
                                                                .pedal_bike_sharp,
                                                            color: AppColor
                                                                .primary,
                                                            size: 30,
                                                          )
                                                        : profilecontroller
                                                                    .VehicleDetailsdata[
                                                                        index]
                                                                    .vechicleType ==
                                                                "four wheeler"
                                                            ? const Icon(
                                                                Icons
                                                                    .car_repair,
                                                                color: AppColor
                                                                    .primary,
                                                                size: 30,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .motorcycle,
                                                                color: AppColor
                                                                    .primary,
                                                                size: 30,
                                                              ),
                                                    title: Text(
                                                      profilecontroller
                                                                  .VehicleDetailsdata[
                                                                      index]
                                                                  .vechicleType ==
                                                              "bycycle"
                                                          ? profilecontroller
                                                              .VehicleDetailsdata[
                                                                  index]
                                                              .vechicleType!
                                                              .toUpperCase()
                                                          : profilecontroller
                                                              .VehicleDetailsdata[
                                                                  index]
                                                              .vechicleNumber!
                                                              .toUpperCase(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayLarge
                                                          ?.copyWith(
                                                              color: AppColor
                                                                  .textgrey,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    trailing: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          profilecontroller
                                                                  .VehicleDetailsdata
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: AppColor.primary,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                profilecontroller.VehicleDetailsdata.isEmpty
                                    ? SizedBox(
                                        height: 50.h,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Divider(
                            color: AppColor.black,
                            thickness: 0.2,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 21),
                              child: Obx(
                                () => profilecontroller.VehicleLoading.value ==
                                        true
                                    ? const Loader()
                                    : CustomButton(
                                        ontap: () {
                                          profilecontroller
                                                  .VehicleDetailsdata.isEmpty
                                              ? Utils.showToast(
                                                  message:
                                                      "Please Select a Vehicle!",
                                                  gravity: ToastGravity.CENTER,
                                                  textColor: Colors.white,
                                                  fontsize: 16,
                                                )
                                              : profilecontroller.VehicleUpload(
                                                  profilecontroller
                                                      .profileDatas
                                                      .value
                                                      .vechicleDetails!
                                                      .isEmpty);
                                        },
                                        Title: 'Submit',
                                        Textsize: 14,
                                        fontWeight: FontWeight.bold,
                                        BoxColor: AppColor.textprimary,
                                        Boderradius: 20,
                                      ),
                              )),
                        ],
                      )
                    ],
                  ),
          ),
        ));
  }
}

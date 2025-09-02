import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/controller/controller.dart';
import 'package:yoco_stay_student/app/widgets/loader_widgets.dart';

class ComplaintList extends StatefulWidget {
  final String id;
  const ComplaintList({
    super.key,
    required this.id,
  });

  @override
  State<ComplaintList> createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  final CompliantController compliantController =
      Get.put(CompliantController());
  @override
  void initState() {
    super.initState();
    compliantController.GetComplaintList(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      compliantController.Complaintsubtypedata.length == 1
          ? compliantController.SelectedComplaintid.text =
              compliantController.Complaintsubtypedata[0].sId ?? ""
          : 0;
      return Container(
        child: compliantController.ComplaintsListdataload.value == true
            ? const Loader()

            // ListView.builder(
            //     physics: NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     itemCount: compliantController.Complaintsubtypedata.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 4),
            //         child: Column(
            //           children: [
            //             CustomShimmer(
            //               height: 20,
            //             ),
            //             SizedBox(
            //               height: 5.h,
            //             )
            //           ],
            //         ),
            //       );
            //     },
            //   )

            : Builder(
                builder: (context) {
                  // Separate 'Others' from the rest of the list
                  List<dynamic> sortedData =
                      List.from(compliantController.Complaintsubtypedata);
                  var othersItem = sortedData.firstWhere(
                      (item) => item.name == "Others",
                      orElse: () => null);

                  if (othersItem != null) {
                    sortedData.remove(othersItem);
                    sortedData
                        .add(othersItem); // Add 'Others' to the end of the list
                  }

                  return compliantController.Complaintsubtypedata.length == 1
                      ? Container()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: sortedData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        compliantController.SelectedComplaintid
                                                .text.isEmpty
                                            ? compliantController
                                                    .SelectedComplaintid.text =
                                                sortedData[index].sId ?? ""
                                            : compliantController
                                                        .SelectedComplaintid
                                                        .text ==
                                                    sortedData[index].sId
                                                ? compliantController
                                                    .SelectedComplaintid
                                                    .text = ""
                                                : compliantController
                                                        .SelectedComplaintid
                                                        .text =
                                                    sortedData[index].sId ?? "";
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: compliantController
                                                    .SelectedComplaintid.text ==
                                                sortedData[index].sId
                                            ? AppColor.secondary
                                            : AppColor.primary.withOpacity(0.2),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        sortedData[index].name ?? "",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: AppColor.textblack,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
      );
    });
  }
}

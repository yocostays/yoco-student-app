import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/profile/widgets/full_image_view.dart';

// ignore: must_be_immutable
class DocumentCard extends StatelessWidget {
  String? image;
  String? urlimage;
  String? cardname;
  String? Doctype;
  String? Status;
  Icon? iconsname;
  Function()? ontap;
  Function()? Delete;
  DocumentCard({
    super.key,
    this.image,
    this.urlimage,
    this.cardname,
    this.Doctype,
    this.Status,
    this.iconsname,
    this.ontap,
    this.Delete,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    print("screen width size: $w");
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15.0),
        // border: Border.all(
        //   color: Colors.blue,
        //   width: 2,
        // ),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-0, -1), // changes position of shadow
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          urlimage != null
              ? InkWell(
                  onTap: () {
                    Get.to(() => FullScreenImagePage(
                          imageUrl: urlimage!,
                        ));
                  },
                  child: Image.network(
                    urlimage!,
                    // scale: 3,
                    height: 50,
                    width: 50,
                  ),
                )
              : Image.asset(
                  "$image",
                  // scale: 4,
                  height: 50,
                  width: 50,
                ),
          SizedBox(
            width: Status == "notupload" ? w * 0.25.w : w * 0.3.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardname ?? "",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColor.black,
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  textAlign: TextAlign.start,
                  Doctype ?? "",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColor.grey3,
                      fontSize: w * 0.038,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          // Status == "upload"
          //     ? Container(
          //         width: 55.w,
          //       )
          //     : Container(),
          // Container(),
          Status == "upload"
              ? SizedBox(
                  width: w * 0.2.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: ontap,
                        child: const Icon(
                          Icons.file_upload_outlined,
                          color: AppColor.grey3,
                        ),
                      )
                    ],
                  ),
                )
              : Status == "notupload"
                  ? SizedBox(
                      width: w * 0.25.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Uploaded Failed",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    color: AppColor.textgrey,
                                    fontSize: w * 0.028,
                                    fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          InkWell(
                            onTap: ontap,
                            child: const Icon(
                              FeatherIcons.alertTriangle,
                              color: AppColor.red,
                            ),
                          )
                        ],
                      ),
                    )
                  : Status == "uploaded"
                      ? SizedBox(
                          width: w * 0.2.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "3 mb",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                        color: AppColor.grey3,
                                        fontSize: w * 0.028,
                                        fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              InkWell(
                                onTap: Delete,
                                child: Image.asset(
                                  "assets/images/profile_image/bin.png",
                                  scale: 5,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
        ],
      ),
    );
  }
}

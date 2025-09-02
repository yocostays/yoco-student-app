import 'package:get/get.dart';
import 'package:yoco_stay_student/app/core/values/icons.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';

class EventController extends GetxController {
  List<Detail> eventlogodata = [
    Detail(
      name: "Download Receipt",
      url: AppIcon.download(),
    ),
    Detail(
      name: "Share Receipt",
      url: AppIcon.share(),
    ),
    Detail(
      name: "Payment Support",
      url: AppIcon.circlequestion(),
    ),
  ];

  RxBool ticketDetails = false.obs;
}

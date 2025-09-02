import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/controller/controller.dart';

class CompliantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompliantController());
  }
}

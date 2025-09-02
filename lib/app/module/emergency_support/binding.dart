import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/emergency_support/controller/emergency_controller.dart';

class EmergencySupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmergencyController());
  }
}

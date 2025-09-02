import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/visitor_parking_status/controller/ve_slot_controller.dart';

class EvSlotBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => vehiclepassController());
  }
}

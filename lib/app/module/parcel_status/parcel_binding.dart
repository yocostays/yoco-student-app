import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/parcel_status/controller/parcel_controller.dart';

class ParcelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ParcelController());
  }
}

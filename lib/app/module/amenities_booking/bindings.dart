import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/amenities_booking/controller.dart';

class AmenitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AmenitiesController());
  }
}

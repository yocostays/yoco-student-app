import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/profile/controller/controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}

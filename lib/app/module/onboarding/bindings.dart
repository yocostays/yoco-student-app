import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/onboarding/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

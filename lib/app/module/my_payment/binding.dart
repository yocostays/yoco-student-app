import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/my_payment/controller.dart';

class MyPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyPaymentController());
  }
}

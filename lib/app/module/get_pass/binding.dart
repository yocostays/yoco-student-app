import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/get_pass/repository.dart';

class GetPassBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => GetPassController());
  }
}

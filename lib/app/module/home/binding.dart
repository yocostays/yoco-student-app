import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/home/repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeController());
  }
}

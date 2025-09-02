import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/leave_status/repository.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveController());
  }
}

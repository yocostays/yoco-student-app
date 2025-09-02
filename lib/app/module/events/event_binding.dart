import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/events/controller/event_controller.dart';

class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());
  }
}

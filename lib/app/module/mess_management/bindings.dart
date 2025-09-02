import 'package:get/get.dart';

import 'repository.dart';

class MessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessController());
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EvSlotController extends GetxController {
  RxInt Selectebooking = 0.obs;
  final TextEditingController Boolingdate = TextEditingController();
  final TextEditingController TimeRange = TextEditingController();
  final TextEditingController Noofhours = TextEditingController();
  final TextEditingController vehiclenumber = TextEditingController();
  final TextEditingController model = TextEditingController();

  RxInt selectedindex = 0.obs;
  RxInt selected = 4.obs;
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class vehiclepassController extends GetxController {
  RxInt Selectebooking = 0.obs;
  final TextEditingController Boolingdate = TextEditingController();
  final TextEditingController TimeRange = TextEditingController();
  final TextEditingController ArrivelTimeRange = TextEditingController();
  final TextEditingController Arriveldate = TextEditingController();
  final TextEditingController Departuredate = TextEditingController();
  final TextEditingController Departuretime = TextEditingController();
  final TextEditingController Noofhours = TextEditingController();
  final TextEditingController vehiclenumber = TextEditingController();
  final TextEditingController model = TextEditingController();

  RxInt selectedindex = 0.obs;
  RxInt selected = 4.obs;
}

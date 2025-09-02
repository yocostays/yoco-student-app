import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/my_payment/model.dart';

class MyPaymentController extends GetxController {
  RxInt Fineduestotal = 0.obs;
  RxInt Outstandingfee = 0.obs;
  // fine dues
  List<int> fineselected = [];
  RxInt Finedues = 0.obs;

  RxInt SelectedFinedue = 0.obs;

  finedueSelecteallfile(bool totaladd) {
    finedueslist
        .map((item) =>
            {fineselected.add(item.id - 1), SelectedFinedue += item.price})
        .toList();
    totaladd == true ? Finedues = SelectedFinedue : 0;
  }

  payforeventselceteall() {
    finedueslist
        .map((item) => {fineselected.add(item.id - 1), Finedues += item.price})
        .toList();
  }
}

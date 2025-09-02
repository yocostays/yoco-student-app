import 'package:yoco_stay_student/app/module/mess_management/model/cencel_history_data.dart';

class CencelHistoryResponce {
  int? statusCode;
  String? message;
  List<CencelHistoryData>? date;

  CencelHistoryResponce({this.statusCode, this.message, this.date});

  CencelHistoryResponce.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['date'] != null) {
      date = <CencelHistoryData>[];
      json['date'].forEach((v) {
        date!.add(CencelHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (date != null) {
      data['date'] = date!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

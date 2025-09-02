import 'package:yoco_stay_student/app/module/home/models/today_menu_model.dart';

class TodayMenuResponse {
  int? statusCode;
  String? message;
  TodayMenuModel? data;

  TodayMenuResponse({this.statusCode, this.message, this.data});

  TodayMenuResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? TodayMenuModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

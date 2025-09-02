import 'package:yoco_stay_student/app/module/home/models/total_data_home.dart';

class TotalSectionDataResponse {
  int? statusCode;
  String? message;
  TotalHomedata? data;

  TotalSectionDataResponse({this.statusCode, this.message, this.data});

  TotalSectionDataResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? TotalHomedata.fromJson(json['data']) : null;
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

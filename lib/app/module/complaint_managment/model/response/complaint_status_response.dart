import 'package:yoco_stay_student/app/module/complaint_managment/model/comolaint_status_model.dart';

class ComplaintedListResponse {
  int? statusCode;
  String? message;
  List<ComplaintedListModel>? data;

  ComplaintedListResponse({this.statusCode, this.message, this.data});

  ComplaintedListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ComplaintedListModel>[];
      json['data'].forEach((v) {
        data!.add(ComplaintedListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

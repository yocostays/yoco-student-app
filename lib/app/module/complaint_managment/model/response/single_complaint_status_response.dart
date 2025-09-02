import 'package:yoco_stay_student/app/module/complaint_managment/model/single_complaint_status_Model.dart';

class ComplaintStatusResponse {
  int? statusCode;
  String? message;
  List<SingleComplaintStatusModel>? data;

  ComplaintStatusResponse({this.statusCode, this.message, this.data});

  ComplaintStatusResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SingleComplaintStatusModel>[];
      json['data'].forEach((v) {
        data!.add(SingleComplaintStatusModel.fromJson(v));
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

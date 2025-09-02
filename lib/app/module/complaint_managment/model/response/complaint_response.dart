import 'package:yoco_stay_student/app/module/complaint_managment/model/complaint_data_model.dart';

class ComplainModelResponse {
  int? statusCode;
  String? message;
  List<ComplaintDataModel>? data;

  ComplainModelResponse({this.statusCode, this.message, this.data});

  ComplainModelResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ComplaintDataModel>[];
      json['data'].forEach((v) {
        data!.add(ComplaintDataModel.fromJson(v));
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

import 'package:yoco_stay_student/app/module/complaint_managment/model/comalain_sub_type_model.dart';

class ComplainTypeListResponse {
  int? statusCode;
  String? message;
  List<ComplainSupType>? data;

  ComplainTypeListResponse({this.statusCode, this.message, this.data});

  ComplainTypeListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ComplainSupType>[];
      json['data'].forEach((v) {
        data!.add(ComplainSupType.fromJson(v));
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

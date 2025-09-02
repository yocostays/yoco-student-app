import 'package:yoco_stay_student/app/module/leave_status/models/leave_category_model.dart';

class LeaveCategoryResponse {
  int? statusCode;
  String? message;
  List<LeaveCategoryModel>? data;

  LeaveCategoryResponse({this.statusCode, this.message, this.data});

  LeaveCategoryResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeaveCategoryModel>[];
      json['data'].forEach((v) {
        data!.add(LeaveCategoryModel.fromJson(v));
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

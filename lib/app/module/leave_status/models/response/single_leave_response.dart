import 'package:yoco_stay_student/app/module/leave_status/models/single_leave_status_model.dart';

class SingleLeaveStatusResponse {
  int? statusCode;
  String? message;
  List<SingleLeaveStatusModel>? data;

  SingleLeaveStatusResponse({this.statusCode, this.message, this.data});

  SingleLeaveStatusResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SingleLeaveStatusModel>[];
      json['data'].forEach((v) {
        data!.add(SingleLeaveStatusModel.fromJson(v));
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

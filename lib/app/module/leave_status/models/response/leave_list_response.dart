import 'package:yoco_stay_student/app/module/leave_status/models/leave_list_model.dart';

class LeaveListResponse {
  int? statusCode;
  String? message;
  int? count;
  List<LeaveListModel>? data;

  LeaveListResponse({this.statusCode, this.message, this.count, this.data});

  LeaveListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = <LeaveListModel>[];
      json['data'].forEach((v) {
        data!.add(LeaveListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

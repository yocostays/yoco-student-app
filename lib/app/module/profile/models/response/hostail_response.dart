import 'package:yoco_stay_student/app/module/profile/models/hostail_Model.dart';

class HostelDetailResponse {
  int? statusCode;
  String? message;
  HostelDetailData? data;

  HostelDetailResponse({this.statusCode, this.message, this.data});

  HostelDetailResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data =
        json['data'] != null ? HostelDetailData.fromJson(json['data']) : null;
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

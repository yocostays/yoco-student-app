import 'package:yoco_stay_student/app/module/onboarding/model/hostal_model.dart';

class HostelListResponse {
  int? statusCode;
  String? message;
  List<HostelListModel>? data;

  HostelListResponse({this.statusCode, this.message, this.data});

  HostelListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HostelListModel>[];
      json['data'].forEach((v) {
        data!.add(HostelListModel.fromJson(v));
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

  // void assignAll(List<HostelListModel> list) {}
}

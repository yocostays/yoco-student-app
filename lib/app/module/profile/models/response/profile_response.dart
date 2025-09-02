import 'package:yoco_stay_student/app/module/profile/models/profile_model.dart';

class ProfileResponse {
  int? statusCode;
  String? message;
  ProfileData? data;

  ProfileResponse({this.statusCode, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
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

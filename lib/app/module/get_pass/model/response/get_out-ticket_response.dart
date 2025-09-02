import 'package:yoco_stay_student/app/module/get_pass/model/get_approve_model.dart';

class GetOutTicketResponse {
  int? statusCode;
  String? message;
  GetOutApproveModel? data;

  GetOutTicketResponse({this.statusCode, this.message, this.data});

  GetOutTicketResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data =
        json['data'] != null ? GetOutApproveModel.fromJson(json['data']) : null;
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

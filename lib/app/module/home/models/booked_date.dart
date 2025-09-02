class BookedDateResponse {
  int? statusCode;
  String? message;
  List<String>? date;

  BookedDateResponse({this.statusCode, this.message, this.date});

  BookedDateResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    date = json['date'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['date'] = date;
    return data;
  }
}

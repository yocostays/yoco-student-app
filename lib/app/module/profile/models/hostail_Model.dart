class HostelDetailData {
  String? sId;
  String? name;
  String? address;
  String? description;
  int? phone;
  int? guardianContactNo;
  List<String>? roomMates;
  String? bedDetails;

  HostelDetailData(
      {this.sId,
      this.name,
      this.address,
      this.description,
      this.phone,
      this.guardianContactNo,
      this.roomMates,
      this.bedDetails});

  HostelDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    phone = json['phone'];
    guardianContactNo = json['guardianContactNo'];
    roomMates = json['roomMates'].cast<String>();
    bedDetails = json['bedDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['address'] = address;
    data['description'] = description;
    data['phone'] = phone;
    data['guardianContactNo'] = guardianContactNo;
    data['roomMates'] = roomMates;
    data['bedDetails'] = bedDetails;
    return data;
  }
}

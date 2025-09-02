class GetOutApproveModel {
  String? sId;
  String? gatepassNumber;
  String? leaveStatus;

  GetOutApproveModel({this.sId, this.gatepassNumber, this.leaveStatus});

  GetOutApproveModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gatepassNumber = json['gatepassNumber'];
    leaveStatus = json['leaveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['gatepassNumber'] = gatepassNumber;
    data['leaveStatus'] = leaveStatus;
    return data;
  }
}

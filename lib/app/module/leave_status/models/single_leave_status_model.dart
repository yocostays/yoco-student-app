class SingleLeaveStatusModel {
  String? sId;
  String? leaveStatus;
  String? approvalStatus;
  Null date;
  Null remark;
  Null updatedBy;

  SingleLeaveStatusModel(
      {this.sId,
      this.leaveStatus,
      this.approvalStatus,
      this.date,
      this.remark,
      this.updatedBy});

  SingleLeaveStatusModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    leaveStatus = json['leaveStatus'];
    approvalStatus = json['approvalStatus'];
    date = json['date'];
    remark = json['remark'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['leaveStatus'] = leaveStatus;
    data['approvalStatus'] = approvalStatus;
    data['date'] = date;
    data['remark'] = remark;
    data['updatedBy'] = updatedBy;
    return data;
  }
}

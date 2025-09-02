class SingleComplaintStatusModel {
  String? sId;
  String? date;
  String? remark;
  String? complainStatus;
  UpdatedBy? updatedBy;
  String? assignedStaffName;
  int? phone;

  SingleComplaintStatusModel(
      {this.sId,
      this.date,
      this.remark,
      this.complainStatus,
      this.updatedBy,
      this.assignedStaffName,
      this.phone});

  SingleComplaintStatusModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    remark = json['remark'];
    complainStatus = json['complainStatus'];
    updatedBy = json['updatedBy'] != null
        ? UpdatedBy.fromJson(json['updatedBy'])
        : null;
    assignedStaffName = json['assignedStaffName'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['date'] = date;
    data['remark'] = remark;
    data['complainStatus'] = complainStatus;
    if (updatedBy != null) {
      data['updatedBy'] = updatedBy!.toJson();
    }
    data['assignedStaffName'] = assignedStaffName;
    data['phone'] = phone;
    return data;
  }
}

class UpdatedBy {
  String? name;
  String? roleName;

  UpdatedBy({this.name, this.roleName});

  UpdatedBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['roleName'] = roleName;
    return data;
  }
}

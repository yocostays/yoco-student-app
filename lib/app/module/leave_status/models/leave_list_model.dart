class LeaveListModel {
  String? sId;
  String? ticketId;
  String? category;
  String? startDate;
  String? endDate;
  String? leaveType;
  int? days;
  String? hours;
  String? visitorName;
  int? visitorNumber;
  String? description;
  String? leaveStatus;
  String? approvalStatus;
  String? approvedDate;
  String? applyDate;

  LeaveListModel(
      {this.sId,
      this.ticketId,
      this.category,
      this.startDate,
      this.endDate,
      this.leaveType,
      this.days,
      this.hours,
      this.visitorName,
      this.visitorNumber,
      this.description,
      this.leaveStatus,
      this.approvalStatus,
      this.approvedDate,
      this.applyDate});

  LeaveListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    category = json['category'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    leaveType = json['leaveType'];
    days = json['days'];
    hours = json['hours'];
    visitorName = json['visitorName'];
    visitorNumber = json['visitorNumber'];
    description = json['description'];
    leaveStatus = json['leaveStatus'];
    approvalStatus = json['approvalStatus'];
    approvedDate = json['approvedDate'];
    applyDate = json['applyDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['ticketId'] = ticketId;
    data['category'] = category;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['leaveType'] = leaveType;
    data['days'] = days;
    data['hours'] = hours;
    data['visitorName'] = visitorName;
    data['visitorNumber'] = visitorNumber;
    data['description'] = description;
    data['leaveStatus'] = leaveStatus;
    data['approvalStatus'] = approvalStatus;
    data['approvedDate'] = approvedDate;
    data['applyDate'] = applyDate;
    return data;
  }
}

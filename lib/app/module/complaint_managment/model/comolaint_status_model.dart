class ComplaintedListModel {
  String? sId;
  String? ticketId;
  String? userId;
  String? complainStatus;
  String? description;
  String? category;
  String? subCategory;
  String? resolvedDate;
  String? createdAt;

  ComplaintedListModel(
      {this.sId,
      this.ticketId,
      this.userId,
      this.complainStatus,
      this.description,
      this.category,
      this.subCategory,
      this.resolvedDate,
      this.createdAt});

  ComplaintedListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    ticketId = json['ticketId'];
    userId = json['userId'];
    complainStatus = json['complainStatus'];
    description = json['description'];
    category = json['category'];
    subCategory = json['subCategory'];
    resolvedDate = json['resolvedDate'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['ticketId'] = ticketId;
    data['userId'] = userId;
    data['complainStatus'] = complainStatus;
    data['description'] = description;
    data['category'] = category;
    data['subCategory'] = subCategory;
    data['resolvedDate'] = resolvedDate;
    data['createdAt'] = createdAt;
    return data;
  }
}

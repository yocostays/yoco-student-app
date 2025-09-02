class ComplaintDataModel {
  String? sId;
  String? name;
  String? image;

  ComplaintDataModel({this.sId, this.name, this.image});

  ComplaintDataModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

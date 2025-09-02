class ComplainSupType {
  String? sId;
  String? categoryId;
  String? name;

  ComplainSupType({this.sId, this.categoryId, this.name});

  ComplainSupType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryId'] = categoryId;
    data['name'] = name;
    return data;
  }
}

class AddVechicleDetails {
  String? id;
  String? vechicleType;
  String? engineType;
  String? vechicleNumber;
  String? modelName;

  AddVechicleDetails(
      {this.id,
      this.vechicleType,
      this.engineType,
      this.vechicleNumber,
      this.modelName});

  AddVechicleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vechicleType = json['vechicleType'];
    engineType = json['engineType'];
    vechicleNumber = json['vechicleNumber'];
    modelName = json['modelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vechicleType'] = vechicleType;
    data['engineType'] = engineType;
    data['vechicleNumber'] = vechicleNumber;
    data['modelName'] = modelName;
    return data;
  }
}

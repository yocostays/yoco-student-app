class ProfileData {
  String? sId;
  String? name;
  String? uniqueId;
  String? email;
  int? phone;
  String? image;
  String? bloodGroup;
  String? dob;
  String? fatherName;
  int? fatherNumber;
  String? motherName;
  int? motherNumber;
  String? fatherEmail;
  String? motherEmail;
  bool? isVechicleDetailsAdded;
  List<VechicleDetails>? vechicleDetails;
  List<RoomMatesData>? roomMatesData;
  KycDocuments? documents;
  List<IndisciplinaryActions>? indisciplinaryActions;

  ProfileData(
      {this.sId,
      this.name,
      this.uniqueId,
      this.email,
      this.phone,
      this.image,
      this.bloodGroup,
      this.dob,
      this.fatherName,
      this.fatherNumber,
      this.motherName,
      this.motherNumber,
      this.fatherEmail,
      this.motherEmail,
      this.isVechicleDetailsAdded,
      this.vechicleDetails,
      this.roomMatesData,
      this.documents,
      this.indisciplinaryActions});

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    uniqueId = json['uniqueId'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    bloodGroup = json['bloodGroup'];
    dob = json['dob'];
    fatherName = json['fatherName'];
    fatherNumber = json['fatherNumber'];
    motherName = json['motherName'];
    motherNumber = json['motherNumber'];
    fatherEmail = json['fatherEmail'];
    motherEmail = json['motherEmail'];
    isVechicleDetailsAdded = json['isVechicleDetailsAdded'];
    if (json['vechicleDetails'] != null) {
      vechicleDetails = <VechicleDetails>[];
      json['vechicleDetails'].forEach((v) {
        vechicleDetails!.add(VechicleDetails.fromJson(v));
      });
    }
    documents = json['documents'] != null
        ? KycDocuments.fromJson(json['documents'])
        : null;
    if (json['roomMatesData'] != null) {
      roomMatesData = <RoomMatesData>[];
      json['roomMatesData'].forEach((v) {
        roomMatesData!.add(RoomMatesData.fromJson(v));
      });
    }
    if (json['indisciplinaryActions'] != null) {
      indisciplinaryActions = <IndisciplinaryActions>[];
      json['indisciplinaryActions'].forEach((v) {
        indisciplinaryActions!.add(IndisciplinaryActions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['uniqueId'] = uniqueId;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['bloodGroup'] = bloodGroup;
    data['dob'] = dob;
    data['fatherName'] = fatherName;
    data['fatherNumber'] = fatherNumber;
    data['motherName'] = motherName;
    data['motherNumber'] = motherNumber;
    data['fatherEmail'] = fatherEmail;
    data['motherEmail'] = motherEmail;
    data['isVechicleDetailsAdded'] = isVechicleDetailsAdded;
    if (vechicleDetails != null) {
      data['vechicleDetails'] =
          vechicleDetails!.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      data['documents'] = documents!.toJson();
    }
    if (roomMatesData != null) {
      data['roomMatesData'] = roomMatesData!.map((v) => v.toJson()).toList();
    }
    if (indisciplinaryActions != null) {
      data['indisciplinaryActions'] =
          indisciplinaryActions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VechicleDetails {
  String? vechicleType;
  String? engineType;
  String? vechicleNumber;
  String? modelName;
  String? sId;

  VechicleDetails(
      {this.vechicleType,
      this.engineType,
      this.vechicleNumber,
      this.modelName,
      this.sId});

  VechicleDetails.fromJson(Map<String, dynamic> json) {
    vechicleType = json['vechicleType'];
    engineType = json['engineType'];
    vechicleNumber = json['vechicleNumber'];
    modelName = json['modelName'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vechicleType'] = vechicleType;
    data['engineType'] = engineType;
    data['vechicleNumber'] = vechicleNumber;
    data['modelName'] = modelName;
    data['_id'] = sId;
    return data;
  }
}

class RoomMatesData {
  String? sId;
  String? name;
  String? email;
  int? phone;
  String? image;
  String? roomDetails;

  RoomMatesData(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.roomDetails});

  RoomMatesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    roomDetails = json['roomDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['roomDetails'] = roomDetails;
    return data;
  }
}

class KycDocuments {
  String? aadhaarCard;
  String? passport;
  String? voterCard;
  String? drivingLicense;
  String? panCard;

  KycDocuments(
      {this.aadhaarCard,
      this.passport,
      this.voterCard,
      this.drivingLicense,
      this.panCard});

  KycDocuments.fromJson(Map<String, dynamic> json) {
    aadhaarCard = json['aadhaarCard'];
    passport = json['passport'];
    voterCard = json['voterCard'];
    drivingLicense = json['drivingLicense'];
    panCard = json['panCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aadhaarCard'] = aadhaarCard;
    data['passport'] = passport;
    data['voterCard'] = voterCard;
    data['drivingLicense'] = drivingLicense;
    data['panCard'] = panCard;
    return data;
  }
}

class IndisciplinaryActions {
  String? sId;
  String? staffId;
  String? remark;
  bool? isFine;
  int? fineAmount;
  String? createdAt;

  IndisciplinaryActions(
      {this.sId,
      this.staffId,
      this.remark,
      this.isFine,
      this.fineAmount,
      this.createdAt});

  IndisciplinaryActions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    staffId = json['staffId'];
    remark = json['remark'];
    isFine = json['isFine'];
    fineAmount = json['fineAmount'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['staffId'] = staffId;
    data['remark'] = remark;
    data['isFine'] = isFine;
    data['fineAmount'] = fineAmount;
    data['createdAt'] = createdAt;
    return data;
  }
}

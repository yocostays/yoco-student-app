// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:yoco_stay_student/app/Storage/get_storage.dart';
import 'package:yoco_stay_student/app/core/network/apiconstant.dart';
import 'package:yoco_stay_student/app/core/network/base_service.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/login_signup.dart';
import 'package:yoco_stay_student/app/module/profile/models/hostail_Model.dart';
import 'package:yoco_stay_student/app/module/profile/models/profile_model.dart';
import 'package:yoco_stay_student/app/module/profile/models/response/hostail_response.dart';
import 'package:yoco_stay_student/app/module/profile/models/response/profile_response.dart';
import 'package:yoco_stay_student/app/module/profile/models/vehicle_add_class.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class ProfileController extends GetxController {
  SharedPreferences? prefs;
  final TextEditingController EmailName = TextEditingController();
  final TextEditingController bloddgroup = TextEditingController();
  Rx<ProfileData> profileDatas = Rx<ProfileData>(ProfileData());
  Rx<GetVihicledata> Vehocledatalist = Rx<GetVihicledata>(GetVihicledata());
  Rx<HostelDetailData> hostelDetailsDatas =
      Rx<HostelDetailData>(HostelDetailData());
  var Emailvalue = "harshjogi@gmail.com".obs;

  final CacheManager cacheManager = CacheManager(Config('images_Key',
      maxNrOfCacheObjects: 20, stalePeriod: const Duration(days: 3)));

  RxBool hostaldetailson = false.obs;

  // <---------------------  Logout api ------------------------------
  LogOut() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().Logout, isTokenRequired: true, body: {});
      if (response.data['statusCode'] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      await TokenStorage.removeToken();
      await TokenStorage.removeusername();
      await TokenStorage.removeuserid();
      Get.offAll(const LoginSignUp());
    }
  }

  // <--------------------------- Update Email and photos --------------------------
  RxBool imageupload = false.obs;
  EmailPhotoUpdate(String Image) async {
    prefs = await SharedPreferences.getInstance();

    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().EmailPhotosUpdate,
          isTokenRequired: true,
          body: {"email": EmailName.text, "image": Image});

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
        GetProfileData();
        Get.back();
      }
    } on DioException catch (e) {
      // print(e.response);
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
    } finally {
      Utils.showToast(
        message: "We Got Some Error In Register User.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
    }
  }

  PhotoUpdate(File? Image, String? Email) async {
    imageupload(true);
    prefs = await SharedPreferences.getInstance();
    String? base64Image;

    if (Image != null) {
      List<int> imageBytes = await Image.readAsBytes(); // Read image as bytes
      base64Image =
          "data:image/jpg;base64,${base64Encode(imageBytes)}"; // Encode image to base64
    }
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().EmailPhotosUpdate,
          isTokenRequired: true,
          body: {"email": Email, "image": base64Image});

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
        await cacheManager.removeFile('images_Key');
        UserImage.value = "assets/images/9440456 1.png";

        // Update the profile data with the new image URL

        Profiledetaildataupdate();
        imageupload(false);
      }
    } on DioException catch (e) {
      // print(e.response);
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      imageupload(false);
    }
  }

  // <--------------------------- Get Profile set token ---------------------------------
  RxBool profileLoading = false.obs;
  void GetProfileData() async {
    print("hello : GetProfileData");
    profileLoading(true);
    try {
      var Getprofiledata = await GetProfileResponse();
      if (Getprofiledata.data != null) {
        profileDatas.value = Getprofiledata.data!;
        // Vehocledatalist.value = Getprofiledata.data!.vechicleDetails;
        // Getprofiledata.data!.vechicleDetails!.length == 0
        //     ? 0
        //     : Getprofiledata.data!.vechicleDetails!.map(
        //         (e) => VehicleDetailsdata.add(AddVechicleDetails(
        //           vechicleType: e.vechicleType,
        //           engineType: e.engineType,
        //           vechicleNumber: e.vechicleNumber,
        //           modelName: e.modelName,
        //         )),
        //       );

        if (Getprofiledata.data!.vechicleDetails!.isEmpty) {
          print("No vehicle details available");
        } else {
          for (var e in Getprofiledata.data!.vechicleDetails!) {
            VehicleDetailsdata.add(AddVechicleDetails(
                vechicleType: e.vechicleType,
                engineType: e.engineType,
                vechicleNumber: e.vechicleNumber,
                modelName: e.modelName,
                id: e.sId));
          }
        }

        print(
            "hellon data section ${VehicleDetailsdata.length}  ${Getprofiledata.data!.vechicleDetails!.length}");
        //VehicleDetailsdata = Getprofiledata.data.vechicleDetails;

        profileDatas.value.image == null
            ? imagenothave(true)
            : imagenothave(false);
        UserImage.value =
            profileDatas.value.image ?? "assets/images/9440456 1.png";

        // Get.toNamed(AppRoute.profiledtail);
      }
      profileLoading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      profileLoading(false);
    } finally {
      // isDraftJobListLoading.value = false;
      profileLoading(false);
    }
  }

  Future<ProfileResponse> GetProfileResponse() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetProfile,
        isTokenRequired: true,
        body: {},
      );
      UserImage.value = profileDatas.value.image ?? "";
      return ProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return ProfileResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <--------------------------- Get Profile data ---------------------------------
  RxBool profiledetailLoading = false.obs;
  RxString UserImage = "".obs;
  RxBool imagenothave = false.obs;
  void Profiledetaildata() async {
    print("hello : Profiledetaildata");
    profiledetailLoading(true);
    try {
      var Getprofiledata = await ProfiledetaildataResponse();
      if (Getprofiledata.data != null) {
        profileDatas.value = Getprofiledata.data!;
        await TokenStorage.removeuserimage();
        await TokenStorage.saveUserimage(profileDatas.value.image ?? "");
        await cacheManager.removeFile('images_Key');

        UserImage.value =
            profileDatas.value.image ?? "assets/images/9440456 1.png";
        // Get.toNamed(AppRoute.profiledtail);
      }
      profiledetailLoading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      profiledetailLoading(false);
    } finally {
      // isDraftJobListLoading.value = false;
      profiledetailLoading(false);
    }
  }

  void Profiledetaildataupdate() async {
    print("hello : Profiledetaildata");
    profiledetailLoading(true);
    try {
      var Getprofiledata = await ProfiledetaildataResponse();
      if (Getprofiledata.data != null) {
        profileDatas.value = Getprofiledata.data!;
        await TokenStorage.removeuserimage();
        await TokenStorage.saveUserimage(profileDatas.value.image ?? "");
        profileDatas.value.image == null
            ? imagenothave(true)
            : imagenothave(false);

        imageCache.clear();
        imageCache.clearLiveImages();
        UserImage.value =
            profileDatas.value.image ?? "assets/images/9440456 1.png";
        await cacheManager.removeFile('images_Key');

        // Get.toNamed(AppRoute.profiledtail);
      }
      profiledetailLoading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      profiledetailLoading(false);
    } finally {
      // isDraftJobListLoading.value = false;
      profiledetailLoading(false);
    }
  }

  Future<ProfileResponse> ProfiledetaildataResponse() async {
    print("hello : ProfiledetaildataResponse");
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetProfile,
        isTokenRequired: true,
        body: {},
      );
      return ProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("hello einr");
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return ProfileResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <--------------------------- Get Hostel detail data ---------------------------------
  void GetHostelData() async {
    // isDraftJobListLoading.value = true;
    try {
      var Getprofiledata = await GetHostelResponse();
      if (Getprofiledata.data != null) {
        hostelDetailsDatas.value = Getprofiledata.data!;

        // Get.toNamed(AppRoute.profiledtail);
      }
    } catch (e) {
      print("Error fetching draft jobs: $e");
    } finally {
      // isDraftJobListLoading.value = false;
    }
  }

  Future<HostelDetailResponse> GetHostelResponse() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetHostelData,
        isTokenRequired: true,
        body: {},
      );
      return HostelDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print(
          "API Error: ${e.response?.data["statusCode"]} - ${e.response?.data}");

      return HostelDetailResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <============================ Vehicle upload Section ===========================
  final TextEditingController vechicleType = TextEditingController();
  final TextEditingController engineType = TextEditingController();
  final TextEditingController vechicleNumber = TextEditingController();
  final TextEditingController modelName = TextEditingController();
  List<AddVechicleDetails> VehicleDetailsdata = [];
  RxBool VehicleLoading = false.obs;

  VehicleUpload(bool alredyupladed) async {
    VehicleLoading(true);
    prefs = await SharedPreferences.getInstance();
    try {
      var body = {
        "vechicleDetails": VehicleDetailsdata.map((vehicle) {
          return {
            "vechicleType": vehicle.vechicleType,
            "engineType": vehicle.engineType,
            "vechicleNumber": vehicle.vechicleNumber,
            "modelName": vehicle.modelName,
            "id": vehicle.id
          };
        }).toList(),
      };
      var response = await BaseService().patchData(
          endPoint: ApiRoutes().VehicleUpload,
          isTokenRequired: true,
          body: body);

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
        vechicleType.clear();
        engineType.clear();
        vechicleNumber.clear();
        modelName.clear();
        VehicleDetailsdata = [];
        VehicleLoading(false);
      }
      GetProfileData();
      alredyupladed == false ? Get.back() : 0;
      Get.back();
      VehicleLoading(false);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      // print(e.response);
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      VehicleLoading(false);
    } finally {
      VehicleLoading(false);
    }
  }

  // <--------------------------- Get Kyc Doument data ---------------------------------
  RxBool KYCDocLoading = false.obs;
  RxBool KYCDocUploadLoading = false.obs;
  // KycDocuments? kycDocuments;
  void GetKycDocData() async {
    KYCDocLoading(true);
    try {
      var Getprofiledata = await GetKycDocResponse();
      if (Getprofiledata.data != null) {
        profileDatas.value = Getprofiledata.data!;
        // kycDocuments = profileDatas.value.documents.aadhaarCard;
        // print("kyc doc : ${kycDocuments!.aadhaarCard}");
      }
      KYCDocLoading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      KYCDocLoading(false);
    } finally {
      // isDraftJobListLoading.value = false;
      KYCDocLoading(false);
    }
  }

  Future<ProfileResponse> GetKycDocResponse() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetProfile,
        isTokenRequired: true,
        body: {},
      );
      return ProfileResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return ProfileResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  KycDocumentUpdate(File? Image, String type, bool? delete) async {
    prefs = await SharedPreferences.getInstance();
    KYCDocUploadLoading(true);
    try {
      var response;
      delete == true
          ? response = await BaseService().KycDocumentpostMultiPartData(
              endPoint: ApiRoutes().KycDocumentUpload,
              isTokenRequired: true,
              body: {},
              datatype: type,
            )
          : response = await BaseService().KycDocumentpostMultiPartData(
              endPoint: ApiRoutes().KycDocumentUpload,
              isTokenRequired: true,
              body: {},
              file: Image,
              datatype: type,
            );
      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
      }
      GetKycDocData();
      delete == true ? Get.back() : 0;
      Get.back();
      KYCDocUploadLoading(false);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      // print(e.response);
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      KYCDocUploadLoading(false);
    }
  }

  //<================================ vehicle delete api =================================
  RxBool vehicledeleteloading = false.obs;
  VehicleDeteleapicall(String id) async {
    prefs = await SharedPreferences.getInstance();
    vehicledeleteloading(true);
    try {
      var response;
      response = await BaseService().deleteData(
        endPoint: "${ApiRoutes().VehicleDelete}/$id",
        isTokenRequired: true,
        body: {},
      );
      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
      }

      Get.back();
      vehicledeleteloading(false);
    } on DioException catch (e) {
      print(e.response);

      vehicledeleteloading(false);
    }
  }

  // data models
  List<Detail> detailsList = [
    Detail(name: "Hostel Details", url: AppRoute.hostalDetail),
    Detail(name: "Family / Personal Details", url: AppRoute.femilyDetail),
    Detail(name: "Upload KYC Documents", url: AppRoute.Documentpage),
    Detail(
        name: "Report of Indisciplinary Actions",
        url: AppRoute.profileindisciplinary),
    Detail(name: "Vehicle Details", url: AppRoute.vihcledetail),
    // Detail(name: "Inventory Assigned", url: AppRoute.profileinventory),
  ];

  List<VehicleDetail> ProfilevehicleList = [
    VehicleDetail(
      image: 'assets/images/bike.png',
      name: 'Bicycle',
      value: 'bycycle',
    ),
    VehicleDetail(
      image: 'assets/images/ev_slot_image/car.png',
      name: 'Car',
      value: 'four wheeler',
    ),
    VehicleDetail(
      image: 'assets/images/ev_slot_image/profileScooter.png',
      name: 'Bike',
      value: 'bike',
    ),
  ];

  String getVehicleName(String vehicleTypeValue) {
    final vehicle = ProfilevehicleList.firstWhere(
      (vehicleDetail) => vehicleDetail.value == vehicleTypeValue,
    );
    return vehicle.name; // Return 'Unknown Vehicle' if not found
  }
}

class Detail {
  String name;
  dynamic url;

  Detail({required this.name, required this.url});

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class VehicleDetail {
  String image;
  String name;
  String value;

  VehicleDetail({
    required this.image,
    required this.name,
    required this.value,
  });
}

class GetVihicledata {
  String? vechicleType;
  String? engineType;
  String? vechicleNumber;
  String? modelName;
  String? id;

  GetVihicledata({
    this.vechicleType,
    this.engineType,
    this.vechicleNumber,
    this.modelName,
    this.id,
  });

  // Factory constructor to create an instance from JSON
  factory GetVihicledata.fromJson(Map<String, dynamic> json) {
    return GetVihicledata(
      vechicleType: json['vechicleType'] as String,
      engineType: json['engineType'] as String,
      vechicleNumber: json['vechicleNumber'] as String,
      modelName: json['modelName'] as String,
      id: json['_id'] as String?,
    );
  }
}

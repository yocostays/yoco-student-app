import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoco_stay_student/app/Storage/get_storage.dart';
import 'package:yoco_stay_student/app/core/network/apiconstant.dart';
import 'package:yoco_stay_student/app/core/network/base_service.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/comalain_sub_type_model.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/comolaint_status_model.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/complaint_data_model.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/response/compalint_sub_type_response.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/response/complaint_response.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/response/complaint_status_response.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/response/single_complaint_status_response.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/model/single_complaint_status_Model.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/login_signup.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class CompliantController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    GetComplaintdatacheck();
  }

  void GetComplaintdatacheck() {
    if (Complaindatalist.isNotEmpty) {
      return; // Skip loading if data already exists
    }
    // Load data
  }

  SharedPreferences? prefs;
  // variables
  // Define the cache manager with custom settings
  final CacheManager cacheManager = CacheManager(
    Config(
      'customCacheKey', // You can give it a custom key
      stalePeriod: const Duration(days: 7), // Set stale period
      maxNrOfCacheObjects: 100, // Maximum number of cache objects
    ),
  );

  RxString SlectedComplaint = "".obs;
  RxList<ComplaintDataModel> Complainttypedata = RxList<ComplaintDataModel>();

  List<ComplaintDataModel> Complaindatalist = [];

  // <---------------------------- this Function is call for get Complaint data List from backend
  RxBool Complaintdataload = false.obs;
  Future<void> GetComplaintTypeList() async {
    Complaintdataload(true);
    try {
      var ComplainTypeList = await ComplainlistType();
      if (ComplainTypeList.data != null) {
        Complaindatalist = [];
        Complaindatalist.assignAll(ComplainTypeList.data!);
        Complainttypedata.assignAll(ComplainTypeList.data!);
        Complaintdataload(false);
      }
      Complaintdataload(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      Complaintdataload(false);
    } finally {
      Complaintdataload(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<ComplainModelResponse> ComplainlistType() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().ComplainType,
        isTokenRequired: true,
        body: {},
      );
      return ComplainModelResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return ComplainModelResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <---------------------------- this Function is call for get Complaint sub type list from backend
  RxList<ComplainSupType> Complaintsubtypedata = RxList<ComplainSupType>();
  RxBool ComplaintsListdataload = false.obs;
  void GetComplaintList(String id) async {
    Complaintdataload(true);
    try {
      var ComplainSubList = await Complainlistsubtype(id);
      if (ComplainSubList.data != null) {
        Complaintsubtypedata.assignAll(ComplainSubList.data!);
      }
      ComplaintsListdataload(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      ComplaintsListdataload(false);
    } finally {
      ComplaintsListdataload(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<ComplainTypeListResponse> Complainlistsubtype(String id) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().ComplainSubTypeData,
        isTokenRequired: true,
        body: {
          "categoryId": id,
        },
      );
      return ComplainTypeListResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      return ComplainTypeListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //< ============================ Complaint Mangment section  data ================================
  RxBool ComplainLoading = false.obs;
  bool isRecording = false, isPlaying = false;
  RxString Complaitnid = "".obs;
  String? recordingPath;
  TextEditingController Description = TextEditingController();
  // TextEditingController recordingPath = TextEditingController();
  RxBool recordingStatus = false.obs;
  TextEditingController SelectedComplaintid = TextEditingController();
  RxInt Textlength = 0.obs;
  var imageFileList = <XFile>[].obs;
  // XFile? imageFileList;
  String? mp3fileUrl;
  String? ImageUpload;

  CreateComplaint() async {
    if (SelectedComplaintid.text.isNotEmpty && Description.text.isNotEmpty) {
      ComplainLoading(true);
      prefs = await SharedPreferences.getInstance();
      if (recordingStatus.isTrue) {
        try {
          ComplainLoading(true);
          var response = await BaseService().postMultiPartData(
              endPoint: ApiRoutes().MediaUpload,
              isTokenRequired: true,
              body: {},
              aodiofiles: recordingPath,
              aoudio: true);
          Utils.showToast(
            message: "${response.data["message"]}",
            gravity: ToastGravity.CENTER,
            textColor: Colors.white,
            fontsize: 16,
          );
          print("Response data : $response");
          mp3fileUrl = response.data['data'];
        } on DioException catch (e) {
          print(e.response);
          print("API Error: ${e.message} - ${e.response?.data}");
          Utils.showToast(
            message: "${e.message}",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            fontsize: 16,
          );
        }
      }

      if (imageFileList.isNotEmpty) {
        Map<String, File>? files = {};
        // String fileName = basename(imageFileList!.path);
        // File file = File(imageFileList!.path);
        // files[fileName] = file;
        for (int i = 0; i < 1; i++) {
          XFile xFile = imageFileList[i];
          File file = File(xFile.path);

          // You can use the file name or index as the key
          String fileName = basename(file.path);

          files[fileName] = file;
        }
        try {
          ComplainLoading(true);
          var response = await BaseService().postMultiPartData(
              endPoint: ApiRoutes().MediaUpload,
              isTokenRequired: true,
              body: {},
              files: files,
              aoudio: false);

          ImageUpload = response.data['data'];
        } on DioException catch (e) {
          print(e.response);
          print("API Error: ${e.message} - ${e.response?.data}");
          Utils.showToast(
            message: "${e.message}",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.white,
            fontsize: 16,
          );
        }
      }

      try {
        var response = await BaseService().postData(
          endPoint: ApiRoutes().CreateComplaint,
          isTokenRequired: true,
          body: {
            "categoryId": Complaitnid.value,
            "subCategoryId": SelectedComplaintid.text,
            "description": Description.text,
            "image": ImageUpload,
            "audio": mp3fileUrl
          },
        );
        SelectedComplaintid.clear();
        Description.clear();
        ImageUpload = "";
        mp3fileUrl = "";
        imageFileList.clear();
        recordingPath = "";
        recordingStatus(false);

        Utils.showToast(
          message: "${response.data["message"]}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
        ComplainLoading(false);

        if (response.data["statusCode"] == 200) {
          // Get.back();
          // Get.back();
          Get.offAllNamed(AppRoute.complainmanagment);
          await GetComplaintedListData("pending");
        }
      } on DioException catch (e) {
        if (e.response?.data["statusCode"] == 401) {
          await TokenStorage.removeToken();
          await TokenStorage.removeusername();
          await TokenStorage.removeuserid();
          Get.offAll(const LoginSignUp());
        }
        print(e.response);
        print("API Error: ${e.message} - ${e.response?.data}");
        ComplainLoading(false);
      }
    } else {
      Utils.showToast(
        message: "Complaint Option and Description Required",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
    }
  }

  // <---------------------------- this Function is call for get Complaint list from backend
  RxList<ComplaintedListModel> ComplaintStatusListdata =
      RxList<ComplaintedListModel>();

  List<ComplaintedListModel> Complaintdatalist = [];
  RxBool Complainteddataload = false.obs;
  Future GetComplaintedListData(String status) async {
    Complainteddataload(true);
    try {
      var ComplaintedList = await ComplaintedListResponseData(status);
      if (ComplaintedList.data != null) {
        ComplaintStatusListdata.assignAll(ComplaintedList.data!);
        Complaintdatalist = [];
        Complaintdatalist.assignAll(ComplaintedList.data!);
      }
      Complainteddataload(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      Complainteddataload(false);
    } finally {
      Complainteddataload(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<ComplaintedListResponse> ComplaintedListResponseData(
      String Status) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetComplaintedList,
        isTokenRequired: true,
        body: {"status": Status},
      );
      return ComplaintedListResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data["statusCode"]}");
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      return ComplaintedListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <---------------------------- this Function is call for get Complaint Status list from backend
  RxList<SingleComplaintStatusModel> ComplaintStatusdata =
      RxList<SingleComplaintStatusModel>();
  RxBool ComplaintStatusload = false.obs;
  Future GetComplaintedStatusData(String id) async {
    print("status called ");
    Complainteddataload(true);
    try {
      var ComplaintedStatus = await ComplaintedstatusResponse(id);
      if (ComplaintedStatus.data != null) {
        ComplaintStatusdata.assignAll(ComplaintedStatus.data!);
      }
      Complainteddataload(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      Complainteddataload(false);
    } finally {
      Complainteddataload(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<ComplaintStatusResponse> ComplaintedstatusResponse(String id) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetComplaintedStatus,
        isTokenRequired: true,
        body: {"compaintId": id},
      );
      return ComplaintStatusResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return ComplaintStatusResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //< ============================ Complaint Mangment section  data ================================
  RxBool RemoveComplainLoading = false.obs;

  RemoveComplaint(String id, String Status) async {
    RemoveComplainLoading(true);
    prefs = await SharedPreferences.getInstance();

    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().RemoveComplaint,
        isTokenRequired: true,
        body: {"compaintId": id},
      );

      GetComplaintedListData(Status);
      Utils.showToast(
        message: "${response.data["message"]}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      RemoveComplainLoading(false);
      Get.back();
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");
      RemoveComplainLoading(false);
    }
  }
}

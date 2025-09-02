import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoco_stay_student/app/Storage/get_storage.dart';

import 'package:yoco_stay_student/app/module/home/view.dart';
import 'package:yoco_stay_student/app/module/onboarding/model/hostal_model.dart';
import 'package:yoco_stay_student/app/module/onboarding/model/response/hostel_list_response.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/admin_veryfication_page.dart';
import 'package:yoco_stay_student/app/core/network/apiconstant.dart';
import 'package:yoco_stay_student/app/core/network/base_service.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/login_signup.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/set_new_password.dart';
import 'package:yoco_stay_student/app/module/profile/models/profile_model.dart';
import 'package:yoco_stay_student/app/module/profile/models/response/profile_response.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io';

class AuthController extends GetxController {
  SharedPreferences? prefs;

  RxList<HostelListModel> hosteldata = RxList<HostelListModel>();
  late TabController tabController;

  // Login variable
  TextEditingController UserId = TextEditingController();
  TextEditingController Password = TextEditingController();
  RxBool rememberme = false.obs;
  RxBool LoginLoader = false.obs;
  RxBool Showpassword = true.obs;

  // registration Variable
  List<HostelListModel> hostelList = [];
  TextEditingController StudentName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController EnrollmentNumber = TextEditingController();
  TextEditingController DOB = TextEditingController();
  DateTime? Dob;
  TextEditingController MobileNumber = TextEditingController();
  TextEditingController FatherName = TextEditingController();
  TextEditingController FatherMobile = TextEditingController();
  TextEditingController FatherEmail = TextEditingController();
  TextEditingController MotherName = TextEditingController();
  TextEditingController MotherMobile = TextEditingController();
  TextEditingController MotherEmail = TextEditingController();
  TextEditingController Aadharpassport = TextEditingController();
  TextEditingController BloodGroup = TextEditingController();
  TextEditingController CourseName = TextEditingController();
  TextEditingController Acadmicyear = TextEditingController();
  TextEditingController Semester = TextEditingController();
  TextEditingController GuardianNumber = TextEditingController();
  TextEditingController Category = TextEditingController();
  TextEditingController Hotelperfrence = TextEditingController();
  TextEditingController permanentAddress = TextEditingController();
  RxBool RegisterLoader = false.obs;

  // <---------------------------- This function for Token Checking to app
  Rx<ProfileData> profileDatas = Rx<ProfileData>(ProfileData());
  final CacheManager cacheManager = CacheManager(Config('images_Key',
      maxNrOfCacheObjects: 20, stalePeriod: const Duration(days: 3)));
  RxBool Registerbuttonshow = false.obs;
  TokenValiditycheck() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().Tokencheck,
        isTokenRequired: true,
        body: {},
      );
      if (response.data['statusCode'] == 200) {
        Profiledetaildata();
        Registerbuttonshow(false);
        Get.to(const DashboardPage());
      } else if (TokenStorage.getLoged() == "Loged") {
        Get.to(const LoginSignUp());
      } else {
        Registerbuttonshow(true);
      }
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");
      if (TokenStorage.getLoged() == "Loged") {
        Get.to(const LoginSignUp());
      }

      Registerbuttonshow(true);
      await TokenStorage.removeToken();
      await TokenStorage.removeusername();
      await TokenStorage.removeuserid();
      print("Remove token");
    }
  }

  void Profiledetaildata() async {
    final ByteData bytes;
    final Uint8List imageData;
    try {
      var Getprofiledata = await ProfiledetaildataResponse();
      if (Getprofiledata.data != null) {
        profileDatas.value = Getprofiledata.data!;
        imageCache.clear();
        imageCache.clearLiveImages();
        Getprofiledata.data!.image == null
            ? {
                await cacheManager.removeFile('images_Key'),
                bytes = await rootBundle.load("assets/images/9440456 1.png"),
                imageData = bytes.buffer.asUint8List(),

                // Add the image data to the cache with the specified key
                await cacheManager.putFile(
                  'images_Key',
                  imageData,
                  fileExtension: 'png', // Specify the file extension if needed
                )
              }
            : {
                await cacheManager.removeFile('images_Key'),
                await cacheManager.downloadFile(
                  Getprofiledata.data!.image ?? "",
                  key: 'images_Key',
                )
              };
      }
    } catch (e) {
      print("Error fetching draft jobs: $e");
    } finally {
      // isDraftJobListLoading.value = false;
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

  // <---------------------------- This Function is use for User Login  and Store Auth Token, user name, user Id
  Loginauth() async {
    LoginLoader(true);
    prefs = await SharedPreferences.getInstance();
    if (rememberme.value == true) {
      await TokenStorage.saveLoginid(UserId.text);
      await TokenStorage.savePassword(Password.text);
    }

    try {
      var response = await BaseService()
          .postData(endPoint: ApiRoutes().Login, isTokenRequired: false, body: {
        "uniqueId": UserId.text,
        "password": Password.text,
        "rememberMe": rememberme.value,
        "loginType": Platform.isAndroid ? "android" : "ios",
        "subscriptionId": OneSignal.User.pushSubscription.id
      });
      if (response.data['statusCode'] == 200) {
        await TokenStorage.saveToken(response.data['auth']);
        await TokenStorage.saveUsername(response.data['data']['name']);
        await TokenStorage.saveUserId(response.data['data']['_id']);
        await TokenStorage.saveHostelname(response.data['data']['hostel']);
        await TokenStorage.saveloged("Loged");

        UserId.clear();
        Password.clear();
        rememberme(false);
        imageCache.clear();
        imageCache.clearLiveImages();
        Get.to(const DashboardPage());
        LoginLoader(false);
      }
    } on DioException catch (e) {
      Utils.showToast(
        message: "${e.response!.data['message']}",
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontsize: 16,
      );

      LoginLoader(false);
    }
  }

  // <---------------------------- This Function is use for Forget password opt send
  RxBool forgetpassLoader = false.obs;
  ForgetPasswordOtp() async {
    forgetpassLoader(true);
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().Forgetpassword,
          isTokenRequired: false,
          body: {
            "uniqueId": UserId.text,
          });
      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "OTP : ${response.data['data']['otp']}",
          gravity: ToastGravity.CENTER,
          toastlength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          fontsize: 16,
        );
        Get.to(() => const SetNewPasswordPage());
        forgetpassLoader(false);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "UserId or Password is Worng.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      forgetpassLoader(false);
    }
  }

  ResendOtp() async {
    forgetpassLoader(true);
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().Forgetpassword,
          isTokenRequired: false,
          body: {
            "uniqueId": UserId.text,
          });
      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "OTP : ${response.data['data']['otp']}",
          gravity: ToastGravity.CENTER,
          toastlength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          fontsize: 16,
        );
        forgetpassLoader(false);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "UserId or Password is Worng.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      forgetpassLoader(false);
    }
  }

  //<============================= this function will set new Password ========================
  TextEditingController Otp = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController Confirmpassword = TextEditingController();

  RxBool setnewPasswordLoader = false.obs;
  NewPasswordSet() async {
    if (newpassword.text != Confirmpassword.text) {
      Utils.showToast(
        message: "Password Not Confirmed.",
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontsize: 16,
      );
      return null;
    }
    setnewPasswordLoader(true);
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().SendNewPassword,
          isTokenRequired: false,
          body: {
            "uniqueId": UserId.text,
            "otp": int.parse(Otp.text),
            "password": newpassword.text
          });
      if (response.data['statusCode'] == 200) {
        Otp.clear();
        newpassword.clear();
        Confirmpassword.clear();
        Utils.showToast(
          message: "Password Reset",
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          fontsize: 16,
        );
        Get.to(const LoginSignUp());
        setnewPasswordLoader(false);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "UserId or Password is Worng.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      setnewPasswordLoader(false);
    }
  }

  // <---------------------------- this Function is call for get Hostel Data from api there are two function
  void GetHostalList() async {
    // isDraftJobListLoading.value = true;
    try {
      var HostelList = await GetHostelid();
      if (HostelList.data != null) {
        hosteldata.assignAll(HostelList.data!);
      }
    } catch (e) {
      print("Error fetching draft jobs: $e");
    } finally {
      // isDraftJobListLoading.value = false;
    }
  }

  Future<HostelListResponse> GetHostelid() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().hostel,
        isTokenRequired: false,
        body: {},
      );
      return HostelListResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return HostelListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <----------  This function is for Register user in app this is a post function with Getx achitecture
  UserRegistration() async {
    RegisterLoader(true);

    var Data = {
      "name": StudentName.text,
      "email": Email.text,
      "enrollmentNumber": EnrollmentNumber.text,
      "dob": "$Dob",
      "phone": int.parse(MobileNumber.text),
      "fatherName": FatherName.text,
      "fatherNumber": FatherMobile.text,
      "fatherEmail": FatherEmail.text,
      "motherName": MotherName.text,
      "motherNumber": int.parse(MotherMobile.text),
      "motherEmail": MotherEmail.text,
      "adharNumber": Aadharpassport.text,
      "bloodGroup": BloodGroup.text,
      "courseName": CourseName.text,
      "academicYear": int.parse(Acadmicyear.text),
      "semester": Semester.text,
      "guardianContactNo": int.parse(GuardianNumber.text),
      "category": Category.text,
      "hostelId": Hotelperfrence.text,
      "address": permanentAddress.text,
      "loginType": Platform.isAndroid ? "android" : "ios",
      "subscriptionId": OneSignal.User.pushSubscription.id,
    };
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().UserRegistration,
          isTokenRequired: false,
          body: Data);
      clearAllRegisterFields();
      Utils.showToast(
        message: "${response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      RegisterLoader(false);
      Get.off(const AdminVerifyPage());
    } on DioException catch (e) {
      // print(e.response);
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );

      RegisterLoader(false);
    } finally {
      RegisterLoader(false);
    }
  }

  // <----------------- Clear Function for Register TextfieldControllers
  void clearAllRegisterFields() {
    StudentName.clear();
    Email.clear();
    EnrollmentNumber.clear();
    DOB.clear();
    MobileNumber.clear();
    FatherName.clear();
    FatherMobile.clear();
    MotherName.clear();
    MotherMobile.clear();
    Aadharpassport.clear();
    BloodGroup.clear();
    CourseName.clear();
    Acadmicyear.clear();
    GuardianNumber.clear();
    Category.clear();
    Hotelperfrence.clear();
    permanentAddress.clear();
    Semester.clear();
  }
}

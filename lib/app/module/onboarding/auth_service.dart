// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:yoco_stay_student/app/Storage/get_storage.dart';
// import 'package:yoco_stay_student/app/module/onboarding/model/hostal_model.dart';
// import 'package:yoco_stay_student/app/network/apiconstant.dart';
// import 'package:yoco_stay_student/app/network/intercepter.dart';

// // class AuthService {
// //   final Dio _dio = Dio();
// //   AuthService() {
// //     _dio.interceptors.add(ApiInterceptor());
// //   }

// //   auth(String userpass, String Password) async {
// //     try {
// //       final response = await _dio.post(
// //         ApiConstant.Login,
// //         data: {"uniqueId": userpass, "password": Password},
// //       );

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         // Successful response
// //         ApiInterceptor interceptor = _dio.interceptors
// //                 .firstWhere((interceptor) => interceptor is ApiInterceptor)
// //             as ApiInterceptor;
// //         dynamic result = interceptor.responseData;

// //         if (result["statusCode"] == 200) {
// //           await TokenStorage.saveToken(result["auth"]);
// //           await TokenStorage.saveUsername(result["data"]["name"]);
// //           await TokenStorage.saveUserId(result["data"]["_id"]);
// //         }

// //         return result;
// //         // if (result != null) {
// //         //   GenerateOtpModel otpModel = GenerateOtpModel.fromJson(result);
// //         //   Fluttertoast.showToast(
// //         //       msg: "Your OTP is :- \n${otpModel.data}",
// //         //       toastLength: Toast.LENGTH_SHORT,
// //         //       gravity: ToastGravity.CENTER,
// //         //       timeInSecForIosWeb: 5,
// //         //       backgroundColor: Colors.black,
// //         //       textColor: Colors.white,
// //         //       fontSize: 16.0);

// //         //   user_id = otpModel.data;

// //         //   Get.toNamed(AppRoutes.verifyCode, arguments: {
// //         //     'otpModel': otpModel,
// //         //     'mobileNumber': mobileNumber,
// //         //     'countryCode': countryCode
// //         //   });
// //         //   return otpModel;
// //         // }
// //       } else {
// //         // Handle non-successful response here, if needed
// //       }
// //     } catch (error) {
// //       throw Exception("Failed to login. Error: $error");
// //     }
// //     return null;
// //   }

// //   Future<HostalList?> HostelModel() async {
// //     try {
// //       final response = await _dio.post(
// //         ApiConstant.hostel,
// //       );

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         // Successful response
// //         ApiInterceptor interceptor = _dio.interceptors
// //                 .firstWhere((interceptor) => interceptor is ApiInterceptor)
// //             as ApiInterceptor;
// //         dynamic result = interceptor.responseData;

// //         if (result != null) {
// //           HostalList HostelModel = HostalList.fromJson(result);

// //           return HostelModel;
// //         }
// //       } else {
// //         // Handle non-successful response here, if needed
// //       }
// //     } catch (error) {
// //       throw Exception("Failed to login. Error: $error");
// //     }
// //     return null;
// //   }

// //   Register(var data) async {
// //     try {
// //       final response = await _dio.post(ApiConstant.register, data: data);

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         // Successful response
// //         ApiInterceptor interceptor = _dio.interceptors
// //                 .firstWhere((interceptor) => interceptor is ApiInterceptor)
// //             as ApiInterceptor;
// //         dynamic result = interceptor.responseData;
// //         print("hehhe ${result["statusCode"]}");
// //         if (result["statusCode"] == 200) {
// //           Fluttertoast.showToast(
// //               msg: "${result["message"]}",
// //               toastLength: Toast.LENGTH_SHORT,
// //               gravity: ToastGravity.CENTER,
// //               timeInSecForIosWeb: 5,
// //               backgroundColor: Colors.black,
// //               textColor: Colors.white,
// //               fontSize: 16.0);
// //         }
// //         // if (result != null) {
// //         //   GenerateOtpModel otpModel = GenerateOtpModel.fromJson(result);
// //         //   Fluttertoast.showToast(
// //         //       msg: "Your OTP is :- \n${otpModel.data}",
// //         //       toastLength: Toast.LENGTH_SHORT,
// //         //       gravity: ToastGravity.CENTER,
// //         //       timeInSecForIosWeb: 5,
// //         //       backgroundColor: Colors.black,
// //         //       textColor: Colors.white,
// //         //       fontSize: 16.0);

// //         //   user_id = otpModel.data;

// //         //   Get.toNamed(AppRoutes.verifyCode, arguments: {
// //         //     'otpModel': otpModel,
// //         //     'mobileNumber': mobileNumber,
// //         //     'countryCode': countryCode
// //         //   });
// //         //   return otpModel;
// //         // }
// //       } else {
// //         // Handle non-successful response here, if needed
// //       }
// //     } catch (error) {
// //       throw Exception("Failed to login. Error: $error");
// //     }
// //     return null;
// //   }
// // }

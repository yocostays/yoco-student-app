import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/src/response.dart' as dio_response;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoco_stay_student/app/Storage/get_storage.dart';
import 'package:yoco_stay_student/app/core/network/apiconstant.dart';

class BaseService extends GetxService {
  SharedPreferences? sharedPreferences;


  BaseService();

  Future<dio_response.Response> getData({
    String endPoint = '',
    Map<String, dynamic>? queryBody,
    bool isTokenRequired = false,
  }) async {
    sharedPreferences ??= await SharedPreferences.getInstance();
    String token = TokenStorage.getToken() ?? '';
    try {
      Dio dio = _dio();
      if (isTokenRequired) {
        dio.options.headers['Authorization'] = token;
      }
      return await dio.get(
        ApiRoutes.baseUrl + endPoint,
        options: Options(headers: {'Content-Type': 'application/json'}),
        queryParameters: queryBody,
      );
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  static Dio _dioMultiPart(String? accessToken) {
    Dio dio = Dio();
    dio.options.baseUrl = ApiRoutes.baseUrl;
    dio.options.headers = {
      'Authorization': '$accessToken',
      Headers.acceptHeader: Headers.jsonContentType,
      'Content-Type': 'multipart/form-data',
    };
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          error: true,
          compact: false));
    }
    return dio;
  }

  static Dio _dio() {
    Dio dio = Dio();
    dio.options.baseUrl = ApiRoutes.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 20); // 10 seconds
    dio.options.headers = {
      Headers.acceptHeader: Headers.jsonContentType,
      'Content-Type': 'application/json',
    };
    dio.options.headers['lng'] = Get.deviceLocale?.languageCode ?? 'en';
    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        error: true,
        compact: false,
      ));
    }

    return dio;
  }

  postMultiPartData({
    required String endPoint,
    required bool isTokenRequired,
    required Map<String, dynamic>? body,
    Map<String, File>? files,
    String? aodiofiles,
    bool? aoudio,
  }) async {
    try {
      sharedPreferences ??= await SharedPreferences.getInstance();
      String token = TokenStorage.getToken() ?? '';
      // create form data body
      dio.FormData formData = dio.FormData.fromMap(body!);
      // add files in form data
      aoudio == true
          ? formData.files.add(MapEntry(
              'file',
              await dio.MultipartFile.fromFile(
                aodiofiles!,
                filename: basename(aodiofiles),
              )))
          : files?.forEach((key, value) async {
              try {
                formData.files.add(MapEntry(
                    'file',
                    await dio.MultipartFile.fromFile(
                      value.path,
                      filename: value.path.split("/").last,
                    )));
              } catch (e) {
                log(e.toString());
              }
            });

      dio.Response response = await _dioMultiPart(token).post(
        endPoint,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      // throw error
      return Future.error(e);
    }
  }

  // for single images
  KycDocumentpostMultiPartData({
    required String endPoint,
    required bool isTokenRequired,
    required Map<String, dynamic>? body,
    File? file,
    String? datatype,
    bool? delete,
  }) async {
    try {
      sharedPreferences ??= await SharedPreferences.getInstance();
      String token = TokenStorage.getToken() ?? '';
      // create form data body
      dio.FormData formData = dio.FormData.fromMap(body!);
      // add files in form data
      if (file != null) {
        try {
          formData.files.add(MapEntry(
            'file',
            await dio.MultipartFile.fromFile(
              file.path,
              filename: file.path.split("/").last,
            ),
          ));
        } catch (e) {
          log('Error adding file: ${e.toString()}');
        }
      } else {
        formData.fields.add(const MapEntry('file', ""));
      }
      formData.fields.add(MapEntry('type', datatype ?? ""));

      dio.Response response = await _dioMultiPart(token).post(
        endPoint,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      // throw error
      return Future.error(e);
    }
  }

  putMultiPartData(
      {required String endPoint,
      required bool isTokenRequired,
      required Map<String, dynamic>? body,
      required Map<String, File>? files}) async {
    try {
      sharedPreferences ??= await SharedPreferences.getInstance();
      String token = TokenStorage.getToken() ?? '';
      // create form data body
      dio.FormData formData = dio.FormData.fromMap(body!);
      // add files in form data
      files?.forEach((key, value) async {
        try {
          formData.files.add(MapEntry(
              key,
              await dio.MultipartFile.fromFile(
                value.path,
                filename: value.path.split("/").last,
              )));
        } catch (e) {
          log(e.toString());
        }
      });
      dio.Response response = await _dioMultiPart(token).put(
        endPoint,
        data: formData,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  putMultiPartData2(
      {required String endPoint,
      required bool isTokenRequired,
      required Map<String, dynamic>? body,
      Map<String, Uint8List>? files}) async {
    try {
      sharedPreferences ??= await SharedPreferences.getInstance();
      String token = TokenStorage.getToken() ?? '';
      // create form data body
      dio.FormData formData = dio.FormData.fromMap(body!);
      // add files in form data
      files?.forEach((key, value) async {
        try {
          formData.files.add(MapEntry(
            key,
            dio.MultipartFile.fromBytes(
              value,
              filename: key, // You might want to generate a proper filename
            ),
          ));
        } catch (e) {
          log(e.toString());
        }
      });
      dio.Response response = await _dioMultiPart(token).put(
        endPoint,
        data: formData,
      );

      print("response: $response");
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  postData(
      {required String endPoint,
      required Map<String, dynamic> body,
      required bool isTokenRequired}) async {
    try {
      sharedPreferences ??= await SharedPreferences.getInstance();
      String token = TokenStorage.getToken() ?? '';
      Dio dio = _dio();
      if (isTokenRequired) {
        dio.options.headers['Authorization'] = token;
      }
      return await dio.post(
        ApiRoutes.baseUrl + endPoint,
        data: body,
      );
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  deleteData(
      {required String endPoint,
      Map<String, dynamic>? body,
      required bool isTokenRequired}) async {
    try {
      sharedPreferences ??= await SharedPreferences.getInstance();
      // String token = sharedPreferences!.getString(KeysConstant.userToken) ?? '';
      String token = TokenStorage.getToken() ?? '';
      Dio dio = _dio();
      if (isTokenRequired) {
        dio.options.headers['Authorization'] = token;
      }
      return await dio.delete(
        ApiRoutes.baseUrl + endPoint,
        data: body,
      );
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  putData(
      {required String endPoint,
      required Map<String, dynamic> body,
      required bool isTokenRequired}) async {
    try {
      sharedPreferences ??= await SharedPreferences.getInstance();
      // String token = sharedPreferences!.getString(KeysConstant.userToken) ?? '';
      String token = TokenStorage.getToken() ?? '';
      Dio dio = _dio();
      if (isTokenRequired) {
        dio.options.headers['Authorization'] = token;
      }
      return await dio.put(
        ApiRoutes.baseUrl + endPoint,
        data: body,
      );
    } on DioException catch (e) {
      return Future.error(e);
    }
  }

  patchData(
      {required String endPoint,
      required Map<String, dynamic> body,
      required bool isTokenRequired}) async {
    try {
      sharedPreferences ??= await SharedPreferences.getInstance();
      // String token = sharedPreferences!.getString(KeysConstant.userToken) ?? '';
      String token = TokenStorage.getToken() ?? '';
      Dio dio = _dio();
      if (isTokenRequired == true) {
        dio.options.headers['Authorization'] = token;
      }
      return await dio.patch(
        ApiRoutes.baseUrl + endPoint,
        data: body,
      );
    } on DioException catch (e) {
      return Future.error(e);
    }
  }
}

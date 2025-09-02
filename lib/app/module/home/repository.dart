import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoco_stay_student/app/core/network/apiconstant.dart';
import 'package:yoco_stay_student/app/core/network/base_service.dart';
import 'package:yoco_stay_student/app/module/home/models/booked_date.dart';

import 'package:yoco_stay_student/app/module/home/models/response/today_menu_respones_model.dart';
import 'package:yoco_stay_student/app/module/home/models/response/totaldata_response.dart';
import 'package:yoco_stay_student/app/module/home/models/today_menu_model.dart';
import 'package:yoco_stay_student/app/module/home/models/total_data_home.dart';
import 'package:yoco_stay_student/app/module/profile/models/hostail_Model.dart';
import 'package:yoco_stay_student/app/module/profile/models/response/hostail_response.dart';

import 'package:yoco_stay_student/app/utils/utils.dart';

class HomeController extends GetxController {
  SharedPreferences? prefs;

  String Name = '';

  Rx<HostelDetailData> hostelDetailsDatas =
      Rx<HostelDetailData>(HostelDetailData());
  Rx<TodayMenuModel> todayMealData = Rx<TodayMenuModel>(TodayMenuModel());
  Rx<TotalHomedata> HometotalData = Rx<TotalHomedata>(TotalHomedata());
  Rx<BookedDateResponse> BookedDate =
      Rx<BookedDateResponse>(BookedDateResponse());

  // <--------------------------- Get Hostel detail data ---------------------------------
  RxBool HosteldataLoading = false.obs;
  void GetHostelData() async {
    HosteldataLoading.value = true;
    try {
      var Getprofiledata = await GetHostelResponse();
      if (Getprofiledata.data != null) {
        hostelDetailsDatas.value = Getprofiledata.data!;
      }
      HosteldataLoading.value = false;
    } catch (e) {
      print("Error fetching draft jobs: $e");
      HosteldataLoading.value = false;
    } finally {
      HosteldataLoading.value = false;
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
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return HostelDetailResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <=========================== Get Todays Menu Data ==================================
  RxBool MealdataLoading = false.obs;
  void GetTodayMealData() async {
    MealdataLoading.value = true;
    try {
      var Getmealdata = await GetTodayMealResponse();
      if (Getmealdata.data != null) {
        todayMealData.value = Getmealdata.data!;
      }
      MealdataLoading.value = false;
    } catch (e) {
      print("Error fetching draft jobs: $e");
      MealdataLoading.value = false;
    } finally {
      MealdataLoading.value = false;
    }
  }

  Future<TodayMenuResponse> GetTodayMealResponse() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetTodayMeals,
        isTokenRequired: true,
        body: {},
      );
      return TodayMenuResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return TodayMenuResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <========================== Book Meal Section =======================================
  DateTime? SelectedDate;
  DateTime? EndDate;
  RxBool Breakfast = false.obs;
  RxBool Lunch = false.obs;
  RxBool Dinner = false.obs;
  RxBool heightea = false.obs;
  RxBool Fullday = false.obs;
  RxBool BookMealLoading = false.obs;

  BookMeal() async {
    print(" hello date $SelectedDate, enddate $EndDate");
    BookMealLoading(true);
    EndDate ??= SelectedDate;
    SelectedDate ??= EndDate;
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().BookMeals,
          isTokenRequired: true,
          body: Fullday.value == true
              ? {
                  "fromDate": "$SelectedDate",
                  "toDate": "$EndDate",
                  "isBreakfastBooked": true,
                  "isLunchBooked": true,
                  "isDinnerBooked": true,
                  "isfullDay": true,
                  "isSnacksBooked": true
                }
              : {
                  "fromDate": "$SelectedDate",
                  "toDate": "$EndDate",
                  "isBreakfastBooked": Breakfast.value,
                  "isLunchBooked": Lunch.value,
                  "isDinnerBooked": Dinner.value,
                  "isSnacksBooked": heightea.value
                });

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
        removevalueBookmeal();
        BookMealLoading(false);
        Get.back();
      }
    } on DioException catch (e) {
      // print(e.response);
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontsize: 16,
      );
      BookMealLoading(false);
    }
  }

  removevalueBookmeal() {
    Breakfast(false);
    Lunch(false);
    Dinner(false);
    Reason.clear();
  }

  // <================================= Cancel Book Meal =======================
  List<DateTime?> selectedDay = [];
  final TextEditingController Reason = TextEditingController();
  RxBool CancelMealLoading = false.obs;

  CancelMeal() async {
    EndDate ??= SelectedDate;
    prefs = await SharedPreferences.getInstance();
    try {
      CancelMealLoading(true);
      var response = await BaseService().postData(
          endPoint: ApiRoutes().CancleMeals,
          isTokenRequired: true,
          body: Fullday.value == true
              ? {
                  "fromDate": "${selectedDay.first}",
                  "toDate": "${selectedDay.last}",
                  "isBreakfastBooked": false,
                  "isLunchBooked": false,
                  "cancellationReason": Reason.text,
                  "isDinnerBooked": false,
                  "isSnacksBooked": false
                }
              : {
                  "fromDate": "${selectedDay.first}",
                  "toDate": "${selectedDay.last}",
                  "isBreakfastBooked": Breakfast.value,
                  "isLunchBooked": Lunch.value,
                  "cancellationReason": Reason.text,
                  "isDinnerBooked": Dinner.value,
                  "isSnacksBooked": heightea.value
                });

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
        removevalueBookmeal();
        CancelMealLoading(false);
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
      CancelMealLoading(false);
    }
  }

  // <=========================== Get All total data ==================================
  void GetTotalData() async {
    MealdataLoading.value = true;
    try {
      var Getmealdata = await GetTotalSectiondata();
      if (Getmealdata.data != null) {
        HometotalData.value = Getmealdata.data!;
      }
      MealdataLoading.value = false;
    } catch (e) {
      print("Error fetching draft jobs: $e");
      MealdataLoading.value = false;
    } finally {
      MealdataLoading.value = false;
    }
  }

  Future<TotalSectionDataResponse> GetTotalSectiondata() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().HomesetionCount,
        isTokenRequired: true,
        body: {},
      );
      return TotalSectionDataResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return TotalSectionDataResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<======================================== Booked Date get data ===========================
  RxBool BookedDateLoading = false.obs;
  List<String>? isoDateStrings;
  GetBookedData(DateTime date) async {
    BookedDateLoading(true);
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().BookedDateData,
        isTokenRequired: true,
        body: {"date": "$date"}, // Send date as ISO 8601 string
      );

      if (response.data != null) {
        // Parse the response correctly into BookedDateResponse
        BookedDateResponse bookedDateResponse =
            BookedDateResponse.fromJson(response.data);
        BookedDate.value = bookedDateResponse;
        isoDateStrings = BookedDate.value.date;
        BookedDateLoading(false); // Update BookedDate with the parsed object
        return bookedDateResponse;
      }
      BookedDateLoading(false);
      return BookedDateResponse(
        statusCode: 404,
        message: "No data available",
      );
    } on DioException catch (e) {
      print("API Error: ${e.message} - ${e.response?.data}");
      BookedDateLoading(false);

      return BookedDateResponse(
        statusCode: 500,
        message: e.message,
      );
    }
  }
}

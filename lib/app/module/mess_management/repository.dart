import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoco_stay_student/app/Storage/get_storage.dart';
import 'package:yoco_stay_student/app/core/network/apiconstant.dart';
import 'package:yoco_stay_student/app/core/network/base_service.dart';
import 'package:yoco_stay_student/app/module/home/models/booked_date.dart';
import 'package:yoco_stay_student/app/module/home/models/response/today_menu_respones_model.dart';
import 'package:yoco_stay_student/app/module/home/models/today_menu_model.dart';
import 'package:yoco_stay_student/app/module/mess_management/model/cencel_history_data.dart';
import 'package:yoco_stay_student/app/module/mess_management/model/responce/cancel_history_responce.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/login_signup.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class MessController extends GetxController {
  late TabController mealstatusController;
  DateTime selectedDay = DateTime.now();
  TextEditingController Selecteddate = TextEditingController();

  SharedPreferences? prefs;
  Rx<TodayMenuModel> todayMealData = Rx<TodayMenuModel>(TodayMenuModel());

  // <=========================== Get Todays Menu Data ==================================
  RxBool MealdataLoading = false.obs;
  void GetTodayMealData(DateTime date) async {
    MealdataLoading.value = true;
    try {
      var Getmealdata = await GetTodayMealResponse(date);
      if (Getmealdata.data != null) {
        todayMealData.value = Getmealdata.data!;
      } else {
        todayMealData.value = TodayMenuModel();
      }
      MealdataLoading.value = false;
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print("$e.");
      todayMealData.value = TodayMenuModel();
      MealdataLoading.value = false;
    }
    // finally {
    //   print("this field is shown");
    //   MealdataLoading.value = false;
    // }
  }

  Future<TodayMenuResponse> GetTodayMealResponse(DateTime date) async {
    print("date : $date");
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetTodayMeals,
        isTokenRequired: true,
        body: {"mealDate": "$date"},
      );
      return TodayMenuResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      return TodayMenuResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  // <================================= Cancel Book Meal =======================
  List<DateTime?> selectedDayList = [];
  DateTime? SelectedDate;
  DateTime? EndDate;
  RxBool Breakfast = false.obs;
  RxBool Lunch = false.obs;
  RxBool Dinner = false.obs;
  RxBool heightea = false.obs;
  RxBool Fullday = false.obs;
  RxBool BookMealLoading = false.obs;
  final TextEditingController Reason = TextEditingController();
  RxBool CancelMealLoading = false.obs;

  CancelMeal() async {
    CancelMealLoading(true);
    if (selectedDayList.isEmpty) {
      Utils.showToast(
        message: "Please Selecte Date",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return;
    }
    // if (selectedDayList.isEmpty) {

    // }
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().CancleMeals,
          isTokenRequired: true,
          body: Fullday.value == true
              ? {
                  "fromDate": "${selectedDayList.first}",
                  "toDate": "${selectedDayList.last}",
                  "isBreakfastBooked": false,
                  "isLunchBooked": false,
                  "cancellationReason": Reason.text,
                  "isDinnerBooked": false,
                  "isSnacksBooked": false
                }
              : {
                  "fromDate": "${selectedDayList.first}",
                  "toDate": "${selectedDayList.last}",
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
      print(e.response);
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      CancelMealLoading(false);
    }
    // finally {
    //   Utils.showToast(
    //     message: "Meal List is Not Ready for this Days.",
    //     gravity: ToastGravity.BOTTOM,
    //     textColor: Colors.white,
    //     fontsize: 16,
    //   );
    //   CancelMealLoading(false);
    // }
  }

  removevalueBookmeal() {
    Breakfast(false);
    Lunch(false);
    Dinner(false);
    Reason.clear();
  }

  // <---------------------------- this Function is call for get Hostel Data from api there are two function
  RxList<CencelHistoryData> CancelHistorydata = RxList<CencelHistoryData>();
  RxBool CencelHistoryLoading = false.obs;
  void GetCancleedMealList() async {
    CencelHistoryLoading(true);
    try {
      var CencleHistory = await GetCencleHistory();
      if (CencleHistory.date != null) {
        CancelHistorydata.assignAll(CencleHistory.date!);
        print("Cancel History data: ${CancelHistorydata.length}");
      }
      CencelHistoryLoading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      CencelHistoryLoading(false);
    } finally {
      // isDraftJobListLoading.value = false;
    }
  }

  Future<CencelHistoryResponce> GetCencleHistory() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().CancleMealshistory,
        isTokenRequired: true,
        body: {"status": "cancelled"},
      );
      return CencelHistoryResponce.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return CencelHistoryResponce(
        statusCode: 500,
        message: e.message,
        date: null,
      );
    }
  }

  // <---------------------------- this Function is call when see booked ticket status ===========================

  RxList<CencelHistoryData> BookedTicketHistorydata =
      RxList<CencelHistoryData>();
  RxBool BookedTicketLoading = false.obs;
  void GetBookedMealList() async {
    CencelHistoryLoading(true);
    try {
      var CencleHistory = await GetBookedHistory();
      if (CencleHistory.date != null) {
        BookedTicketHistorydata.assignAll(CencleHistory.date!);
        print("Cancel History data: ${CancelHistorydata.length}");
      }
      CencelHistoryLoading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      CencelHistoryLoading(false);
    } finally {
      // isDraftJobListLoading.value = false;
    }
  }

  Future<CencelHistoryResponce> GetBookedHistory() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().CancleMealshistory,
        isTokenRequired: true,
        body: {"status": "booked"},
      );
      return CencelHistoryResponce.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return CencelHistoryResponce(
        statusCode: 500,
        message: e.message,
        date: null,
      );
    }
  }

  //<================================ Edit booked and cancel ticket======================
  DateTime? EditSelectedDate;
  RxString EditTicketId = "".obs;
  RxBool EditBreakfast = false.obs;
  RxBool EditLunch = false.obs;
  RxBool EditDinner = false.obs;
  RxBool Editheightea = false.obs;
  RxBool EditFullday = false.obs;
  RxBool EditBookMealLoading = false.obs;
  RxBool BookEditPage = false.obs;

  EditMeal() async {
    EditBookMealLoading(true);

    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().EditTickts,
          isTokenRequired: true,
          body: EditFullday.value == true
              ? {
                  "bookingId": EditTicketId.value,
                  "isBreakfastBooked": true,
                  "isLunchBooked": true,
                  "isDinnerBooked": true,
                  "isSnacksBooked": true,
                  "isfullDay": true
                }
              : {
                  "bookingId": EditTicketId.value,
                  "isBreakfastBooked": EditBreakfast.value,
                  "isLunchBooked": EditLunch.value,
                  "isDinnerBooked": EditDinner.value,
                  "isSnacksBooked": Editheightea.value,
                  "isfullDay": EditFullday.value
                });

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
        BookEditPage.value ? GetBookedMealList() : GetCancleedMealList();
        EditBookMealLoading(false);
        Get.back();
      }
    } on DioException catch (e) {
      print(e.response);
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      EditBookMealLoading(false);
    }
    // finally {
    //   Utils.showToast(
    //     message: "Meal List is Not Ready for this Days.",
    //     gravity: ToastGravity.BOTTOM,
    //     textColor: Colors.white,
    //     fontsize: 16,
    //   );
    //   CancelMealLoading(false);
    // }
  }

  //<================================ Remove Cancel list from user ======================================

  RxBool deleteticketloader = false.obs;
  deleteticket(String id) async {
    deleteticketloader(true);

    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
          endPoint: ApiRoutes().DeleteCancelTicket,
          isTokenRequired: true,
          body: {"mealId": id});

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: "${response?.data['message']}",
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
        BookEditPage.value ? GetBookedMealList() : GetCancleedMealList();
        Get.back();
      }
    } on DioException catch (e) {
      print(e.response);
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      Utils.showToast(
        message: "${e.response?.data['message']}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      CancelMealLoading(false);
    }
  }

  //<======================================== Booked Date get data ===========================
  RxBool BookedDateLoading = false.obs;
  Rx<BookedDateResponse> bookedDate =
      Rx<BookedDateResponse>(BookedDateResponse());
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
        bookedDate.value = bookedDateResponse;
        isoDateStrings = bookedDate.value.date;
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

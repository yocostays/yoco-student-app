import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoco_stay_student/app/core/network/apiconstant.dart';
import 'package:yoco_stay_student/app/core/network/base_service.dart';
import 'package:yoco_stay_student/app/module/get_pass/model/get_approve_model.dart';
import 'package:yoco_stay_student/app/module/get_pass/model/response/get_out-ticket_response.dart';

import 'package:yoco_stay_student/app/module/leave_status/models/leave_category_model.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/leave_list_model.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/response/leave_category_response.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/response/leave_list_response.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class GetPassController extends GetxController {
  SharedPreferences? prefs;
  late TabController getpasstabController;

  //<================================ Day Out Category data api =========================
  RxList<LeaveCategoryModel> DayoutCategorydata = RxList<LeaveCategoryModel>();
  RxInt Textlength = 0.obs;

  RxBool dayoutcategoryloading = false.obs;

  Future<void> GetCategoryListdata(String type) async {
    dayoutcategoryloading(true);
    try {
      var dayoutCatogoryList = await GetCategoryList(type);
      if (dayoutCatogoryList.data != null) {
        DayoutCategorydata.assignAll(dayoutCatogoryList.data!);
        dayoutcategoryloading(false);
      }
      dayoutcategoryloading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      dayoutcategoryloading(false);
    } finally {
      dayoutcategoryloading(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<LeaveCategoryResponse> GetCategoryList(String type) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().GetLeaveCategory,
        isTokenRequired: true,
        body: {"type": type},
      );
      return LeaveCategoryResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return LeaveCategoryResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<=============================== Create Day out Application =================================
  final TextEditingController Noofhours = TextEditingController();
  final TextEditingController TimeRange = TextEditingController();
  DateTime? StartTime;
  DateTime? EndTime;
  final TextEditingController personname = TextEditingController();
  final TextEditingController contactnumber = TextEditingController();
  final TextEditingController DayoutCetegory = TextEditingController();
  final TextEditingController discription = TextEditingController();
  RxBool DayOutCreating = false.obs;
  SubmitLeaveApplication() async {
    prefs = await SharedPreferences.getInstance();

    try {
      DayOutCreating(true);
      var response = await BaseService().postData(
        endPoint: ApiRoutes().CreateDayoutapllication,
        isTokenRequired: true,
        body: {
          "leaveType": "day out",
          "categoryId": DayoutCetegory.text,
          "startDate": "$StartTime",
          "endDate": "$EndTime",
          "hours": Noofhours.text,
          "description": discription.text,
          "visitorName": "personname.text",
          "visitorNumber":
              contactnumber.text.isEmpty ? null : int.parse(contactnumber.text)
        },
      );

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: response.data['message'],
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          fontsize: 16,
        );
        Cleardata();
        DayOutCreating(false);
        Get.offAllNamed(AppRoute.daynightout);
      }
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");
      Utils.showToast(
        message: "${e.response?.data["message"]}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      DayOutCreating(false);
    }
  }

  //<================================== Get DayOut List data ================================
  RxList<LeaveListModel> PendingDayOutListData = RxList<LeaveListModel>();
  RxList<LeaveListModel> ApprovedDayOutListData = RxList<LeaveListModel>();
  RxList<LeaveListModel> RejectedDayOutListData = RxList<LeaveListModel>();

  RxBool DayOutListloading = false.obs;
  RxInt pendingpage = 1.obs;

  Future<void> GayOutDataList(
      String status, String Secttion, bool? loadmore) async {
    loadmore == true ? 0 : DayOutListloading(true);
    loadmore == true ? pendingpage.value++ : pendingpage.value = 1;
    try {
      var CatogoryList =
          await DayoutDataListGet(status, Secttion, pendingpage.value);
      if (CatogoryList.data != null && status == "pending") {
        DayOutListloading(true);
        loadmore == true
            ? PendingDayOutListData.addAll(CatogoryList.data!)
            : PendingDayOutListData.assignAll(CatogoryList.data!);
        DayOutListloading(false);
      } else if (CatogoryList.data != null && status == "approved") {
        DayOutListloading(true);
        loadmore == true
            ? ApprovedDayOutListData.addAll(CatogoryList.data!)
            : ApprovedDayOutListData.assignAll(CatogoryList.data!);
        DayOutListloading(false);
      } else if (CatogoryList.data != null && status == "rejected") {
        DayOutListloading(true);
        loadmore == true
            ? RejectedDayOutListData.addAll(CatogoryList.data!)
            : RejectedDayOutListData.assignAll(CatogoryList.data!);
        DayOutListloading(false);
      }
      loadmore == true ? 0 : DayOutListloading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      DayOutListloading(false);
    } finally {
      DayOutListloading(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<LeaveListResponse> DayoutDataListGet(
      String status, String Section, int pagenumber) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().getData(
        endPoint:
            '${ApiRoutes().LeaveListData}?page=$pagenumber&limit=10&status=$status&type=$Section',
        isTokenRequired: true,
      );
      return LeaveListResponse.fromJson(response.data);
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return LeaveListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<================================== Get  Day outList data ================================
  // RxList<GetOutApproveModel> DayOutapprovedData = RxList<GetOutApproveModel>();
  Rx<GetOutApproveModel> DayOutapprovedData =
      Rx<GetOutApproveModel>(GetOutApproveModel());

  RxBool DayOutApprovedloading = false.obs;

  Future<void> GetLeaveDataList(
    String dayoutid,
  ) async {
    DayOutApprovedloading(true);
    try {
      var Getoutapproveddata = await GetOutApprovedataGet(dayoutid);
      if (Getoutapproveddata.data != null) {
        DayOutapprovedData.value = Getoutapproveddata.data!;
        DayOutApprovedloading(false);
      }
      DayOutApprovedloading(false);
    } catch (e) {
      DayOutApprovedloading(false);
    } finally {
      DayOutApprovedloading(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<GetOutTicketResponse> GetOutApprovedataGet(String dayoutid) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().dayOutApprovedData,
        isTokenRequired: true,
        body: {"leaveId": dayoutid},
      );
      return GetOutTicketResponse.fromJson(response.data);
    } on DioException catch (e) {
      print("API Error: ${e.message} - ${e.response?.data}");

      return GetOutTicketResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //< ============================ Remove DayOut Application ================================
  RxBool RemoveLeaveLoading = false.obs;

  Removedayout(String id) async {
    RemoveLeaveLoading(true);
    prefs = await SharedPreferences.getInstance();

    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().leaveanddayoutRemove, // change this
        isTokenRequired: true,
        body: {"leaveId": id},
      );
      Utils.showToast(
        message: "${response.data["message"]}",
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontsize: 16,
      );
      GayOutDataList("pending", "day out", false);

      RemoveLeaveLoading(false);
      Get.back();
    } on DioException catch (e) {
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");
      RemoveLeaveLoading(false);
    }
  }

  //Visitor section ==============
  final TextEditingController visitorname = TextEditingController();
  final TextEditingController relationwithstudent = TextEditingController();
  final TextEditingController reasonforvisiting = TextEditingController();
  final TextEditingController Arriveldate = TextEditingController();
  final TextEditingController ArrivelTimeRange = TextEditingController();
  final TextEditingController Departuredate = TextEditingController();
  final TextEditingController Departuretime = TextEditingController();

  //<================================ don't f@^&*$$ Remove this two function ===========================
  String formatTimeRange(
      BuildContext context, TimeOfDay? startTime, TimeOfDay? endTime) {
    if (startTime == null || endTime == null) return '';

    final duration = calculateDuration(startTime, endTime);

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    Noofhours.text = '$hours : ${minutes <= 9 ? "0$minutes" : minutes} ';
    final localizations = MaterialLocalizations.of(context);

    final startFormatted =
        localizations.formatTimeOfDay(startTime, alwaysUse24HourFormat: false);
    final endFormatted =
        localizations.formatTimeOfDay(endTime, alwaysUse24HourFormat: false);

    return '$startFormatted - $endFormatted';
  }

  Duration calculateDuration(TimeOfDay startTime, TimeOfDay endTime) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    // If end time is before start time, assume it's on the next day
    final difference = (endMinutes - startMinutes + 1440) % 1440;

    return Duration(minutes: difference);
  }

  Cleardata() {
    Noofhours.clear();
    TimeRange.clear();
    StartTime = null;
    EndTime = null;
    personname.clear();
    contactnumber.clear();
    DayoutCetegory.clear();
    discription.clear();
  }
}

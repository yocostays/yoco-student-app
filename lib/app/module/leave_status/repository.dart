import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoco_stay_student/app/Storage/get_storage.dart';
import 'package:yoco_stay_student/app/core/network/apiconstant.dart';
import 'package:yoco_stay_student/app/core/network/base_service.dart';
import 'package:yoco_stay_student/app/module/get_pass/model/get_approve_model.dart';
import 'package:yoco_stay_student/app/module/get_pass/model/response/get_out-ticket_response.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/leave_category_model.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/leave_list_model.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/response/leave_category_response.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/response/leave_list_response.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/response/single_leave_response.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/single_leave_status_model.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/login_signup.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class LeaveController extends GetxController {
  SharedPreferences? prefs;
  var selectedDay = <DateTime?>[].obs;
  RxInt tabvalue = 1.obs;
  final TextEditingController discription = TextEditingController();
  late TabController getpasstabController;
  late TabController tabController;
  RxInt selectedindex = 0.obs; // Make this an Rx variable to observe changes


  //<================================ Get Category data api =========================
  RxList<LeaveCategoryModel> Categorydata = RxList<LeaveCategoryModel>();
  RxInt Textlength = 0.obs;

  RxBool leavecategoryloading = false.obs;

  Future<void> GetCategoryListdata(String type) async {
    leavecategoryloading(true);
    try {
      var CatogoryList = await GetCategoryList(type);
      if (CatogoryList.data != null) {
        Categorydata.assignAll(CatogoryList.data!);
        leavecategoryloading(false);
      }
      leavecategoryloading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      leavecategoryloading(false);
    } finally {
      leavecategoryloading(false);
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

  //<================================== Submit Leave Application =====================
  TextEditingController selectDaterang = TextEditingController();
  TextEditingController firstdateDate = TextEditingController();
  TextEditingController firstdatetime = TextEditingController();
  TextEditingController lastdateDate = TextEditingController();
  TextEditingController lastdatetime = TextEditingController();
  TextEditingController totaldate = TextEditingController();
  TextEditingController selectedPurpose = TextEditingController();
  RxBool LeaveCreating = false.obs;
  SubmitLeaveApplication() async {
    prefs = await SharedPreferences.getInstance();

    if (selectedDay.isEmpty) {
      print("No days selected for leave application");
      Utils.showToast(
        message: "No days selected for leave application.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return; // Stop the function if no days are selected
    }

    try {
      LeaveCreating(true);
      var response = await BaseService().postData(
        endPoint: ApiRoutes().SubmitLeaveCategory,
        isTokenRequired: true,
        body: {
          "categoryId": selectedPurpose.text,
          "startDate": "${selectedDay.first}",
          "endDate": "${selectedDay.last}",
          "days": selectedDay.length,
          "description": discription.text
        },
      );

      if (response.data['statusCode'] == 200) {
        Clear();
        GetLeaveDataList("pending", "leave", false); // true is load more option
        Get.offAllNamed(AppRoute.leavepage);
        LeaveCreating(false);
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
      if (e.response?.data["statusCode"] == 400) {
        Utils.showToast(
          message: e.response?.data["message"],
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          fontsize: 16,
        );
      }
      LeaveCreating(false);
    }
  }

  //<================================== Get LeaveList data ================================
  RxList<LeaveListModel> LeaveListData = RxList<LeaveListModel>();
  RxInt pendingpage = 1.obs;
  RxBool leaveListloading = false.obs;

  Future<void> GetLeaveDataList(
      String status, String Secttion, bool? loadmore) async {
    leaveListloading(true);
    loadmore == true ? pendingpage.value++ : pendingpage.value = 1;
    try {
      var CatogoryList =
          await LeaveDataListGet(status, Secttion, pendingpage.value);
      if (CatogoryList.data != null) {
        loadmore == true
            ? LeaveListData.addAll(CatogoryList.data!)
            : {
                LeaveListData.clear(),
                LeaveListData.assignAll(CatogoryList.data!)
              };
        leaveListloading(false);
      }
      leaveListloading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      leaveListloading(false);
    } finally {
      leaveListloading(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<LeaveListResponse> LeaveDataListGet(
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
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return LeaveListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<================================== Get Rejected LeaveList data ================================
  RxList<LeaveListModel> RejectedLeaveListData = RxList<LeaveListModel>();
  RxInt Rejectectedpage = 1.obs;
  RxBool RejectedleaveListloading = false.obs;

  Future<void> GetRejectedLeaveListData(
      String status, String Secttion, bool? loadmore) async {
    RejectedleaveListloading(true);
    loadmore == true ? Rejectectedpage.value++ : Rejectectedpage.value = 1;
    try {
      var CatogoryList = await RejectedLeaveDataListGet(status, Secttion);
      if (CatogoryList.data != null) {
        loadmore == true
            ? RejectedLeaveListData.addAll(CatogoryList.data!)
            : {
                RejectedLeaveListData.clear(),
                RejectedLeaveListData.assignAll(CatogoryList.data!)
              };
        leaveListloading(false);
      }
      RejectedleaveListloading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      RejectedleaveListloading(false);
    } finally {
      RejectedleaveListloading(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<LeaveListResponse> RejectedLeaveDataListGet(
      String status, String Section) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().getData(
        endPoint:
            '${ApiRoutes().LeaveListData}?page=1&limit=10&status=$status&type=$Section',
        isTokenRequired: true,
      );
      return LeaveListResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return LeaveListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<================================== Get Approved LeaveList data ================================
  RxList<LeaveListModel> ApprovedLeaveListData = RxList<LeaveListModel>();
  RxInt Approvedpagenation = 1.obs;
  RxBool ApprovedleaveListloading = false.obs;

  Future<void> GetApprovedLeaveListData(
      String status, String Secttion, bool Loadmore) async {
    ApprovedleaveListloading(true);
    Loadmore == true
        ? Approvedpagenation.value++
        : Approvedpagenation.value = 1;
    try {
      var CatogoryList = await ApprovedLeaveDataListGet(status, Secttion);
      if (CatogoryList.data != null) {
        Loadmore == true
            ? ApprovedLeaveListData.addAll(CatogoryList.data!)
            : {
                ApprovedLeaveListData.clear(),
                ApprovedLeaveListData.assignAll(CatogoryList.data!)
              };
        leaveListloading(false);
      }
      ApprovedleaveListloading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      ApprovedleaveListloading(false);
    } finally {
      ApprovedleaveListloading(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<LeaveListResponse> ApprovedLeaveDataListGet(
      String status, String Section) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().getData(
        endPoint:
            '${ApiRoutes().LeaveListData}?page=1&limit=10&status=$status&type=$Section',
        isTokenRequired: true,
      );
      return LeaveListResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return LeaveListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<================================== Get Single Leave Status ================================
  RxList<SingleLeaveStatusModel> SingleLeaveStatusData =
      RxList<SingleLeaveStatusModel>();

  RxBool leaveStatusdataloading = false.obs;

  Future<void> GetLeaveStatusData(String id) async {
    leaveStatusdataloading(true);
    try {
      var leaveStatus = await LeaveStatusDataGet(id);
      if (leaveStatus.data != null) {
        SingleLeaveStatusData.assignAll(leaveStatus.data!);
        leaveStatusdataloading(false);
      }
      leaveStatusdataloading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      leaveStatusdataloading(false);
    } finally {
      leaveStatusdataloading(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<SingleLeaveStatusResponse> LeaveStatusDataGet(String id) async {
    prefs = await SharedPreferences.getInstance();
    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().LeaveStatusData,
        isTokenRequired: true,
        body: {"leaveId": id},
      );
      return SingleLeaveStatusResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return SingleLeaveStatusResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<=============================== Create Late Coming Application =================================
  final TextEditingController Noofhours = TextEditingController();
  final TextEditingController TimeRange = TextEditingController();
  DateTime? StartTime;
  DateTime? EndTime;
  final TextEditingController personname = TextEditingController();
  final TextEditingController contactnumber = TextEditingController();
  final TextEditingController DayoutCetegory = TextEditingController();
  RxBool LateComingCreating = false.obs;

  SubmitLateComingApplication() async {
    print(
        "hello data $StartTime , $EndTime, ${Noofhours.text}, ${selectedDay.isNotEmpty ? selectedDay.first : 'No Day Selected'}, ${discription.text}");

    prefs = await SharedPreferences.getInstance();

    // Validate Time Range
    if (StartTime == null || EndTime == null) {
      print("Please Select Time Range.");
      Utils.showToast(
        message: "Please select a valid time range.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return; // Stop if no time range is selected
    }

    // Validate Description
    if (discription.text.isEmpty) {
      Utils.showToast(
        message: "Please provide a reason for leave.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return; // Stop if no description is provided
    }
    if (Noofhours.text.isEmpty) {
      Utils.showToast(
        message: "Time is Required.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return; // Stop if no description is provided
    }

    // Validate Selected Day
    if (selectedDay.isEmpty) {
      print("No Day Selected.");
      Utils.showToast(
        message: "Please select a day.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return; // Stop if no day is selected
    }

    try {
      LateComingCreating(true); // Start loading state

      // API call
      var response = await BaseService().postData(
        endPoint: ApiRoutes().CreateDayoutapllication,
        isTokenRequired: true,
        body: {
          "leaveType": "late coming",
          "startDate": "$StartTime",
          "endDate": "$EndTime",
          "hours": Noofhours.text,
          "description": discription.text,
        },
      );

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: response.data['message'],
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          fontsize: 16,
        );
        Clear(); // Clear input fields
        GetLeaveDataList("pending", "late coming", false); // Refresh list
        Get.back(); // Go back to the previous page
      }
    } on DioException catch (e) {
      // Handle API errors
      Utils.showToast(
        message: "Error: ${e.message}",
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontsize: 16,
      );

      if (e.response?.data["statusCode"] == 401) {
        // Handle unauthorized access
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }

      print("API Error: ${e.message} - ${e.response?.data}");
    } finally {
      // Always turn off loading state
      LateComingCreating(false);
    }
  }

  // SubmitLateComingApplication() async {
  //   print(
  //       "hello data $StartTime , $EndTime, ${Noofhours.text}, ${selectedDay.first}, ${discription.text}");
  //   prefs = await SharedPreferences.getInstance();
  //   if (StartTime == null && EndTime == null) {
  //     print("Please Select Time Range.");
  //     Utils.showToast(
  //       message: "No days selected for leave application.",
  //       gravity: ToastGravity.BOTTOM,
  //       textColor: Colors.white,
  //       fontsize: 16,
  //     );
  //     return; // Stop the function if no days are selected
  //   }
  //   if (discription.text.isEmpty) {
  //     print("Please Select Time Range.");
  //     Utils.showToast(
  //       message: "Please Give Reason For Leave.",
  //       gravity: ToastGravity.BOTTOM,
  //       textColor: Colors.white,
  //       fontsize: 16,
  //     );
  //     return; // Stop the function if no days are selected
  //   }
  //   try {
  //     LateComingCreating(true);
  //     var response = await BaseService().postData(
  //       endPoint: ApiRoutes().CreateDayoutapllication,
  //       isTokenRequired: true,
  //       body: {
  //         "leaveType": "late coming",
  //         "startDate": "${StartTime}",
  //         "endDate": "${EndTime}",
  //         "hours": Noofhours.text,
  //         "description": discription.text,
  //       },
  //     );

  //     if (response.data['statusCode'] == 200) {
  //       Utils.showToast(
  //         message: response.data['message'],
  //         gravity: ToastGravity.CENTER,
  //         textColor: Colors.white,
  //         fontsize: 16,
  //       );
  //       Clear();
  //       GetLeaveDataList(
  //           "pending", "late coming", false); // true is load more option
  //       Get.back();

  //       LateComingCreating(false);
  //     }
  //   } on DioError catch (e) {
  //     Utils.showToast(
  //       message: "${e.message} ",
  //       gravity: ToastGravity.CENTER,
  //       textColor: Colors.white,
  //       fontsize: 16,
  //     );
  //     if (e.response?.data["statusCode"] == 401) {
  //       await TokenStorage.removeToken();
  //       await TokenStorage.removeusername();
  //       await TokenStorage.removeuserid();
  //       Get.offAll(LoginSignUp());
  //     }
  //     print(e.response);
  //     print("API Error: ${e.message} - ${e.response?.data}");
  //     LateComingCreating(false);
  //     Utils.showToast(
  //       message: "${e.message} ",
  //       gravity: ToastGravity.CENTER,
  //       textColor: Colors.white,
  //       fontsize: 16,
  //     );
  //   }
  // }

  //<================================== Get all pending leave data ================================
  RxList<LeaveListModel> AllLeaveListData = RxList<LeaveListModel>();

Future<void> GetAllLeaveDataList(String status, String Section, bool? loadmore) async {
  leaveListloading(true); // Indicating loading starts

  // Update the page number based on loadmore condition
  if (loadmore == true) {
    pendingpage.value++;
  } else {
    pendingpage.value = 1;
  }

  try {
    var CatogoryList = await AllLeaveDataListGet(status, Section, pendingpage.value);

    // Check if data is available
    if (CatogoryList.data != null) {
      if (loadmore == true) {
        AllLeaveListData.addAll(CatogoryList.data!); // Add more data
      } else {
        AllLeaveListData.clear(); // Clear old data if not loading more
        AllLeaveListData.assignAll(CatogoryList.data!); // Add new data
      }

      // Ensure the update happens after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        leaveListloading(false); // Always stop loading once done
      });
    } else {
      // Optionally handle empty data here if needed
      print("No data available");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        leaveListloading(false); // Stop loading if no data is found
      });
    }
  } catch (e) {
    print("Error fetching leave data: $e");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      leaveListloading(false); // Stop loading on error
    });
  }
}

  Future<LeaveListResponse> AllLeaveDataListGet(
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
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return LeaveListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<================================== Get all Approved leave data ================================
  RxList<LeaveListModel> GetAllApprovedleaveListloading =
      RxList<LeaveListModel>();
  RxBool GetApprovedleaveListloading = false.obs;
  Future<void> GetAllApprovedLeaveDataList(
      String status, String Secttion, bool? loadmore) async {
    GetApprovedleaveListloading(true);
    loadmore == true ? pendingpage.value++ : pendingpage.value = 1;
    try {
      var CatogoryList = await AllApprovedLeaveDataListGet(
          status, Secttion, pendingpage.value);
      if (CatogoryList.data != null) {
        loadmore == true
            ? GetAllApprovedleaveListloading.addAll(CatogoryList.data!)
            : {
                GetAllApprovedleaveListloading.clear(),
                GetAllApprovedleaveListloading.assignAll(CatogoryList.data!)
              };
        GetApprovedleaveListloading(false);
      }
      GetApprovedleaveListloading(false);
    } catch (e) {
      print("Error fetching draft jobs: $e");
      GetApprovedleaveListloading(false);
    } finally {
      GetApprovedleaveListloading(false);
      // isDraftJobListLoading.value = false;
    }
  }

  Future<LeaveListResponse> AllApprovedLeaveDataListGet(
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
      if (e.response?.data["statusCode"] == 401) {
        await TokenStorage.removeToken();
        await TokenStorage.removeusername();
        await TokenStorage.removeuserid();
        Get.offAll(const LoginSignUp());
      }
      print(e.response);
      print("API Error: ${e.message} - ${e.response?.data}");

      return LeaveListResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //< ============================ Remove Leave Application ================================
  RxBool RemoveLeaveLoading = false.obs;

  RemoveLeave(String id) async {
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
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      getpasstabController.index == 0
          ? GetLeaveDataList(
              'pending', 'leave', false) // true is load more option
          : GetLeaveDataList(
              "pending", "late coming", false); // true is load more option

      RemoveLeaveLoading(false);
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
      RemoveLeaveLoading(false);
    }
  }

  AllRemoveLeave(String id) async {
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
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      GetAllLeaveDataList("pending", "all", false); // true is load more option

      RemoveLeaveLoading(false);
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
      RemoveLeaveLoading(false);
    }
  }

  //<================================== Get  Day outList data ================================
  // RxList<GetOutApproveModel> DayOutapprovedData = RxList<GetOutApproveModel>();
  Rx<GetOutApproveModel> leaveapprovedData =
      Rx<GetOutApproveModel>(GetOutApproveModel());

  RxBool DayOutApprovedloading = false.obs;

  Future<void> GetLeaveDataDetails(
    String dayoutid,
  ) async {
    DayOutApprovedloading(true);
    try {
      var Getoutapproveddata = await GetOutApprovedataGet(dayoutid);
      if (Getoutapproveddata.data != null) {
        leaveapprovedData.value = Getoutapproveddata.data!;
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

  Clear() {
    selectedDay.clear();
    Noofhours.clear();
    selectDaterang.clear();
    discription.clear();
    selectedPurpose.clear();
    TimeRange.clear();
  }

  //<================================= Leave page Functions ========================>

  final List<String> purposes = [
    "Visiting Parents",
    "Medical Leave",
    "Emergency",
    "Family Function",
    "Vacation",
    "Festival",
    "Competitive Exam",
    "Other",
  ];

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

  String formatTime(BuildContext context, TimeOfDay? startTime) {
    if (startTime == null) return '';

    final localizations = MaterialLocalizations.of(context);

    final startFormatted =
        localizations.formatTimeOfDay(startTime, alwaysUse24HourFormat: false);

    return startFormatted;
  }

  Duration calculateDuration(TimeOfDay startTime, TimeOfDay endTime) {
    final startMinutes = startTime.hour * 60 + startTime.minute;
    final endMinutes = endTime.hour * 60 + endTime.minute;

    // If end time is before start time, assume it's on the next day
    final difference = (endMinutes - startMinutes + 1440) % 1440;

    return Duration(minutes: difference);
  }

  String formatDateRange(DateTime startDate, DateTime endDate) {
    if (startDate.isAfter(endDate)) return '';

    final noOfDays = calculateDaysDifference(startDate, endDate);

    totaldate.text = "$noOfDays";

    final formattedStartDate = DateFormat('MMM dd,yyyy').format(startDate);
    final formattedEndDate = DateFormat('MMM dd,yyyy').format(endDate);

    // Example: 'Aug 01, 2024 - Aug 24, 2024'
    if (startDate == endDate) {
      firstdateDate.text = '$formattedStartDate ';
      lastdateDate.text = '$formattedStartDate ';
      return '$formattedStartDate ';
    } else {
      firstdateDate.text = '$formattedStartDate ';
      lastdateDate.text = '$formattedEndDate ';
      return '$formattedStartDate-$formattedEndDate ';
    }
  }

  int calculateDaysDifference(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays + 1;
  }
}

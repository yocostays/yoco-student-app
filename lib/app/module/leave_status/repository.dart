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
import 'package:yoco_stay_student/app/module/leave_status/models/response/single_leave_response.dart';
import 'package:yoco_stay_student/app/module/leave_status/models/single_leave_status_model.dart';
import 'package:yoco_stay_student/app/module/onboarding/view/login_signup.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

class LeaveController extends GetxController
     {
  SharedPreferences? prefs;

  //<================= Common Tabbar =================>
  late TabController getpasstabController;


  //<================= Common Controllers & Variables =================>
  // NOTE: hold possibly-null items, but we'll always clean/normalize before using.
  var selectedDay = <DateTime?>[].obs;
  RxInt tabvalue = 1.obs;
  final TextEditingController discription = TextEditingController();

  RxInt selectedindex = 0.obs; // observed tab index

  //<================= Category =================>
  RxList<LeaveCategoryModel> Categorydata = <LeaveCategoryModel>[].obs;
  RxBool leavecategoryloading = false.obs;
  RxInt Textlength = 0.obs;

  Future<void> GetCategoryListdata(String type) async {
    leavecategoryloading(true);
    try {
      var CatogoryList = await GetCategoryList(type);
      if (CatogoryList.data != null) {
        Categorydata.assignAll(CatogoryList.data!);
      }
    } catch (e) {
      // ignore
    } finally {
      leavecategoryloading(false);
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
      _handleUnauthorized(e);
      return LeaveCategoryResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<================= Submit Leave =================>
  final TextEditingController selectDaterang = TextEditingController();
  final TextEditingController firstdateDate = TextEditingController();
  final TextEditingController firstdatetime = TextEditingController();
  final TextEditingController lastdateDate = TextEditingController();
  final TextEditingController lastdatetime = TextEditingController();
  final TextEditingController totaldate = TextEditingController();
  final TextEditingController selectedPurpose = TextEditingController();
  RxBool LeaveCreating = false.obs;

  Future<void> SubmitLeaveApplication() async {
  prefs = await SharedPreferences.getInstance();

  // Clean/sort/normalize selected days
  final days = _normalizedSelectedDays();
  if (days.isEmpty) {
    Utils.showToast(
      message: "No days selected for leave application.",
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontsize: 16,
    );
    return;
  }

  final DateTime startDate = days.first;
  final DateTime endDate = days.last;

  // Adjusted calculation: exclude last day if required
  final int daysCount = calculateDaysDifference(startDate, endDate);

  try {
    LeaveCreating(true);

    final body = {
      "categoryId": selectedPurpose.text,
      // Always send UTC to avoid backend shifting date
      "startDate": startDate.toUtc().toIso8601String(),
      "endDate": endDate.toUtc().toIso8601String(),
      "days": daysCount,
      "description": discription.text.trim(),
    };

    debugPrint("Body "
        "\n╟ categoryId: ${body["categoryId"]}"
        "\n╟ startDate: ${body["startDate"]}"
        "\n╟ endDate: ${body["endDate"]}"
        "\n╟ days: ${body["days"]}"
        "\n╟ description: ${body["description"]}");

    final response = await BaseService().postData(
      endPoint: ApiRoutes().SubmitLeaveCategory,
      isTokenRequired: true,
      body: body,
    );

    if (response.data['statusCode'] == 200) {
      // clear all controllers after success
      Clear();

      // refresh leave list
      getLeaveDataList("pending", "leave", loadMore: false);

      // navigate back
      Get.offAllNamed(AppRoute.leavepage);
    }
  } on DioException catch (e) {
    _handleUnauthorized(e);

    if (e.response?.data["statusCode"] == 400) {
      Utils.showToast(
        message: e.response?.data["message"],
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
    }
  } finally {
    LeaveCreating(false);
  }
}

  //<================= Late Coming =================>
  final TextEditingController Noofhours = TextEditingController();
  final TextEditingController TimeRange = TextEditingController();
  DateTime? StartTime;
  DateTime? EndTime;
  final TextEditingController personname = TextEditingController();
  final TextEditingController contactnumber = TextEditingController();
  final TextEditingController DayoutCetegory = TextEditingController();
  RxBool LateComingCreating = false.obs;

  Future<void> SubmitLateComingApplication() async {
    prefs = await SharedPreferences.getInstance();

    if (StartTime == null || EndTime == null) {
      Utils.showToast(
        message: "Please select a valid time range.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return;
    }

    if (discription.text.isEmpty) {
      Utils.showToast(
        message: "Please provide a reason for leave.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return;
    }

    if (Noofhours.text.isEmpty) {
      Utils.showToast(
        message: "Time is required.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return;
    }

    // you previously required a day selection; keep as-is
    if (_normalizedSelectedDays().isEmpty) {
      Utils.showToast(
        message: "Please select a day.",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );
      return;
    }

    try {
      LateComingCreating(true);

      final body = {
        "leaveType": "late coming",
        "startDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(StartTime!),
        "endDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(EndTime!),
        "hours": Noofhours.text.trim().replaceAll(" ", ""),
        "description": discription.text.trim(),
      };

      debugPrint("Submitting late coming request: $body");

      final response = await BaseService().postData(
        endPoint: ApiRoutes().CreateDayoutapllication,
        isTokenRequired: true,
        body: body,
      );

      if (response.data['statusCode'] == 200) {
        Utils.showToast(
          message: response.data['message'] ?? "Leave submitted successfully",
          gravity: ToastGravity.CENTER,
          textColor: Colors.white,
          fontsize: 16,
        );
        Clear();
        getLeaveDataList("pending", "late coming", loadMore: false);
        Get.back();
      }
    } on DioException catch (e) {
      _handleUnauthorized(e);
      final msg = e.response?.data?["message"] ?? "Something went wrong";
      Utils.showToast(
        message: msg,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontsize: 16,
      );
    } finally {
      LateComingCreating(false);
    }
  }

  //<================= Private Paged helper =================>
  static const int _pageSize = 5;

  Future<_PagedLeave> _fetchLeavePage(
      String status, String section, int page) async {
    prefs = await SharedPreferences.getInstance();
    try {
      final response = await BaseService().getData(
        endPoint:
            '${ApiRoutes().LeaveListData}?page=$page&limit=$_pageSize&status=$status&type=$section',
        isTokenRequired: true,
      );
      final data = response.data;
      final list = (data['data'] as List?)
              ?.map((e) => LeaveListModel.fromJson(e))
              .toList() ??
          <LeaveListModel>[];
      final count = data['count'] is int ? data['count'] as int : null;
      return _PagedLeave(list, count);
    } on DioException catch (e) {
      _handleUnauthorized(e);
      return _PagedLeave(<LeaveListModel>[], null);
    }
  }

  //<================= Pending (leave / late coming) =================>
  RxList<LeaveListModel> LeaveListData = <LeaveListModel>[].obs;
  RxInt pendingpage = 1.obs;
  RxBool leaveListloading = false.obs;
  RxBool isMoreLoading = false.obs;
  RxBool hasMoreData = true.obs;
  RxInt totalCount = 0.obs;

  Future<void> getLeaveDataList(String status, String section,
      {bool loadMore = false}) async {
    await _handlePagedList(
      status: status,
      section: section,
      page: pendingpage,
      list: LeaveListData,
      totalCount: totalCount,
      loading: leaveListloading,
      isMoreLoading: isMoreLoading,
      hasMoreData: hasMoreData,
      loadMore: loadMore,
    );
  }

  //<================= Rejected =================>
  RxList<LeaveListModel> RejectedLeaveListData = <LeaveListModel>[].obs;
  RxInt Rejectectedpage = 1.obs;
  RxBool RejectedleaveListloading = false.obs;
  RxBool rejectedIsMoreLoading = false.obs;
  RxBool rejectedHasMoreData = true.obs;
  RxInt rejectedTotalCount = 0.obs;

  Future<void> GetRejectedLeaveListData(
      String status, String section, bool? loadmore) async {
    await _handlePagedList(
      status: status,
      section: section,
      page: Rejectectedpage,
      list: RejectedLeaveListData,
      totalCount: rejectedTotalCount,
      loading: RejectedleaveListloading,
      isMoreLoading: rejectedIsMoreLoading,
      hasMoreData: rejectedHasMoreData,
      loadMore: loadmore == true,
    );
  }

  //<================= Approved =================>
  RxList<LeaveListModel> ApprovedLeaveListData = <LeaveListModel>[].obs;
  RxInt Approvedpagenation = 1.obs;
  RxBool ApprovedleaveListloading = false.obs;
  RxBool approvedIsMoreLoading = false.obs;
  RxBool approvedHasMoreData = true.obs;
  RxInt approvedTotalCount = 0.obs;

  Future<void> GetApprovedLeaveListData(
      String status, String section, bool loadMore) async {
    await _handlePagedList(
      status: status,
      section: section,
      page: Approvedpagenation,
      list: ApprovedLeaveListData,
      totalCount: approvedTotalCount,
      loading: ApprovedleaveListloading,
      isMoreLoading: approvedIsMoreLoading,
      hasMoreData: approvedHasMoreData,
      loadMore: loadMore,
    );
  }

  //<================= ALL (pending type=all) =================>
  RxList<LeaveListModel> AllLeaveListData = <LeaveListModel>[].obs;
  RxInt allPendingPage = 1.obs;
  RxBool allLeaveLoading = false.obs;
  RxBool allIsMoreLoading = false.obs;
  RxBool allHasMoreData = true.obs;
  RxInt allTotalCount = 0.obs;

  Future<void> GetAllLeaveDataList(
      String status, String section, bool? loadmore) async {
    await _handlePagedList(
      status: status,
      section: section,
      page: allPendingPage,
      list: AllLeaveListData,
      totalCount: allTotalCount,
      loading: allLeaveLoading,
      isMoreLoading: allIsMoreLoading,
      hasMoreData: allHasMoreData,
      loadMore: loadmore == true,
    );
  }

  //<================= ALL Approved (type=all & status=approved) =================>
  // Keeping original variable name to avoid breaking other code
  RxList<LeaveListModel> GetAllApprovedleaveListloading =
      <LeaveListModel>[].obs; // this is a LIST
  RxBool GetApprovedleaveListloading = false.obs; // this is a LOADING FLAG
  RxInt allApprovedPage = 1.obs;
  RxBool allApprovedIsMoreLoading = false.obs;
  RxBool allApprovedHasMoreData = true.obs;
  RxInt allApprovedTotalCount = 0.obs;

  Future<void> GetAllApprovedLeaveDataList(
      String status, String section, bool? loadmore) async {
    await _handlePagedList(
      status: status,
      section: section,
      page: allApprovedPage,
      list: GetAllApprovedleaveListloading,
      totalCount: allApprovedTotalCount,
      loading: GetApprovedleaveListloading,
      isMoreLoading: allApprovedIsMoreLoading,
      hasMoreData: allApprovedHasMoreData,
      loadMore: loadmore == true,
    );
  }

  //<================= Generic pagination handler (shared by all tabs) =================>
  Future<void> _handlePagedList({
  required String status,
  required String section,
  required RxInt page,
  required RxList<LeaveListModel> list,
  required RxInt totalCount,
  required RxBool loading,
  required RxBool isMoreLoading,
  required RxBool hasMoreData,
  required bool loadMore,
}) async {
  // prevent overlapping calls
  if (loading.value || isMoreLoading.value) return;

  if (loadMore) {
    if (!hasMoreData.value) return;
    isMoreLoading(true);
    page.value++;
  } else {
    loading(true);
    page.value = 1;
    hasMoreData(true);
    totalCount.value = 0;
    list.clear();
  }

  try {
    final result = await _fetchLeavePage(status, section, page.value);

    if (result.count != null && result.count! > 0) {
      totalCount.value = result.count!;
    }

    if (result.items.isNotEmpty) {
      list.addAll(result.items);

      if ((totalCount.value > 0 && list.length >= totalCount.value) ||
          result.items.length < _pageSize) {
        hasMoreData(false);
      }
    } else {
      hasMoreData(false);
    }
  } finally {
    loading(false);
    isMoreLoading(false);
  }
}

  //<================= Single Leave Status =================>
  RxList<SingleLeaveStatusModel> SingleLeaveStatusData =
      <SingleLeaveStatusModel>[].obs;
  RxBool leaveStatusdataloading = false.obs;

  Future<void> GetLeaveStatusData(String id) async {
    leaveStatusdataloading(true);
    try {
      var leaveStatus = await LeaveStatusDataGet(id);
      if (leaveStatus.data != null) {
        SingleLeaveStatusData.assignAll(leaveStatus.data!);
      }
    } catch (e) {
      // ignore
    } finally {
      leaveStatusdataloading(false);
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
      _handleUnauthorized(e);
      return SingleLeaveStatusResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<================= Day-out / Ticket details =================>
  Rx<GetOutApproveModel> leaveapprovedData =
      Rx<GetOutApproveModel>(GetOutApproveModel());
  RxBool DayOutApprovedloading = false.obs;

  Future<void> GetLeaveDataDetails(String dayoutid) async {
    DayOutApprovedloading(true);
    try {
      var Getoutapproveddata = await GetOutApprovedataGet(dayoutid);
      if (Getoutapproveddata.data != null) {
        leaveapprovedData.value = Getoutapproveddata.data!;
      }
    } catch (e) {
      // ignore
    } finally {
      DayOutApprovedloading(false);
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
      return GetOutTicketResponse(
        statusCode: 500,
        message: e.message,
        data: null,
      );
    }
  }

  //<================= Remove Leave =================>
  RxBool RemoveLeaveLoading = false.obs;

  Future<void> RemoveLeave(String id) async {
    RemoveLeaveLoading(true);
    prefs = await SharedPreferences.getInstance();

    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().leaveanddayoutRemove,
        isTokenRequired: true,
        body: {"leaveId": id},
      );
      Utils.showToast(
        message: "${response.data["message"]}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );

      if (getpasstabController.index == 0) {
        getLeaveDataList('pending', 'leave', loadMore: false);
      } else {
        getLeaveDataList('pending', 'late coming', loadMore: false);
      }

      Get.back();
    } on DioException catch (e) {
      _handleUnauthorized(e);
    } finally {
      RemoveLeaveLoading(false);
    }
  }

  Future<void> AllRemoveLeave(String id) async {
    RemoveLeaveLoading(true);
    prefs = await SharedPreferences.getInstance();

    try {
      var response = await BaseService().postData(
        endPoint: ApiRoutes().leaveanddayoutRemove,
        isTokenRequired: true,
        body: {"leaveId": id},
      );
      Utils.showToast(
        message: "${response.data["message"]}",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontsize: 16,
      );

      GetAllLeaveDataList('pending', 'all', false);
      Get.back();
    } on DioException catch (e) {
      _handleUnauthorized(e);
    } finally {
      RemoveLeaveLoading(false);
    }
  }

  //<================= Utils =================>
  void _handleUnauthorized(DioException e) async {
    if (e.response?.data is Map && e.response?.data["statusCode"] == 401) {
      await TokenStorage.removeToken();
      await TokenStorage.removeusername();
      await TokenStorage.removeuserid();
      Get.offAll(const LoginSignUp());
    }
    debugPrint("API Error: ${e.message} - ${e.response?.data}");
  }

  void Clear() {
    selectedDay.clear();
    
    
    discription.clear();
    selectedPurpose.clear();
    TimeRange.clear();
    firstdateDate.clear();
    lastdateDate.clear();
    totaldate.clear();
    StartTime = null;
    EndTime = null;
  }

  //<================= Leave page text helpers =================>
  final List<String> purposes = const [
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
    final range = '$startFormatted - $endFormatted';
    TimeRange.text = range;
    return range;
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
    final difference = (endMinutes - startMinutes + 1440) % 1440; // overnight ok
    return Duration(minutes: difference);
  }

  // === DATE HELPERS (normalized, consistent) ===

  /// Returns a date with time set to 00:00:00 (local).
  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Clean, sort, and normalize the currently selected days.
  List<DateTime> _normalizedSelectedDays() {
    final cleaned = selectedDay.whereType<DateTime>().toList();
    cleaned.sort();
    return cleaned.map(_dateOnly).toList();
  }

  /// Formats and also updates the text controllers consistently.
  /// Counts days as: max(1, end - start in days) so 15→18 = 3, 15→15 = 1.
  String formatDateRange(DateTime startDate, DateTime endDate) {
    final s = _dateOnly(startDate);
    final e = _dateOnly(endDate);
    if (s.isAfter(e)) return '';

    final noOfDays = calculateDaysDifference(s, e);
    totaldate.text = "$noOfDays";

    final formattedStartDate = DateFormat('MMM dd,yyyy').format(s);
    final formattedEndDate = DateFormat('MMM dd,yyyy').format(e);

    if (s.isAtSameMomentAs(e)) {
      firstdateDate.text = formattedStartDate;
      lastdateDate.text = formattedStartDate;
      selectDaterang.text = formattedStartDate;
      return formattedStartDate;
    } else {
      firstdateDate.text = formattedStartDate;
      lastdateDate.text = formattedEndDate;
      final range = '$formattedStartDate - $formattedEndDate';
      selectDaterang.text = range;
      return range;
    }
  }

  /// Day count policy:
  /// - Normalize both to 00:00:00.
  /// - Count = max(1, (end - start).inDays).
  ///   - 15 → 18 => 3
  ///   - 15 → 15 => 1
  int calculateDaysDifference(DateTime startDate, DateTime endDate) {
    final s = _dateOnly(startDate);
    final e = _dateOnly(endDate);
    final diff = e.difference(s).inDays;
    return diff <= 0 ? 1 : diff;
  }
}

class _PagedLeave {
  final List<LeaveListModel> items;
  final int? count;
  _PagedLeave(this.items, this.count);
}

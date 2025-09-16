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

class LeaveController extends GetxController {
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

  /// Submit Leave: now sends days (int) and hours/minutes (raw) and updates totaldate text
  Future<void> SubmitLeaveApplication() async {
    prefs = await SharedPreferences.getInstance();

    // Clean/sort/normalize selected days (date-only)
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

    // start/end using normalized dates (midnight) for day-count logic
    final DateTime startDate = days.first;
    final DateTime endDate = days.last;

    // For hours/minutes use time-aware selected days (preserve time if UI set it)
    final sortedWithTime = _sortedSelectedDays();
    DateTime startWithTime =
        sortedWithTime.isNotEmpty ? sortedWithTime.first : startDate;
    DateTime endWithTime = sortedWithTime.isNotEmpty ? sortedWithTime.last : endDate;

    // calculate day-only count (keeps your original behavior)
    final int daysCount = calculateDaysDifference(startDate, endDate);

    // calculate hours/minutes based on actual DateTime difference
    final Duration diff = endWithTime.difference(startWithTime);
    final int hoursCount = diff.inHours;
    final int minutesCount = diff.inMinutes.remainder(60);

    // update UI-friendly totaldate text
    totaldate.text = formatDurationString(startWithTime, endWithTime);

    try {
      LeaveCreating(true);

      final body = {
        "categoryId": selectedPurpose.text,
        // Always send UTC to avoid backend shifting date
        "startDate": startWithTime.toUtc().toIso8601String(),
        "endDate": endWithTime.toUtc().toIso8601String(),
        "days": daysCount,
        "hours": hoursCount,
        "minutes": minutesCount,
        "description": discription.text.trim(),
      };

      debugPrint("Body "
          "\n╟ categoryId: ${body["categoryId"]}"
          "\n╟ startDate: ${body["startDate"]}"
          "\n╟ endDate: ${body["endDate"]}"
          "\n╟ days: ${body["days"]}"
          "\n╟ hours: ${body["hours"]}"
          "\n╟ minutes: ${body["minutes"]}"
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

    // compute diff
    final Duration diff = EndTime!.difference(StartTime!);
    final int hours = diff.inHours;
    final int minutes = diff.inMinutes.remainder(60);

    try {
      LateComingCreating(true);

      final body = {
        "leaveType": "late coming",
        "startDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(StartTime!),
        "endDate": DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(EndTime!),
        // send structured numeric values rather than a string like "2 : 30"
        "hours": hours,
        "minutes": minutes,
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
 

  void Clear() {
    selectedDay.clear();
    discription.clear();
    selectedPurpose.clear();
    TimeRange.clear();
    firstdateDate.clear();
    lastdateDate.clear();
    firstdatetime.clear();
    lastdatetime.clear();
    totaldate.clear();
    Noofhours.clear();
    selectDaterang.clear();
    StartTime = null;
    EndTime = null;
  }

  //<================= Leave page text helpers =================>

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

   DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Normalize and sort selected days (date-only)
  List<DateTime> _normalizedSelectedDays() {
    final cleaned = selectedDay.whereType<DateTime>().toList();
    cleaned.sort();
    return cleaned.map(_dateOnly).toList();
  }

  /// Sort selected days with time preserved
  List<DateTime> _sortedSelectedDays() {
    final cleaned = selectedDay.whereType<DateTime>().toList();
    cleaned.sort();
    return cleaned;
  }

  /// Format duration string for UI
  String formatDurationString(DateTime start, DateTime end) {
    if (end.isBefore(start)) return "0 min";
    final diff = end.difference(start);
    final totalMinutes = diff.inMinutes;

    if (totalMinutes < 60) return "$totalMinutes min";
    if (totalMinutes < 24 * 60) {
      final hours = diff.inHours;
      final minutes = diff.inMinutes.remainder(60);
      if (minutes > 0) return "$hours hr $minutes min";
      return "$hours hr";
    } else {
      final days = totalMinutes ~/ (24 * 60);
      final hours = (totalMinutes % (24 * 60)) ~/ 60;
      final minutes = totalMinutes % 60;
      final parts = <String>[];
      if (days > 0) parts.add("$days day${days > 1 ? 's' : ''}");
      if (hours > 0) parts.add("$hours hr");
      if (minutes > 0) parts.add("$minutes min");
      return parts.join(" ");
    }
  }

  int calculateDaysDifference(DateTime start, DateTime end) {
    final diff = end.difference(start).inDays;
    return diff <= 0 ? 1 : diff;
  }

  int calculateHoursDifference(DateTime start, DateTime end) {
    final diff = end.difference(start);
    return diff.inHours % 24;
  }

  int calculateMinutesDifference(DateTime start, DateTime end) {
    final diff = end.difference(start);
    return diff.inMinutes % 60;
  }

  String formatDateRange(DateTime startDate, DateTime endDate) {
    final sorted = _sortedSelectedDays();
    final DateTime s = sorted.isNotEmpty ? sorted.first : startDate;
    final DateTime e = sorted.isNotEmpty ? sorted.last : endDate;

    totaldate.text = formatDurationString(sorted.isNotEmpty ? sorted.first : s,
        sorted.isNotEmpty ? sorted.last : e);

    final formattedStartDate = DateFormat('MMM dd, yyyy').format(s);
    final formattedEndDate = DateFormat('MMM dd, yyyy').format(e);

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

  void _handleUnauthorized(DioException e) async {
    if (e.response?.data is Map && e.response?.data["statusCode"] == 401) {
      await TokenStorage.removeToken();
      await TokenStorage.removeusername();
      await TokenStorage.removeuserid();
      Get.offAll(const LoginSignUp());
    }
    debugPrint("API Error: ${e.message} - ${e.response?.data}");
  }
}

class _PagedLeave {
  final List<LeaveListModel> items;
  final int? count;
  _PagedLeave(this.items, this.count);
}

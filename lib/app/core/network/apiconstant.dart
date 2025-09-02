class ApiRoutes {
  ApiRoutes();
  static const baseUrl = 'https://yocoapi.evdtechnology.com/api';

  String Tokencheck = "/user/profile";

  // Login section
  String Login = '/auth/sessions';

  // Forget Password
  String Forgetpassword = '/auth/request-otp';
  String SendNewPassword = '/auth/student-reset-password';

  // Logout Section
  String Logout = '/auth/logout';

  // Register api
  String hostel = "/hostel/web";
  String UserRegistration = "/user/register";

  // <------------------ Profile Section
  String GetProfile = "/user/profile";
  String EmailPhotosUpdate = "/user/profile/update";
  String VehicleUpload = "/user/sync-vehicle";
  String VehicleDelete = "/user/vehicle";
  String KycDocumentUpload = "/user/upload-kyc";

  // <------------------ Hostel details api
  String GetHostelData = "/hostel/details";

  // <=================== Home count data =======================
  String HomesetionCount = "/dashboard/user?";

  //<==================== Meals and Mess Api calls ==========================
  String GetTodayMeals = "/mess/today-menu";
  String BookMeals = "/mess/meal-booking";
  String CancleMeals = "/mess/cancel-booking";
  String CancleMealshistory = "/mess/canceled-meal-history";
  String DeleteCancelTicket = "/mess/reversibility";
  String EditTickts = "/mess/edit-meal";
  String BookedDateData = "/mess/booked/date";

  //<===================== Complaint Section api ==========================
  String ComplainType = "/complaint-category";
  String ComplainSubTypeData = "/complaint-sub-category/";
  String CreateComplaint = "/complaint/create";
  String MediaUpload = "/auth/upload-media";
  String GetComplaintedList = "/complaint/user/status";
  String GetComplaintedStatus = "/complaint/logs";
  String RemoveComplaint = "/complaint/cancel";

  //<==================== Leave/Day-out Section apis ===============================
  String GetLeaveCategory =
      "/leave-category"; // it is also use for dayout section
  String SubmitLeaveCategory = "/leave-management/apply";
  String LeaveListData = "/leave-management/app";
  String LeaveStatusData = "/leave-management/logs";
  String CreateDayoutapllication = "/leave-management/outings/request";
  String dayOutApprovedData = "/leave-management/get-gatepass-info";
  String leaveanddayoutRemove = "/leave-management/cancel";
}

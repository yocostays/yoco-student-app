import 'package:get/get.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/complaint_binding.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/view.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/view/complaint_form.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/view/complaint_page.dart';
import 'package:yoco_stay_student/app/module/emergency_support/view.dart';
import 'package:yoco_stay_student/app/module/events/event_binding.dart';
import 'package:yoco_stay_student/app/module/events/event_view.dart';
import 'package:yoco_stay_student/app/module/events/view/event_detail_page.dart';
import 'package:yoco_stay_student/app/module/events/view/event_page.dart';
import 'package:yoco_stay_student/app/module/get_pass/binding.dart';
import 'package:yoco_stay_student/app/module/get_pass/view.dart';
import 'package:yoco_stay_student/app/module/home/view/approval_status_view.dart';
import 'package:yoco_stay_student/app/module/home/view/community_view.dart';
import 'package:yoco_stay_student/app/module/home/view/hostel_detail_view.dart';
import 'package:yoco_stay_student/app/module/home/view/suggestion_view.dart';
import 'package:yoco_stay_student/app/module/leave_status/binding.dart';
import 'package:yoco_stay_student/app/module/leave_status/view.dart';
import 'package:yoco_stay_student/app/module/mess_management/bindings.dart';
import 'package:yoco_stay_student/app/module/mess_management/view.dart';
import 'package:yoco_stay_student/app/module/mess_management/view/booked_meal_status.dart';
import 'package:yoco_stay_student/app/module/mess_management/view/cancel_meal.dart';
import 'package:yoco_stay_student/app/module/mess_management/view/cancel_meal_status.dart';
import 'package:yoco_stay_student/app/module/mess_management/view/edit_page.dart';
import 'package:yoco_stay_student/app/module/mess_management/view/meal_status.dart';
import 'package:yoco_stay_student/app/module/parcel_status/view/parcel_form.dart';
import 'package:yoco_stay_student/app/module/profile/binding.dart';
import 'package:yoco_stay_student/app/module/profile/view.dart';
import 'package:yoco_stay_student/app/module/profile/view/action_assigned_page.dart';
import 'package:yoco_stay_student/app/module/profile/view/hosteldetail.dart';
import 'package:yoco_stay_student/app/module/profile/view/upload_doc.dart';
import 'package:yoco_stay_student/app/module/profile/view/vehicle_detail.dart';
import 'package:yoco_stay_student/app/module/profile/view/vihcle_detail.dart';
import 'package:yoco_stay_student/app/routes/routes.dart';
import 'package:yoco_stay_student/app/widgets/custom_bottom_navbar.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoute.home,
      page: () => const CustomBottomNavbar(),
      // binding: BindingsBuilder(() async {
      //   final sharedPreferences = await SharedPreferences.getInstance();
      //   Get.put(() => sharedPreferences, permanent: true);
      //   Get.put(() => BaseService(), permanent: true);
      //   Get.lazyPut(() => AuthController(prefs: getIt<SharedPreferences>()));
      // },
    ),
    GetPage(
      name: AppRoute.hosteldetail,
      page: () => HostelDetailView(),
      // binding: BindingsBuilder(() async {
      //   final sharedPreferences = await SharedPreferences.getInstance();
      //   Get.put(() => sharedPreferences, permanent: true);
      //   Get.put(() => BaseService(), permanent: true);
      //   Get.lazyPut(() => AuthController(prefs: getIt<SharedPreferences>()));
      // },
    ),
    GetPage(
      title: "profile Detail",
      name: AppRoute.profiledtail,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      title: "Hostal Detail",
      name: AppRoute.hostalDetail,
      page: () => HostalDetail(
        hostaldata: true,
      ),
      binding: ProfileBinding(),
    ),
    GetPage(
      title: "Family Detail",
      name: AppRoute.femilyDetail,
      page: () => HostalDetail(
        hostaldata: false,
      ),
      binding: ProfileBinding(),
    ),
    GetPage(
      title: "UPLOAD KYC DOCUMENT",
      name: AppRoute.Documentpage,
      page: () => const DocumentPage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      title: "indisciplinary",
      name: AppRoute.profileindisciplinary,
      page: () => const ProfileActionAndAssigned(
        title: "INDISCIPLINARY ACTION",
      ),
      binding: ProfileBinding(),
    ),
    GetPage(
      title: "INVENTORYASSIGNED",
      name: AppRoute.profileinventory,
      page: () => const ProfileActionAndAssigned(
        title: "INVENTORY ASSIGNED",
      ),
      binding: ProfileBinding(),
    ),
    GetPage(
      title: "AddedVhicleDetail",
      name: AppRoute.addedvehicledata,
      page: () => const VehicleDetailData(),
      binding: ProfileBinding(),
    ),
    GetPage(
      title: "VhicleDetail",
      name: AppRoute.vihcledetail,
      page: () => const VihcleDetailPage(),
      binding: ProfileBinding(),
    ),

    // event section
    GetPage(
      title: "eventhome",
      name: AppRoute.eventhome,
      page: () => const EventStatusPage(),
      binding: EventBinding(),
    ),
    GetPage(
      title: "eventdetail",
      name: AppRoute.eventdetailpage,
      page: () => const EventDetailsPage(),
      binding: EventBinding(),
    ),
    GetPage(
      title: "event2detail",
      name: AppRoute.eventpage2nd,
      page: () => const EventPageDetail(),
      binding: EventBinding(),
    ),

    // Complaint Managment
    GetPage(
      title: 'Compliant-page',
      name: AppRoute.complainmanagment,
      page: () => const ComplaintManagmentpage(),
      binding: CompliantBinding(),
    ),

    GetPage(
      title: "Compliant-Listpage",
      name: AppRoute.complaintListpage,
      page: () => const ComplaintSelectPage(),
      binding: EventBinding(),
    ),

    GetPage(
      title: "Compliant-form",
      name: AppRoute.complaintForm,
      page: () => const CompliantFromPage(),
      binding: EventBinding(),
    ),

    GetPage(
      title: "approval-status",
      name: AppRoute.approvalstatus,
      page: () => const ApprovalStatusPage(),
      binding: EventBinding(),
    ),
    GetPage(
      title: "community",
      name: AppRoute.community,
      page: () => const CommunityScreen(),
      binding: EventBinding(),
    ),
    GetPage(
      title: "suggestion",
      name: AppRoute.suggestion,
      page: () => const SuggestionPage(),
      binding: EventBinding(),
    ),

    //Parcel managment
    GetPage(
      title: "Parcel-form",
      name: AppRoute.parcelform,
      page: () => DeliveryBoyPage(),
      binding: EventBinding(),
    ),

    // Leave managment and late Coming
    GetPage(
      title: "Leave-page",
      name: AppRoute.leavepage,
      page: () =>  LeaveStatus(
        leave: true,
      ),
      binding: LeaveBinding(),
    ),
    GetPage(
      title: "late-page",
      name: AppRoute.latepage,
      page: () =>  LeaveStatus(
        leave: false,
      ),
      binding: LeaveBinding(),
    ),

    // Get pass
    GetPage(
      title: "Get-pass",
      name: AppRoute.daynightout,
      page: () => const GetPassPages(),
      binding: GetPassBindings(),
    ),

    // Emergency section
    GetPage(
      title: "Emergency-page",
      name: AppRoute.Emergencytabpage,
      page: () => const EmergencySupportPge(),
      binding: LeaveBinding(),
    ),

    // Approval Status
    GetPage(
        title: "Approval Status",
        name: AppRoute.ApprovalStatus,
        page: () => const ApprovalStatusPage(),
        binding: LeaveBinding()),

    //Mess managment section
    GetPage(
        title: "Mess Managment Page",
        name: AppRoute.messmanagmentpage,
        page: () => const MessManagmentPage()),
    GetPage(
        title: "Cancel ticket list",
        name: AppRoute.Canceltickets,
        page: () => const CancelMealStatus(),
        binding: MessBinding()),
    GetPage(
        title: "Booked ticket list",
        name: AppRoute.Bookedtickets,
        page: () => const BookedMealStatus(),
        binding: MessBinding()),

    GetPage(
        title: "Edit Ticket Page",
        name: AppRoute.EditTicketsPage,
        page: () => const EditMealScreen(),
        binding: MessBinding()),
    GetPage(
        title: "Tab Meal Page",
        name: AppRoute.MealStatusTab,
        page: () => const MealStatus(),
        binding: MessBinding()),
    GetPage(
        title: "Mess Meal Cancel Page",
        name: AppRoute.MessPageCancel,
        page: () => const CancelMealManagment(),
        binding: MessBinding()),
  ];
}

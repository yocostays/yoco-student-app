import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/home/view/Notification_view.dart';
import 'package:yoco_stay_student/app/module/my_payment/views/transactions_page.dart';
import 'package:yoco_stay_student/app/widgets/custom_button.dart';
import 'package:yoco_stay_student/app/widgets/custum_app_bar.dart';
import 'package:yoco_stay_student/app/widgets/stackbodysection.dart';

class RentBilingPage extends StatefulWidget {
  const RentBilingPage({super.key});

  @override
  State<RentBilingPage> createState() => _RentBilingPageState();
}

class _RentBilingPageState extends State<RentBilingPage> {
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedMonth = DateTime.now();
  DateTime _selectedMonth = DateTime.now();

  void _nextFourMonths() {
    setState(() {
      // Move 4 months forward, but not past the current year
      if (_focusedMonth.month <= 12) {
        _focusedMonth =
            DateTime(_focusedMonth.year, _focusedMonth.month + 4, 1);
      }
    });
  }

  void _previousFourMonths() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 4, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "RENT BILLING", trailingwidget: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Container(
            width: 31.w,
            height: 31.h,
            decoration: BoxDecoration(
              color: AppColor.belliconbackround,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: InkWell(
              onTap: () {
                Get.to(const NotificationView());
              },
              child: const Icon(
                CupertinoIcons.bell,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ]),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: stackcontainer(
          // customheight: 600.h,
          writedata: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.only(
                    left: 2.w,
                    right: 4.w,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "HOSTEL RENT",
                            style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                              color: AppColor.grey3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.y().format(_focusedDay),
                            style: AppTextTheme.textTheme.displayLarge
                                ?.copyWith(
                                    color: AppColor.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: _previousFourMonths,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(4, (index) {
                                DateTime date = DateTime(_focusedMonth.year,
                                    _focusedMonth.month + index, 1);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedMonth = date;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: _selectedMonth.month ==
                                                    date.month &&
                                                _selectedMonth.year == date.year
                                            ? AppColor.primary
                                            : Colors.transparent,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(10))),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          DateFormat.MMM().format(date),
                                          style: AppTextTheme
                                              .textTheme.displayLarge
                                              ?.copyWith(
                                                  color: _selectedMonth.month ==
                                                              date.month &&
                                                          _selectedMonth.year ==
                                                              date.year
                                                      ? AppColor.textwhite
                                                      : AppColor.primary,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: _nextFourMonths,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 268.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "FEB RENT DUES",
                                style:
                                    AppTextTheme.textTheme.bodySmall?.copyWith(
                                  color: AppColor.textwhite,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height:
                                10.h, // Adjust this for your desired spacing
                          ),
                          Divider(
                            height: 1.h,
                            color: AppColor.textwhite,
                          ),
                          SizedBox(
                            height:
                                10.h, // Adjust this for your desired spacing
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hostel Rent",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "₹ 5000",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mess Fee",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "₹ 5000",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "WiFi Fee",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "₹ 5000",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Electricity Bill",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "₹ 5000",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Divider(
                                height: 1.h,
                                color: AppColor.textwhite,
                              ),
                              Divider(
                                height: 1.h,
                                color: AppColor.textwhite,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total: ",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "₹ 5000",
                                    style: AppTextTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppColor.textwhite,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Divider(
                                height: 1.h,
                                color: AppColor.textwhite,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                // color: Colors.amber,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      leading: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.white,
                        child: Radio(
                          value: 1,
                          groupValue:
                              null, // Adjust this value based on your logic
                          onChanged: (value) {},
                          activeColor: AppColor.grey3,
                        ),
                        // Icon(
                        //   Icons.check,
                        //   color: Colors.white,
                        //   size: 16,
                        // ),
                      ),
                      title: Text(
                        "Total Outstanding",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.textblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        "₹16,000",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.textblack,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      leading: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.white,
                        child: Radio(
                          value: 1,
                          groupValue:
                              null, // Adjust this value based on your logic
                          onChanged: (value) {},
                          activeColor: AppColor.grey3,
                        ),
                        // Icon(
                        //   Icons.check,
                        //   color: Colors.white,
                        //   size: 16,
                        // ),
                      ),
                      title: Text(
                        "Yearly Rent",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.textblack,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        "(Due date on 31st February)",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.textblack,
                            fontSize: 9,
                            fontWeight: FontWeight.w700),
                      ),
                      trailing: Text(
                        "₹16,000",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.textblack,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      leading: CircleAvatar(
                        radius: 9,
                        backgroundColor: Colors.white,
                        child: Radio(
                          value: 1,
                          groupValue:
                              null, // Adjust this value based on your logic
                          onChanged: (value) {},
                          activeColor: AppColor.grey3,
                        ),
                        // Icon(
                        //   Icons.check,
                        //   color: Colors.white,
                        //   size: 16,
                        // ),
                      ),
                      title: Text(
                        "Enter Other Amount",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.textblack,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                      trailing: Text(
                        "₹16,000",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColor.textblack,
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: AppColor.primary,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        title: Text(
                          "Total Amount: ₹16,000",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                  color: AppColor.textblack,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                        ),
                        trailing: CustomButton(
                          height: 33.h,
                          width: 81.w,
                          ontap: () {
                            Get.to(() => const TransactionPage());
                          },
                          Title: 'Pay Now',
                          fontWeight: FontWeight.normal,
                          Textsize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Container(
//                 decoration: BoxDecoration(
//                     color: AppColor.white,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(10.r),
//                       bottomRight: Radius.circular(10.r),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColor.black.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ]),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                         leading: CircleAvatar(
//                           radius: 9,
//                           backgroundColor: Colors.white,
//                           child: Radio(
//                             value: 1,
//                             groupValue:
//                                 null, // Adjust this value based on your logic
//                             onChanged: (value) {},
//                             activeColor: AppColor.grey3,
//                           ),
//                           // Icon(
//                           //   Icons.check,
//                           //   color: Colors.white,
//                           //   size: 16,
//                           // ),
//                         ),
//                         title: Text(
//                           "Total Outstanding",
//                           style: Theme.of(context)
//                               .textTheme
//                               .displayLarge
//                               ?.copyWith(
//                                   color: AppColor.textblack,
//                                   fontWeight: FontWeight.w500),
//                         ),
//                         trailing: Text(
//                           "₹16,000",
//                           style: Theme.of(context)
//                               .textTheme
//                               .displayLarge
//                               ?.copyWith(
//                                   color: AppColor.textblack,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Divider(
//                         color: AppColor.primary,
//                         thickness: 2,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                         title: Text(
//                           "Total Outstanding: ₹16,000",
//                           style: Theme.of(context)
//                               .textTheme
//                               .displayLarge
//                               ?.copyWith(
//                                   color: AppColor.textblack,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                         ),
//                         trailing: CustomButton(
//                           height: 33.h,
//                           width: 81.w,
//                           ontap: () {},
//                           Title: 'Pay Now',
//                           fontWeight: FontWeight.normal,
//                           Textsize: 15,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

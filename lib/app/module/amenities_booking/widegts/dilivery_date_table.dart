import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class Diliverydatetable extends StatelessWidget {
  const Diliverydatetable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;
    // double w = MediaQuery.of(context).size.width;
    return DataTable(
      headingTextStyle: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: AppColor.textprimary, fontWeight: FontWeight.w700),
      dataTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColor.textprimary,
          fontSize: 12.r,
          fontWeight: FontWeight.w700),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      border: TableBorder.all(
          color: AppColor.primary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      columns: [
        DataColumn(
            label: Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Booking Date & Time: 22nd Feb, 2024 | 07:30 AM',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColor.textprimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
        )),
      ],
      rows: [
        DataRow(cells: [
          DataCell(FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Delivery Date Time: 23rd Feb, 2024 | 10:00 AM',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.textprimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.r, // Responsive font size
                  ),
            ),
          )
              // Flexible(
              //   child: FittedBox(
              //     fit: BoxFit.scaleDown,
              //     child: Text(
              //       'Delivery Date Time: 23rd Feb, 2024 | 10:00 AM',
              //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //           color: AppColor.textprimary,
              //           fontSize: 14,
              //           fontWeight: FontWeight.w700),
              //     ),
              //   ),
              // ),

              //   Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       child: FittedBox(
              //         fit: BoxFit.scaleDown,
              //         child: Text(
              //           'Delivery Date Time: 23rd Feb, 2024 | 10:00 AM',
              //           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //               color: AppColor.textprimary,
              //               fontSize: 13.5,
              //               fontWeight: FontWeight.w700),
              //         ),
              //       ),
              //     ),

              //     Expanded(
              //       child: FittedBox(
              //         fit: BoxFit.fitWidth,
              //         child: Text(
              //           ' 23rd Feb, 2024 | 10:00 AM',
              //           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              //               color: AppColor.textprimary,
              //               fontSize: 13.5,
              //               fontWeight: FontWeight.w700),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
              ),
        ]),
      ],
    );
  }
}

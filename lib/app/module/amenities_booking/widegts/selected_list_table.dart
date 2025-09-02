import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class Listofselectedtable extends StatelessWidget {
  const Listofselectedtable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Adjust padding for responsiveness
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DataTable(
        headingTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.textprimary,
              fontWeight: FontWeight.w700,
              fontSize: 14.r, // Responsive font size
            ),
        dataTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.textprimary,
              fontSize: 12.r, // Responsive font size
              fontWeight: FontWeight.w700,
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r), // Responsive border radius
        ),
        border: TableBorder.all(
          color: AppColor.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r), // Responsive border radius
            topRight: Radius.circular(20.r),
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        columns: [
          DataColumn(
            label: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'Sr.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontSize: 12.r,
                      fontWeight: FontWeight.w700,
                      // fontSize: 14, // Responsive font size
                    ),
              ),
            ),
          ),
          DataColumn(
            label: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'Type of Cloth',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.r,
                      // fontSize: 14, // Responsive font size
                    ),
              ),
            ),
          ),
          DataColumn(
            label: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'Quantity',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.r,
                      // fontSize: 14, // Responsive font size
                    ),
              ),
            ),
          ),
        ],
        rows: [
          DataRow(cells: [
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '1',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Shirt/T-Shirt',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '4',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
          ]),
          DataRow(cells: [
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '1',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Shirt/T-Shirt',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '4',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
          ]),
          DataRow(cells: [
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '1',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Shirt/T-Shirt',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '4',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
          ]),
          DataRow(cells: [
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '1',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Shirt/T-Shirt',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '4',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
          ]),
          DataRow(cells: [
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '1',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Shirt/T-Shirt',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
            DataCell(FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '4',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textprimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.r, // Responsive font size
                    ),
              ),
            )),
          ]),
          DataRow(cells: [
            DataCell(SizedBox(
              width: 20.w,
              child: const Text(''),
            )),
            DataCell(
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Total Clothing',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.textprimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.r, // Responsive font size
                      ),
                ),
              ),
            ),
            DataCell(
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '3',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.textprimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.r, // Responsive font size
                      ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

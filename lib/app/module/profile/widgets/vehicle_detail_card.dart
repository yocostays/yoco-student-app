import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class VehicleDetailCard extends StatelessWidget {
  final String Vehicletype;
  final String? Vehiclenumber;
  final String? VehicleModel;
  final Function()? ontap;
  const VehicleDetailCard({
    super.key,
    required this.Vehicletype,
    this.Vehiclenumber,
    this.VehicleModel,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 55.h,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xFFdfd7ec),
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Vehicletype,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColor.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                  Vehicletype == "Bicycle"
                      ? Container()
                      : Text(
                          Vehiclenumber ?? "CG-12 3765",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: AppColor.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                        )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80),
              child: Text(
                VehicleModel ?? "",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColor.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
            ),
            InkWell(
              onTap: ontap,
              child: const Icon(
                Icons.delete,
                color: AppColor.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}

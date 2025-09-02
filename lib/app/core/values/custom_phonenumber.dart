// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class CustomPhoneNumberField extends StatelessWidget {
  final TextEditingController phoneController;
  final FormFieldValidator<String>? validator;
  final int? maxnumber;

  const CustomPhoneNumberField({
    super.key,
    required this.phoneController,
    this.validator,
    this.maxnumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w), // Adjusted padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r), // Adjusted border radius
            // border: Border.all(color: AppColor.grey3),
          ),
          child: Row(
            children: [
              Expanded(
                child: InternationalPhoneNumberInput(
                  maxLength: maxnumber ?? 12,
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                    showFlags: true,
                    useEmoji: true,
                    setSelectorButtonAsPrefixIcon: true,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle:
                      AppTextTheme.textTheme.displayLarge?.copyWith(
                    fontSize: 16,
                    color: AppColor.textblack,
                    fontWeight: FontWeight.w700,
                  ),
                  initialValue: PhoneNumber(isoCode: 'IN'),
                  textFieldController: phoneController,
                  textStyle: AppTextTheme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w700, color: AppColor.textblack),
                  formatInput: false,
                  keyboardType: TextInputType.number,
                  inputDecoration: InputDecoration(
                    hintText: 'Mobile Number',
                    hintStyle: AppTextTheme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w700, color: AppColor.textblack),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(color: AppColor.grey3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(color: AppColor.primary),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(color: AppColor.primary),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.r),
                      borderSide: const BorderSide(color: AppColor.primary),
                    ),
                  ),
                  validator: validator,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}

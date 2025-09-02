// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/profile/widgets/alertTextFiled.dart';

class ProfileAlertDialog extends StatelessWidget {
  final String name;
  final String contactNumber;
  final String emailId;
  final String roomNumber;
  final String image;

  const ProfileAlertDialog({
    super.key,
    required this.name,
    required this.contactNumber,
    required this.emailId,
    required this.roomNumber,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          // border: Border.all(
          //   color: Colors.blue,
          //   width: 2,
          // ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                image.isEmpty
                    ? CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColor.textprimary.withOpacity(0.2),
                      )
                    : CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColor.textprimary.withOpacity(0.2),
                        backgroundImage: NetworkImage(image),
                      ),
                SizedBox(height: 20),
                ProfileInfoRow(label: 'NAME', value: name),
                SizedBox(height: 10),
                ProfileInfoRow(label: 'CONTACT NUMBER', value: contactNumber),
                SizedBox(height: 10),
                ProfileInfoRow(label: 'EMAIL ID', value: emailId),
                SizedBox(height: 10),
                ProfileInfoRow(
                    label: 'ROOM NUMBER/BED NUMBER', value: roomNumber),
              ],
            ),
            Positioned(
                top: -15,
                right: -15,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 20,
                    color: AppColor.textprimary.withOpacity(0.2),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ))
          ],
        ),
      ),
    );
  }
}

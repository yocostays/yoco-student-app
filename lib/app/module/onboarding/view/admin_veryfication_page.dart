import 'package:flutter/material.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';

class AdminVerifyPage extends StatelessWidget {
  const AdminVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightpurple2,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Replace this with your custom image
                Image.asset(
                  'assets/images/Varification_Logo.png', // Add your image asset here
                  height: 200,
                ),
                const SizedBox(height: 24),
                Text(
                  'Waiting For Verification Admin',
                  style: AppTextTheme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: AppColor.textblack),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: AppTextTheme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.normal, color: AppColor.textblack),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

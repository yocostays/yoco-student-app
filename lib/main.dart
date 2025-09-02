import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:yoco_stay_student/app/core/env.dart';
import 'package:yoco_stay_student/app/core/theme/texttheme.dart';
import 'package:yoco_stay_student/app/module/onboarding/view.dart';
import 'package:yoco_stay_student/app/routes/pages.dart';
import 'package:yoco_stay_student/app/globals.dart' as globals;
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  await GetStorage.init();

  runApp(const MyApp());
  initOneSignal();
}

void initOneSignal() async {
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("ea14c0ed-7f03-4223-9cd4-dc43141da2ed");

  OneSignal.Notifications.requestPermission(true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = constraints.maxWidth;
        globals.globalwidth = constraints.maxWidth;
        globals.globalheight = constraints.maxHeight;
        final screenHeight = constraints.maxHeight;
        return ScreenUtilInit(
          designSize: Size(screenWidth, screenHeight),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            screenwidth = MediaQuery.of(context).size.width;
            return Builder(
              builder: (context) {
                // Ensure ScreenUtil is initialized with context
                ScreenUtil.init(context);
                return GetMaterialApp(
                  theme: ThemeData(
                    // useMaterial3: false,
                    textTheme: AppTextTheme.textTheme,
                  ),
                  // theme: AppTheme.lightTheme,
                  // darkTheme: AppTheme.darkTheme,
                  themeMode: ThemeMode.light,
                  debugShowCheckedModeBanner: false,
                  title: 'Yoco Stay',
                  // home: DashboardPage(),

                  home: const SplashScreen(),
                  getPages: AppPages.pages,
                );
              },
            );
          },
        );
      },
    );
  }
}

import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/qr_code.dart';
import 'package:yoco_stay_student/app/utils/utils.dart';

/////////////  Controller  /////////////////////////////////

class DialogController extends GetxController {
  var isEntrySelected = true.obs;

  void toggleEntry(bool value) => isEntrySelected.value = value;

  /// Handle scanned result
  void onScanResult(BarcodeCapture capture) {
    final String? scannedValue = capture.barcodes.first.rawValue;
    debugPrint("Barcode scanned: $scannedValue");

    final Uint8List? image = capture.image;
    debugPrint("Barcode image: $image");

    final Object? raw = capture.raw;
    debugPrint("Barcode raw: $raw");

    final List<Barcode> barcodes = capture.barcodes;
    debugPrint("Barcode list: $barcodes");
  }
}

///////////////////  UI ////////////////////////////////

class DialogPage extends StatelessWidget {
  const DialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DialogController());

    return Dialog(
      backgroundColor: AppColor.primary,
      surfaceTintColor: AppColor.primary,
      child: SizedBox(
        width: Get.width * 0.9,
        height: Get.height * 0.5,
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Positioned(
              right: 10.w,
              top: 10.h,
              child: IconButton(
                icon: const Icon(Icons.close, color: AppColor.grey3),
                onPressed: () => Get.back(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Date
                  Row(
                    children: [
                      const Icon(FeatherIcons.calendar, color: AppColor.primary),
                      SizedBox(width: 10.w),
                      Text(
                        Utils.formatDatebynd(DateTime.now()),
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Time
                  Row(
                    children: [
                      const Icon(FeatherIcons.clock, color: AppColor.primary),
                      SizedBox(width: 10.w),
                      Text(
                        Utils.formatTimePass(DateTime.now()),
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const EventQrcode(),
                  const SizedBox(height: 20),
                  // Switch (Entry / Exit)
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Entry',
                            style: TextStyle(
                                color: AppColor.textblack, fontSize: 16)),
                        Switch.adaptive(
                          value: controller.isEntrySelected.value,
                          onChanged: controller.toggleEntry,
                          activeColor: AppColor.primary,
                          activeTrackColor: AppColor.primary.withOpacity(0.3),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: AppColor.primary,
                        ),
                        const Text('Exit',
                            style: TextStyle(
                                color: AppColor.textblack, fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // QR Scanner button
                  InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AiBarcodeScanner(
                            hideGalleryButton: false,
                            controller: MobileScannerController(
                              detectionSpeed: DetectionSpeed.noDuplicates,
                            ),
                            onDispose: () => debugPrint("Scanner disposed"),
                            onDetect: controller.onScanResult,
                            validator: (value) {
                              if (value.barcodes.isEmpty) return false;
                              return value.barcodes.first.rawValue
                                      ?.contains('flutter.dev') ??
                                  false;
                            },
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_enhance,
                            color: AppColor.primary, size: 24.h),
                        SizedBox(width: 10.w),
                        const Text("Click to Scan QR")
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

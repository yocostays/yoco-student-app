import 'dart:ui';
import 'dart:typed_data';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/events/event_widgets/qr_code.dart';

import '../utils/utils.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  bool isEntrySelected = true; // Track the state of the switch

  @override
  Widget build(BuildContext context) {
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
                icon: const Icon(
                  Icons.close,
                  color: AppColor.grey3,
                ),
                onPressed: () {
                  Get.back();
                  // Navigator.pop(context); // Close the dialog
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const Icon(
                        FeatherIcons.calendar,
                        color: AppColor.primary,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        Utils.formatDatebynd(DateTime.now()),
                        style: GoogleFonts.getFont(
                          "Quicksand",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        FeatherIcons.clock,
                        color: AppColor.primary,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        Utils.formatTimePass(DateTime.now()),
                        style: GoogleFonts.getFont(
                          "Quicksand",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const EventQrcode(),
                  // Container(
                  //   height: 150.h,
                  //   width: 150.h,
                  //   color: Colors.white,
                  //   child: Image.asset(
                  //     'assets/icons/qricon.png',
                  //     fit: BoxFit.cover, // Your QR code image path
                  //     width: 100,
                  //     height: 100,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Entry',
                        style:
                            TextStyle(color: AppColor.textblack, fontSize: 16),
                      ),
                      Switch(
                        value: isEntrySelected,
                        onChanged: (bool newValue) {
                          setState(() {
                            isEntrySelected = newValue; // Update switch state
                          });
                        },
                        activeThumbColor: AppColor.white,
                        activeTrackColor:
                            AppColor.primary, // Track color when switch is ON
                        inactiveThumbColor:
                            Colors.white, // Thumb color when switch is OFF
                        inactiveTrackColor:
                            AppColor.primary, // Track color when switch is OFF
                      ),
                      const Text(
                        'Exit',
                        style:
                            TextStyle(color: AppColor.textblack, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                      child: InkWell(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AiBarcodeScanner(
                            onDispose: () {
                              /// This is called when the barcode scanner is disposed.
                              /// You can write your own logic here.
                              debugPrint("Barcode scanner disposed!");
                            },
                            hideGalleryButton: false,
                            controller: MobileScannerController(
                              detectionSpeed: DetectionSpeed.noDuplicates,
                            ),
                            onDetect: (BarcodeCapture capture) {
                              /// The row string scanned barcode value
                              final String? scannedValue =
                                  capture.barcodes.first.rawValue;
                              debugPrint("Barcode scanned: $scannedValue");

                              /// The `Uint8List` image is only available if `returnImage` is set to `true`.
                              final Uint8List? image = capture.image;
                              debugPrint("Barcode image: $image");

                              /// row data of the barcode
                              final Object? raw = capture.raw;
                              debugPrint("Barcode raw: $raw");

                              /// List of scanned barcodes if any
                              final List<Barcode> barcodes = capture.barcodes;
                              debugPrint("Barcode list: $barcodes");
                            },
                            validator: (value) {
                              if (value.barcodes.isEmpty) {
                                return false;
                              }
                              if (!(value.barcodes.first.rawValue
                                      ?.contains('flutter.dev') ??
                                  false)) {
                                return false;
                              }
                              return true;
                            },
                          ),
                        ),
                      );
                      // var result = await Get.to(QRViewPage());
                      // if (result != null) {
                      //   // Handle the scanned QR code result
                      //   print('Scanned QR code: $result');
                      // }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_enhance,
                          color: AppColor.primary,
                          size: 24.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Text("Click to Scan QR")
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

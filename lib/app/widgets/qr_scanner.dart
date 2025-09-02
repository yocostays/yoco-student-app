import 'package:flutter/material.dart';

import 'package:yoco_stay_student/app/core/values/colors.dart';

class QRViewPage extends StatefulWidget {
  const QRViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewPageState();
}

class _QRViewPageState extends State<QRViewPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.withOpacity(0.4),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     Get.back(result: scanData.code); // Go back and pass the scanned code
  //     // Optionally, handle the scanned data here
  //   });
  // }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }
}

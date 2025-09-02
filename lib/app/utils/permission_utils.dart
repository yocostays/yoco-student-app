import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.isPhysicalDevice && androidInfo.version.sdkInt > 32) {
        // Android 12+ uses different permission for accessing photos
        PermissionStatus permission = await Permission.photos.status;
        if (permission.isGranted) {
          return true;
        } else {
          final status = await Permission.photos.request();
          return status.isGranted;
        }
      } else {
        PermissionStatus permission = await Permission.storage.status;
        if (permission.isGranted) {
          return true;
        } else {
          final status = await Permission.storage.request();
          return status.isGranted;
        }
      }
    } else {
      PermissionStatus permission = await Permission.storage.status;
      if (permission.isGranted) {
        return true;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }
  }

  // request extranal storage permission
  static Future<bool> requestExtStoragePermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.isPhysicalDevice && androidInfo.version.sdkInt > 32) {
        // Android 12+ uses different permission for accessing photos
        PermissionStatus permission = await Permission.storage.status;
        if (permission.isGranted) {
          return true;
        } else {
          final status = await Permission.storage.request();
          return status.isGranted;
        }
      } else {
        PermissionStatus permission = await Permission.storage.status;
        if (permission.isGranted) {
          return true;
        } else {
          final status = await Permission.storage.request();
          return status.isGranted;
        }
      }
    } else {
      PermissionStatus permission = await Permission.storage.status;
      if (permission.isGranted) {
        return true;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }
  }

  // Camera permission
  static Future<bool> requestCameraPermission() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.isPhysicalDevice && androidInfo.version.sdkInt > 32) {
        // Android 12+ uses different permission for accessing the camera
        PermissionStatus permission = await Permission.camera.status;
        if (permission.isGranted) {
          return true;
        } else {
          final status = await Permission.camera.request();
          return status.isGranted;
        }
      } else {
        PermissionStatus permission = await Permission.camera.status;
        if (permission.isGranted) {
          return true;
        } else {
          final status = await Permission.camera.request();
          return status.isGranted;
        }
      }
    } else {
      PermissionStatus permission = await Permission.camera.status;
      if (permission.isGranted) {
        return true;
      } else {
        final status = await Permission.camera.request();
        return status.isGranted;
      }
    }
  }
}

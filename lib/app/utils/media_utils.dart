// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MediaUtils {
  // pick image from gallery
  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<File?> takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Pick a PDF file from the gallery or file system
  static Future<File?> pickPdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        return File(result.files.single.path!);
      }
    } catch (e) {
      print("Error picking file: $e");
    }
    return null;
  }

  // download PDF file in local to share
  Future<String> downloadPDF(String url, String fileName) async {
    var response = await http.get(Uri.parse(url));
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var file = File('${documentsDirectory.path}/$fileName');
    file.writeAsBytesSync(response.bodyBytes);
    return file.path;
  }

  static Future<String?> fileToBase64(File file, {bool isfile = false}) async {
    try {
      Uint8List bytes = await file.readAsBytes();
      String base64Encode = base64.encode(bytes);
      return isfile == false
          ? "data:image/png;base64,$base64Encode"
          : "data:application/pdf;base64,$base64Encode";
    } catch (e) {
      print("Error converting file to base64: $e");
      return null;
    }
  }

  static Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

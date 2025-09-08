import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:record/record.dart';
import 'package:yoco_stay_student/app/core/values/colors.dart';
import 'package:yoco_stay_student/app/module/complaint_managment/controller/controller.dart';

class AttachFile extends StatefulWidget {
  const AttachFile({
    super.key,
  });

  @override
  State<AttachFile> createState() => _AttachFileState();
}

class _AttachFileState extends State<AttachFile> {
  late Timer _timer;
  int _secondsElapsed = 0;
  final CompliantController compliantController =
      Get.put(CompliantController());
  final AudioRecorder audioRecorder = AudioRecorder();
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (compliantController.isRecording == true) {
        setState(() {
          _secondsElapsed++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() async {
    setState(() async {
      _secondsElapsed = 0;
      String? filePath = await audioRecorder.stop();
      setState(() {
        compliantController.isRecording = false;
        compliantController.recordingPath = filePath;
        compliantController.recordingStatus(true);
      });
        });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void dispose() {
    _stopRecordingIfActive();
    _timer.cancel();
    super.dispose();
  }

  void _stopRecordingIfActive() async {
    if (compliantController.isRecording) {
      await audioRecorder.stop();
      setState(() {
        compliantController.isRecording = false;
        compliantController.recordingPath = null;
        compliantController.recordingStatus(false);
      });
    }
  }

  var audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(
                    "Feel free to attach any relevant materials to support your complaint.",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColor.textblack, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              if (compliantController.recordingPath == null)
                GestureDetector(
                  // onLongPressStart: (_) async {
                  //   var audioPlayer = AudioPlayer();
                  //   await audioPlayer.play(AssetSource("startRecoding.mp3"));
                  //   audioPlayer.stop();
                  //   if (await audioRecorder.hasPermission()) {
                  //     final Directory appDocumentsDir =
                  //         await getApplicationDocumentsDirectory();
                  //     final String filePath =
                  //         p.join(appDocumentsDir.path, "${DateTime.now()}.mp3");
                  //     await audioRecorder.start(
                  //       const RecordConfig(),
                  //       path: filePath,
                  //     );
                  //     setState(() {
                  //       compliantController.isRecording = true;
                  //       compliantController.recordingPath = null;
                  //       compliantController.recordingStatus(false);
                  //     });
                  //   }
                  // },
                  // onLongPressMoveUpdate: (details) {
                  //   // Detect swipe to cancel
                  //   // if (details.globalPosition.dx < startPosition.dx - 50) {
                  //   //   setState(() {
                  //   //     cancelRecording = true;
                  //   //   });
                  //   // }
                  // },
                  // onLongPressEnd: (_) async {
                  //   if (compliantController.isRecording) {
                  //     var audioPlayer = AudioPlayer();
                  //     await audioPlayer.play(AssetSource("endRecoding.mp3"));
                  //     audioPlayer.stop();
                  //     String? filePath = await audioRecorder.stop();
                  //     if (filePath != null) {
                  //       setState(() {
                  //         compliantController.isRecording = false;
                  //         compliantController.recordingPath = filePath;
                  //         compliantController.recordingStatus(true);
                  //       });
                  //     }
                  //   }
                  // },
                  onTap: () async {
                    print("jjshbdd: ");
                    if (compliantController.isRecording) {
                      print("jjshbdd: 2");

                      await audioPlayer.play(AssetSource("endRecoding.mp3"));
                      audioPlayer.stop();
                      String? filePath = await audioRecorder.stop();
                      setState(() {
                        compliantController.isRecording = false;
                        compliantController.recordingPath = filePath;
                        compliantController.recordingStatus(true);
                      });
                                        } else {
                      await audioPlayer.play(AssetSource("startRecoding.mp3"));
                      audioPlayer.stop();
                      if (await audioRecorder.hasPermission()) {
                        final Directory appDocumentsDir =
                            await getApplicationDocumentsDirectory();
                        final String filePath = p.join(
                            appDocumentsDir.path, "${DateTime.now()}.mp3");
                        await audioRecorder.start(
                          const RecordConfig(),
                          path: filePath,
                        );
                        setState(() {
                          compliantController.isRecording = true;
                          compliantController.recordingPath = null;
                          compliantController.recordingStatus(false);
                        });
                        startTimer();
                        _showAttachFileDialog(context);
                      }
                    }
                  },
                  child: Icon(
                    compliantController.isRecording
                        ? CupertinoIcons.stop_fill
                        : CupertinoIcons.mic_fill,
                    color: AppColor.primary,
                  ),
                ),
              SizedBox(
                width: 5.w,
              ),
              InkWell(
                onTap: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(
                                Icons.photo,
                                color: AppColor.primary,
                              ),
                              title: Text(
                                'Gallery',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: AppColor.textblack,
                                        fontWeight: FontWeight.w700),
                              ),
                              onTap: () async {
                                Navigator.pop(context);

                                final ImagePicker imagePicker = ImagePicker();
                                final XFile? selectedImage = await imagePicker
                                    .pickImage(source: ImageSource.gallery);
                                // final List<XFile>? selectedImages =
                                //     await imagePicker.pickMultiImage();
                                if (selectedImage != null) {
                                  setState(() {
                                    compliantController.imageFileList.clear();
                                    compliantController.imageFileList
                                        .add(selectedImage);
                                  });
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.camera_alt_outlined,
                                color: AppColor.primary,
                              ),
                              title: Text(
                                'Camera',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: AppColor.textblack,
                                        fontWeight: FontWeight.w700),
                              ),
                              onTap: () async {
                                Navigator.pop(context);
                                final ImagePicker imagePicker = ImagePicker();
                                final XFile? selectedImages = await imagePicker
                                    .pickImage(source: ImageSource.camera);
                                if (selectedImages != null) {
                                  setState(() {
                                    compliantController.imageFileList
                                        .add(selectedImages);
                                  });
                                }
                              },
                            ),
                          ],
                        );
                      });
                },
                child: const Icon(
                  CupertinoIcons.photo,
                  color: AppColor.primary,
                ),
              )
            ],
          ),
        ),
        // compliantController.isRecording == true
        //     ?

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Container(
        //     height: 50,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       border: Border.all(color: AppColor.primary),
        //       borderRadius: BorderRadius.circular(20),
        //       gradient: LinearGradient(
        //         colors: [
        //           AppColor.white, // Start color of the gradient
        //           Color(0xFFFFF4D8), // End color of the gradient
        //         ],
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //       ),
        //     ),
        //     padding: EdgeInsets.symmetric(horizontal: 20),
        //     child: Row(
        //       children: [
        //         Text(formatTime(_secondsElapsed),
        //             style: TextStyle(fontSize: 16)),
        //         Text("Recording time"),
        //         InkWell(
        //           onTap: () {
        //             stopTimer();
        //           },
        //           child: Container(
        //             height: 30.h,
        //             width: 30.h,
        //             decoration: BoxDecoration(
        //               border: Border.all(color: AppColor.primary),
        //               borderRadius: BorderRadius.circular(20),
        //             ),
        //             child: Icon(
        //               CupertinoIcons.stop_fill,
        //               color: AppColor.primary,
        //             ),
        //           ),
        //         ),
        //         Text("")
        //       ],
        //     ),
        //   ),
        // ),

        // : Container(),
        if (compliantController.recordingPath != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.primary),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                // leading: InkWell(
                //   onTap: () async {
                //     var audioPlayer = AudioPlayer();
                //     if (compliantController.isPlaying) {
                //       audioPlayer.stop();
                //       setState(() {
                //         compliantController.isPlaying = false;
                //       });
                //     } else {
                //       // await audioPlayer.play(
                //       //     DeviceFileSource(compliantController.recordingPath!));
                //       final tempDir = await getTemporaryDirectory();
                //       final tempFile =
                //           File('${tempDir.path}/test_recording.mp3');
                //       await tempFile.writeAsBytes(
                //           await File(compliantController.recordingPath!)
                //               .readAsBytes());
                //       await audioPlayer.play(
                //           DeviceFileSource(compliantController.recordingPath!));
                //       audioPlayer.stop();
                //       setState(() {
                //         compliantController.isPlaying = true;
                //       });
                //     }
                //   },
                //   child: Icon(
                //     compliantController.isPlaying == true
                //         ? Icons.pause_circle_filled
                //         : Icons.play_circle_fill_rounded,
                //     size: 40,
                //   ),
                // ),

                title: Text(
                  "Record.mp3",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.textblack, fontWeight: FontWeight.w700),
                ),
                trailing: InkWell(
                  onTap: () {
                    setState(() {
                      compliantController.recordingPath = null;
                    });
                  },
                  child: const Icon(
                    Icons.delete,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ),
          ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }

  void _showAttachFileDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              // Start the timer if it's not already running
              _startTimer(setState);

              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      // border: Border.all(color: AppColor.primary),
                      // borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          AppColor.white, // Start color of the gradient
                          Color(0xFFFFF4D8), // End color of the gradient
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatTime(_secondsElapsed),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Text("Recording...."),
                        InkWell(
                          onTap: () {
                            stopTimer();
                            Navigator.of(context).pop(); // Close dialog on stop
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primary),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              CupertinoIcons.stop_fill,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  // Timer function to update seconds elapsed
  void _startTimer(void Function(void Function()) setState) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }
}

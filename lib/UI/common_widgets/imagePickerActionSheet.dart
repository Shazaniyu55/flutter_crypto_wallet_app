
// ignore_for_file: file_names, depend_on_referenced_packages, use_build_context_synchronously

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

import '../../Constants/colors.dart';
import '../../services/utilServices.dart';
class ImagePickerActionSheet {
  Function? onCompletion;
  bool? isFromSingleTv;

  ImagePickerActionSheet({this.onCompletion, this.isFromSingleTv});

  File? _image;
  final picker = ImagePicker();

  showImagePickerActionSheet(context) {
    showModalBottomSheet(
        backgroundColor: primaryBackgroundColor.value,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Container(
                        color: Colors.grey,
                        height: 6,
                        width: 60,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Choose',
                      style: TextStyle(color: inputFieldTextColor.value, fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      leading: const Icon(Icons.photo_outlined, size: 30.0, color: Colors.grey),
                      title: Text(
                        'Gallery',
                        style: TextStyle(color: inputFieldTextColor.value, fontSize: 22.0),
                      ),
                      onTap: () {
                        imgFromGallery(context);
                        Navigator.of(context).pop();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.photo_camera_outlined, size: 30.0, color: Colors.grey),
                    title: Text(
                      'Camera',
                      style: TextStyle(color: inputFieldTextColor.value, fontSize: 22.0),
                    ),
                    onTap: () {
                      imgFromCamera(context);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(height: 100.0)
              ],
            ),
          );
        });
  }
  Future<bool> checkCameraPermissionsIOS(BuildContext context) async {
    if (Platform.isIOS) {
      await Permission.camera.request();
      await Permission.photos.request();
      await Permission.microphone.request();

      if (await Permission.camera.isPermanentlyDenied ||
          await Permission.photos.isPermanentlyDenied) {
        showGeneralDialog(
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  title: const Text('Gallery'),
                  content: const Text('Please provide camera and photos permission to continue'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text('Open Settings'),
                      onPressed: () {
                        Navigator.pop(context);
                        openAppSettings();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return const Text('data');
          },
        );
      }
    }

    return await Permission.camera.isGranted && await Permission.photos.isGranted;
  }

  Future<bool> checkCameraPermissions(BuildContext context) async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (Platform.isIOS) {
      await Permission.camera.request();
      await Permission.photos.request();
      await Permission.microphone.request();
    }
    if (Platform.isAndroid && await Permission.camera.isGranted && (androidInfo.version.sdkInt <= 32 ?await Permission.storage.isGranted :await Permission.photos.isGranted)) {
    } else if ((Platform.isIOS &&
        await Permission.camera.isGranted &&
        (androidInfo.version.sdkInt <= 32 ?await Permission.storage.isGranted :await Permission.photos.isGranted) &&
        (await Permission.photos.isGranted || await Permission.photos.isLimited))) {
    } else if (await Permission.camera.isPermanentlyDenied || (androidInfo.version.sdkInt <= 32 ?await Permission.storage.isPermanentlyDenied :await Permission.photos.isPermanentlyDenied)) {
      showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(16.0)),
                title: const Text('Gallery'),
                content: const Text('Please provide camera and storage permission to continue'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text('Open'),
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('data');
        },
      );
    } else {
      if (Platform.isIOS) {
        showGeneralDialog(
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(16.0)),
                  title: const Text('Gallery'),
                  content: const Text('Please provide camera and storage permission to continue'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text('Open'),
                      onPressed: () {
                        Navigator.pop(context);
                        openAppSettings();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return const Text('data');
          },
        );
      } else {
        await Permission.camera.request();

        if (androidInfo.version.sdkInt <= 32) {
          await Permission.storage.request();
        }  else {
          await Permission.photos.request();
        }

      }
    }
    if (Platform.isIOS && (await Permission.photos.isDenied || await Permission.photos.isPermanentlyDenied)) {
      return await Permission.camera.isGranted && await Permission.storage.isGranted && await Permission.photos.isGranted;
    } else {
      if (androidInfo.version.sdkInt <= 32) {
        return await Permission.camera.isGranted && await Permission.storage.isGranted;
      }  else {
        return await Permission.camera.isGranted && await Permission.photos.isGranted;
      }
    }
  }

  Future<bool> showMicrophonePermissionDialogue(BuildContext context) async {
    if (Platform.isIOS) {
      await Permission.microphone.request();
    }
    if ((Platform.isIOS && await Permission.microphone.isGranted)) {
    } else if (Platform.isIOS) {
      showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(16.0)),
                title: const Text('Microphone'),
                content: const Text('Please provide microphone permission to continue'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text('Open'),
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('data');
        },
      );
    }
    return Platform.isIOS ? await Permission.microphone.isGranted : true;
  }

  Future<bool> showLimitedPhotosPermissionDialogue(BuildContext context) async {
    if (Platform.isIOS) {
      await Permission.photos.request();
    }
    if (Platform.isIOS && await Permission.photos.isLimited) {
      showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(16.0)),
                title: const Text('Limited Access'),
                content: const Text('Please allow access to all files'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: const Text('Open'),
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const Text('data');
        },
      );
    }
    return await Permission.photos.isGranted;
  }

  Future imgFromCamera(BuildContext context) async {
    if(Platform.isAndroid) {

      if (await checkCameraPermissions(context)) {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          File rotatedImage = await FlutterExifRotation.rotateImage(path: pickedFile.path);
          _image = rotatedImage;

          onCompletion!(_image);

          // _image = File(pickedFile.path);
        } else {
          onCompletion!('No file selected.');
        }
      }
    } else {
      if (await checkCameraPermissionsIOS(context)) {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          File rotatedImage = await FlutterExifRotation.rotateImage(path: pickedFile.path);
          _image = rotatedImage;

          onCompletion!(_image);

          // _image = File(pickedFile.path);
        } else {
          onCompletion!('No file selected.');
        }
      }
    }

  }

  Future imgFromGallery(context) async {
    if(Platform.isAndroid) {
      if (await checkCameraPermissions(context)) {
        final ImagePicker picker = ImagePicker();

        var pickedFile = await picker.pickImage(source: ImageSource.gallery);

        List <String> allowedExtentions = ['.apng', '.avif', '.gif', '.jpg', '.jpeg', '.jfif', '.pjpeg', '.pjp', '.png', '.svg','.webm', '.mkv', '.flv', '.vob', '.ogg', '.ogv', '.gif', '.mov', '.wmv', '.3gp', '.mp4', '.m4p', '.m4v'];

        if (pickedFile != null) {
          var ext = p.extension(pickedFile.path);
          if(allowedExtentions.contains(ext)){
            File rotatedImage = await FlutterExifRotation.rotateImage(path: pickedFile.path);
            _image = rotatedImage;

            onCompletion!(_image);
          } else {
            UtilService().showToast('$ext images are not supported',color: const Color(0xFFA90000));
            // UtilService().getDangerMsg(
            //     "${ext} images are not supported", context, StyledToastPosition.center);
            pickedFile = null;
            _image= null;

            //this.onCompletion!('No file selected.');
          }

        } else {
          onCompletion!('No file selected.');
        }
      }
    } else {
      if (await checkCameraPermissionsIOS(context)) {
        final ImagePicker picker = ImagePicker();

        var pickedFile = await picker.pickImage(source: ImageSource.gallery);

        List <String> allowedExtentions = ['.apng', '.avif', '.gif', '.jpg', '.jpeg', '.jfif', '.pjpeg', '.pjp', '.png', '.svg','.webm', '.mkv', '.flv', '.vob', '.ogg', '.ogv', '.gif', '.mov', '.wmv', '.3gp', '.mp4', '.m4p', '.m4v'];

        if (pickedFile != null) {
          var ext = p.extension(pickedFile.path);
          if(allowedExtentions.contains(ext)){
            File rotatedImage = await FlutterExifRotation.rotateImage(path: pickedFile.path);
            _image = rotatedImage;

            onCompletion!(_image);
          } else {
            UtilService().showToast('$ext images are not supported',color: const Color(0xFFA90000));
            // UtilService().getDangerMsg(
            //     "${ext} images are not supported", context, StyledToastPosition.center);
            pickedFile = null;
            _image= null;

            //this.onCompletion!('No file selected.');
          }

        } else {
          onCompletion!('No file selected.');
        }
      }
    }



  }

}

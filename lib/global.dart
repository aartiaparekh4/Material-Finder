// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String baseUrl = "https://android.hopequre.com";
String encrypKeyVlaue = 'aHZZUzhZdkhtcml5SlBHdXpVUUNRdz09LGhaWVI4UHNCbzQzbVNwc0NSSHFYOWtianhDQUYzVmFFQ2hQYUxYcDdZYzA9';
String? location;
File? imageFile;

void hideLoader(BuildContext context) {
  Navigator.pop(context);
}

showOnlyLoaderDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Center(child: CircularProgressIndicator(color: Color(0XFF9470dc))),
      );
    },
  );
}

Future<File> imageService(ImageSource imageSource) async {
  try {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage = await picker.pickImage(source: imageSource);
    if (selectedImage != null) {
      imageFile = File(selectedImage.path);
    } else {
      imageFile = null;
    }

    imageFile;
  } catch (e) {
    print("Exception - main.dart - imageService() ${e.toString()}");
  }
  return imageFile!;
}

showSnackBar(String title, String text, {Duration? duration}) {
  return SnackBar(
    dismissDirection: DismissDirection.horizontal,
    duration: duration ?? const Duration(seconds: 5),
    content: Text(text),
  );
}

Future<DateTime?> selectDateFrom(BuildContext context) async {
  try {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null) {
      print(picked);
      return DateTime.parse(picked.toString());
    } else {
      picked = null;
    }
    return DateTime.parse(picked.toString());
  } catch (e) {
    print('Exception - Society_detailsController.dart - selectDateFrom(): ${e.toString()}');
    return null;
  }
}

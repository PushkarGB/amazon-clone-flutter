import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBar(String text) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(text)),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    FilePickerResult? files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (files != null && files.files.isNotEmpty) {
      images = files.files.map((file) {
        return File(file.path!);
      }).toList();
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return images;
}

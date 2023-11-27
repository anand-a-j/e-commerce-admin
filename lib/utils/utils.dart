import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String message, {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      backgroundColor: isError ? Colors.red : Colors.green,
      dismissDirection: DismissDirection.horizontal,
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> images = [];

  try {
    var file = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (file != null && file.files.isNotEmpty) {
      for (int i = 0; i < file.files.length; i++) {
        images.add(File(file.files[i].path!));
      }
    } else {
      debugPrint("No images selected.");
    }
  } catch (e) {
    debugPrint("pickImage function error => ${e.toString()}");
  }
  return images;
}

String dateConvert(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  return formattedDate;
}

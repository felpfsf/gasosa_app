import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

Future<String> getImagePath(String fileName) async {
  final appDir = await getApplicationDocumentsDirectory();
  return path.join(appDir.path, fileName);
}

Future<File?> getImageFile(String? fileName) async {
  if (fileName == null || fileName.isEmpty) return null;

  final filePath = await getImagePath(fileName);
  final file = File(filePath);

  if (await file.exists()) {
    print('Image file exists - $file');
    return file;
  }

  print('Image file does not exist - $file');

  return null;
}

import 'dart:developer';
import 'dart:io';

import 'package:gasosa_app/core/errors/failure.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class NoteImageSaver {
  static Future<String?> save(File image) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      if (!await appDir.exists()) {
        await appDir.create(recursive: true);
      }
      final fileName = path.basename(image.path);
      final savedPath = '${appDir.path}/$fileName';
      final savedImage = await image.copy(savedPath);
      return savedImage.path;
    } on Exception catch (e) {
      log('❌ Erro ao salvar imagem localmente: $e');
      throw ImageSaveFailure('Erro ao salvar imagem localmente');
    }
  }
}

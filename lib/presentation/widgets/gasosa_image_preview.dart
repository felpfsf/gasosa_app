import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_theme.dart';

class GasosaImagePreview extends StatelessWidget {
  final String imageUrl;
  final String? heroTag;

  const GasosaImagePreview({super.key, required this.imageUrl, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              child:
                  heroTag != null
                      ? Hero(tag: heroTag!, child: Image.file(File(imageUrl), fit: BoxFit.contain))
                      : Image.network(imageUrl, fit: BoxFit.contain),
            ),
          ),
          Positioned(
            top: 80,
            right: 24,
            child: CircleAvatar(
              backgroundColor: AppColors.surface,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, size: 16, color: AppColors.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
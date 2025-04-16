import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class GasosaPhotoPicker extends StatefulWidget {
  final String label;
  final Function(File? file) onFileSelected;
  final File? initialFile;

  const GasosaPhotoPicker({
    super.key,
    required this.label,
    required this.onFileSelected,
    this.initialFile,
  });

  @override
  State<GasosaPhotoPicker> createState() => _GasosaPhotoPickerState();
}

class _GasosaPhotoPickerState extends State<GasosaPhotoPicker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _image = widget.initialFile;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        widget.onFileSelected(_image!);
      });
    }
  }

  void _removeImage() {
    setState(() => _image = null);
    widget.onFileSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        AppSpacing.gap8,
        _image == null
            ? Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    label: const Text('Tirar foto'),
                    icon: const Icon(Icons.camera),
                  ),
                ),
                AppSpacing.gap8,
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    label: const Text('Galeria'),
                    icon: const Icon(Icons.photo_library),
                  ),
                ),
              ],
            )
            : Stack(
              children: [
                ClipRRect(
                  borderRadius: AppSpacing.radiusMd,
                  child: Image.file(
                    _image!,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: AppColors.background,
                    child: IconButton(
                      onPressed: _removeImage,
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ],
            ),
      ],
    );
  }
}

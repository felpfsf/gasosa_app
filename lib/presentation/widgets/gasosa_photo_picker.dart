import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:image_picker/image_picker.dart';

class GasosaPhotoPicker extends StatefulWidget {
  final String label;
  final Function(File? file) onFileSelected;
  final File? initialFile;

  const GasosaPhotoPicker({super.key, required this.label, required this.onFileSelected, this.initialFile});

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
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() => _image = file);
      widget.onFileSelected(file);
    }
  }

  void _removeImage() {
    setState(() => _image = null);
    widget.onFileSelected(null);
  }

  void _previewImage(BuildContext context) {
    if (_image == null) return;

    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: AppColors.background,
            insetPadding: EdgeInsets.zero,
            child: InteractiveViewer(child: Image.file(_image!, fit: BoxFit.contain)),
          ),
    );
  }

  Widget _buildActions() {
    return Row(
      spacing: AppSpacing.md,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _pickImage(ImageSource.camera),
            label: const Text('Câmera'),
            icon: const Icon(Icons.camera),
          ),
        ),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _pickImage(ImageSource.gallery),
            label: const Text('Galeria'),
            icon: const Icon(Icons.photo_library),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return GestureDetector(
      onTap: () => _previewImage(context),
      child: GasosaCard(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            ClipRect(child: Image.file(_image!, width: double.infinity, height: 180, fit: BoxFit.cover)),
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: AppColors.surface,
                child: IconButton(
                  onPressed: _removeImage,
                  icon: const Icon(Icons.close, size: 16, color: AppColors.text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        Text(widget.label, style: AppTypography.textSmBold),
        _image == null ? _buildActions() : _buildImagePreview(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';

class GasosaAvatar extends StatelessWidget {
  final String? photoUrl;
  final double radius;

  const GasosaAvatar({super.key, this.photoUrl, this.radius = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.5)],
        ),
      ),

      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xs),
        child: CircleAvatar(
          backgroundColor: AppColors.text,
          backgroundImage:
              photoUrl != null && photoUrl!.isNotEmpty
                  ? NetworkImage(photoUrl!)
                  : AssetImage('assets/images/avatar_placeholder.png') as ImageProvider,
          radius: radius,
        ),
      ),
    );
  }
}

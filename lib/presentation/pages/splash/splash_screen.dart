import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      // if (!context.mounted) return;

      // context.go('/login');
    });

    return Scaffold(
      body: Center(
        child: Text('Gasosa App Splash', style: AppTypography.textLgRegular),
      ),
    );
  }
}

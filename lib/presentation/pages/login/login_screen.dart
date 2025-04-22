import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'app-logo',
                  child: Image.asset('assets/images/app_logo.png'),
                ),
                const SizedBox(height: 24),
                Text(
                  'Bem vindo ao Gasosa App',
                  style: AppTypography.titleLg,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text('Login', style: AppTypography.textMdRegular),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

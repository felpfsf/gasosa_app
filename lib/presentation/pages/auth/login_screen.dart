import 'package:flutter/material.dart';
import 'package:gasosa_app/presentation/pages/auth/widgets/auth_google_button.dart';
import 'package:gasosa_app/presentation/pages/auth/widgets/login_form.dart';
import 'package:gasosa_app/presentation/widgets/logo_hero.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                LogoHero(size: 200),
                AppSpacing.gap24,
                Text('Entrar no Gasosa', style: AppTypography.titleLg),
                AppSpacing.gap24,
                AuthGoogleButton(),
                AppSpacing.gap16,
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text('ou'),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                AppSpacing.gap16,
                LoginForm(onSubmit: (email, password) => {}),
                AppSpacing.gap16,
                GestureDetector(
                  onTap: () => context.push('/auth/register'),
                  child: Text(
                    'Não tem conta? Cadastre-se',
                    style: AppTypography.textMdBold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

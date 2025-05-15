import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_state.dart';
import 'package:gasosa_app/presentation/pages/auth/widgets/auth_google_button.dart';
import 'package:gasosa_app/presentation/pages/auth/widgets/login_form.dart';
import 'package:gasosa_app/presentation/widgets/custom_loader.dart';
import 'package:gasosa_app/presentation/widgets/logo_hero.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            Messages.showSuccess(context, 'Login realizado com sucesso!');
            context.go('/dashboard');
          },
          error: (message) {
            Messages.showError(context, 'Erro ao fazer login');
            log('❌ Erro ao fazer login: $message');
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
        return Scaffold(
          body: SafeArea(
            child:
                isLoading
                    ? CustomLoader<AuthCubit, AuthState>(size: 48, isOverlay: true, selector: (_) => true)
                    : Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            LogoHero(size: 200),
                            AppSpacing.gap24,
                            Text('Entrar no Gasosa', style: AppTypography.titleLg),
                            AppSpacing.gap24,
                            AuthGoogleButton(onPressed: () => context.read<AuthCubit>().signInWithGoogle()),
                            AppSpacing.gap16,
                            Row(
                              children: [
                                Expanded(child: Divider(thickness: 1)),
                                Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: const Text('ou')),
                                Expanded(child: Divider(thickness: 1)),
                              ],
                            ),
                            AppSpacing.gap16,
                            LoginForm(),
                            AppSpacing.gap16,
                            GestureDetector(
                              onTap: () => context.push('/auth/register'),
                              child: Text(
                                'Não tem conta? Cadastre-se',
                                style: AppTypography.textMdBold.copyWith(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
          ),
        );
      },
    );
  }
}

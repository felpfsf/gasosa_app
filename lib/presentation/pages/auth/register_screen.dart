import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_state.dart';
import 'package:gasosa_app/presentation/pages/auth/widgets/register_form.dart';
import 'package:gasosa_app/presentation/widgets/custom_loader.dart';
import 'package:gasosa_app/presentation/widgets/index.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            Messages.showSuccess(context, 'Usuário criado com sucesso!');
            context.go('/vehicles');
          },
          error: (message) => Messages.showError(context, message),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cadastrar'),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LogoHero(size: 200),
                    AppSpacing.gap24,
                    Text('Crie sua conta', style: AppTypography.titleLg),
                    AppSpacing.gap24,
                    RegisterForm(),
                    CustomLoader<AuthCubit, AuthState>(
                      selector:
                          (state) => state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          ),
                      isOverlay: true,
                      size: 48,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_button.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    String username = authState.maybeWhen(
      authenticated: (user) {
        print(user.email);
        return user.name;
      },
      orElse: () => 'Usuário',
    );

    void logout() {
      context.read<AuthCubit>().logout();
      context.go('/auth/login');
    }

    return Scaffold(
      appBar: AppBar(title: Text('Bem vindo, $username'), centerTitle: true),
      body: Center(
        child: Column(
          spacing: 24,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Dashboard', style: AppTypography.titleLg),
            GasosaButton(label: 'Sair', onPressed: () => logout(),),
          ],
        ),
      ),
    );
  }
}

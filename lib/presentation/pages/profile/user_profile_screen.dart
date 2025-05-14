import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_appbar.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_avatar.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GasosaAppbar(
        title: 'Perfil',
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.lg,
            children: [
              Center(child: GasosaAvatar(photoUrl: user.photoUrl)),
              Center(child: Text(user.name, style: AppTypography.textMdRegular)),
              Center(child: Text(user.email, style: AppTypography.textMdRegular)),
              Divider(height: AppSpacing.md),
              ListTile(
                leading: Icon(Icons.logout),
                onTap: () => {context.read<AuthCubit>().logout()},
                title: Text('Logout', style: AppTypography.textSmRegular),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

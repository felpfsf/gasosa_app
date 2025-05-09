import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_state.dart';
import 'package:gasosa_app/presentation/pages/refuel/widgets/manage_refuel_form.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_appbar.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class ManageRefuelScreen extends StatelessWidget {
  final String vehicleId;

  const ManageRefuelScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RefuelCubit, RefuelState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) {
            context.pop();
            Messages.showSuccess(context, 'Abastecimento registrado com sucesso!');
          },
          error: (message) => Messages.showError(context, 'Erro ao registrar abastecimento'),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: GasosaAppbar(
            title: 'Registrar abastecimento',
            showBackButton: true,
            centerTitle: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: ManagerRefuelForm(vehicleId: vehicleId),
              ),
            ),
          ),
        );
      },
    );
  }
}

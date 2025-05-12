import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/core/helpers/crud_action_messages.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_state.dart';
import 'package:gasosa_app/presentation/pages/refuel/widgets/manage_refuel_form.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_appbar.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class ManageRefuelScreen extends StatelessWidget {
  final String vehicleId;
  final Refuel? refuel;

  const ManageRefuelScreen({super.key, required this.vehicleId, this.refuel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RefuelCubit, RefuelState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (action) {
            context.pop();
            final verb = crudActionSuccessVerb(action);
            Messages.showSuccess(context, 'Abastecimento $verb com sucesso!');
            log('✅ Abastecimento $verb com sucesso!');
          },
          error: (action, error) {
            final verb = crudActionErrorVerb(action);
            Messages.showError(context, 'Erro ao $verb abastecimento');
            log('❌ Erro ao $verb abastecimento: $error');
          },
        );
      },
      builder: (context, state) {
        final appBarTitle = refuel != null ? 'Editar abastecimento' : 'Registrar abastecimento';
        return Scaffold(
          appBar: GasosaAppbar(
            title: appBarTitle,
            showBackButton: true,
            centerTitle: true,
            leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: ManagerRefuelForm(vehicleId: vehicleId, initialRefuel: refuel),
              ),
            ),
          ),
        );
      },
    );
  }
}

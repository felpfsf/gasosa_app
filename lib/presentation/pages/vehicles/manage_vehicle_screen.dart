import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_state.dart';
import 'package:gasosa_app/presentation/pages/vehicles/widgets/manage_vehicle_form.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_appbar.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class ManageVehicleScreen extends StatelessWidget {
  final Vehicle? vehicle;

  const ManageVehicleScreen({super.key, this.vehicle});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehicleCubit, VehicleState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            Messages.showError(context, 'Erro ao  ${vehicle != null ? 'editar' : 'criar'}  veículo');
            log('❌ Erro ao ${vehicle != null ? 'editar' : 'criar'} veículo: $message');
          },
          success: (_) {
            context.pop();
            Messages.showSuccess(context, 'Veículo ${vehicle != null ? 'editado' : 'criado'} com sucesso!');
            log('✅ Veículo ${vehicle != null ? 'editado' : 'criado'} com sucesso!');
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: GasosaAppbar(
            title: vehicle != null ? 'Editar Veículo' : 'Registrar Veículo',
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => context.pop()),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: ManageVehicleForm(initialVehicle: vehicle),
              ),
            ),
          ),
        );
      },
    );
  }
}

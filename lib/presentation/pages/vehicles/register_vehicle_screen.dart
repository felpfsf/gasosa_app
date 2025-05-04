import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_state.dart';
import 'package:gasosa_app/presentation/pages/vehicles/widgets/register_vehicle_form.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class RegisterVehicleScreen extends StatelessWidget {
  const RegisterVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehicleCubit, VehicleState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            Messages.showError(context, 'Erro ao criar veículo');
            log('❌ Erro ao criar veículo: $message');
          },
          success: (_) {
            context.pop();
            Messages.showSuccess(context, 'Veículo criado com sucesso!');
            log('✅ Veículo criado com sucesso!');
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Registrar Veículo'),
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => context.pop()),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: RegisterVehicleForm(),
              ),
            ),
          ),
        );
      },
    );
  }
}

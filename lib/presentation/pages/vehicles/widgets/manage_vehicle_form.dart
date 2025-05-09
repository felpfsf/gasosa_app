import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/core/extensions/fuel_type_extensions.dart';
import 'package:gasosa_app/core/helpers/auth_helper.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_button.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_dropdown_field.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_form_field.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:validatorless/validatorless.dart';

class ManageVehicleForm extends StatefulWidget {
  final Vehicle? initialVehicle;

  const ManageVehicleForm({super.key, this.initialVehicle});

  @override
  State<ManageVehicleForm> createState() => _ManageVehicleFormState();
}

class _ManageVehicleFormState extends State<ManageVehicleForm> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleNameEC = TextEditingController();
  final _plateEC = TextEditingController();
  FuelType? _selectedFuelType;

  @override
  void initState() {
    if (widget.initialVehicle != null) {
      _vehicleNameEC.text = widget.initialVehicle!.name;
      _plateEC.text = widget.initialVehicle?.plate ?? '';
      _selectedFuelType = widget.initialVehicle!.fuelType;
    }
    super.initState();
  }

  @override
  void dispose() {
    _vehicleNameEC.dispose();
    _plateEC.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      Messages.showError(context, 'Preencha todos os campos corretamente');
      return;
    }

    final vehicleName = _vehicleNameEC.text;
    final plate = _plateEC.text;
    final fuelType = _selectedFuelType;

    if (fuelType == null) {
      Messages.showError(context, 'Selecione o tipo de combustível');
      return;
    }

    final userId = AuthHelper.getCurrentUserId(context);

    if (userId == null) {
      Messages.showError(context, 'Usuário não encontrado');
      return;
    }

    final isEditing = widget.initialVehicle != null;
    final vehicleId = widget.initialVehicle?.id ?? const Uuid().v4();

    final vehicle = Vehicle(
      id: vehicleId,
      name: vehicleName,
      plate: plate,
      fuelType: fuelType,
      userId: userId,
      createdAt: widget.initialVehicle?.createdAt ?? DateTime.now(),
    );

    if (isEditing) {
      context.read<VehicleCubit>().updateVehicle(vehicle);
    } else {
      context.read<VehicleCubit>().addVehicle(vehicle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: AppSpacing.lg,
        children: [
          GasosaFormField(
            label: 'Nome do veículo *',
            controller: _vehicleNameEC,
            validator: Validatorless.multiple([
              Validatorless.required('Nome do veículo é obrigatório'),
              Validatorless.min(3, 'Nome do veículo deve ter no mínimo 3 caracteres'),
            ]),
          ),
          GasosaFormField(
            label: 'Placa do veículo',
            controller: _plateEC,
            validator: Validatorless.min(3, 'Nome do veículo deve ter no mínimo 3 caracteres'),
          ),
          GasosaDropdownField<FuelType>(
            label: 'Tipo de combustível *',
            items: FuelType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.label))).toList(),
            value: _selectedFuelType,
            hint: const Text('Selecione o tipo de combustível'),
            onChanged:
                (value) => setState(() {
                  _selectedFuelType = value;
                }),
            validator: (value) {
              if (value == null) {
                return 'Selecione o tipo de combustível';
              }
              return null;
            },
          ),
          AppSpacing.gap8,
          GasosaButton(label: widget.initialVehicle != null ? 'Editar' : 'Registrar', onPressed: _onSubmit),
          GasosaButton(
            label: 'Cancelar',
            onPressed: () {
              context.pop();
            },
            backgroundColor: AppColors.text,
            textColor: AppColors.background,
          ),
        ],
      ),
    );
  }
}

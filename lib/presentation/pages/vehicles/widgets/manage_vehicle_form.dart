import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/core/extensions/fuel_type_extensions.dart';
import 'package:gasosa_app/core/helpers/auth_helper.dart';
import 'package:gasosa_app/core/helpers/dialog_helper.dart';
import 'package:gasosa_app/core/validators/vehicle_validators.dart';
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

  ({String vehicleName, String plate, FuelType fuelType, String userId})? _validateAndParseForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      Messages.showError(context, 'Preencha todos os campos corretamente');
      return null;
    }
    final vehicleName = _vehicleNameEC.text.trim();
    final plate = _plateEC.text.trim().toUpperCase();
    final fuelType = _selectedFuelType;

    if (fuelType == null) {
      Messages.showError(context, 'Selecione o tipo de combustível');
      return null;
    }

    final userId = AuthHelper.getCurrentUserId(context);

    if (userId == null) {
      Messages.showError(context, 'Usuário não encontrado');
      return null;
    }

    return (vehicleName: vehicleName, plate: plate, fuelType: fuelType, userId: userId);
  }

  Vehicle _buildVehicleFromData(({String vehicleName, String plate, FuelType fuelType, String userId}) data) {
    final isEditing = widget.initialVehicle != null;
    final vehicleId = widget.initialVehicle?.id ?? const Uuid().v4();

    return Vehicle(
      id: vehicleId,
      name: data.vehicleName,
      plate: data.plate,
      fuelType: data.fuelType,
      userId: data.userId,
      createdAt: DateTime.now(),
      updatedAt: isEditing ? DateTime.now() : null,
      updatedBy: isEditing ? data.userId : null,
    );
  }

  void _handleSubmit(Vehicle vehicle, {required bool isEditing}) {
    if (isEditing) {
      context.read<VehicleCubit>().updateVehicle(vehicle);
    } else {
      context.read<VehicleCubit>().addVehicle(vehicle);
    }
  }

  Future<void> _onSubmit() async {
    final validation = _validateAndParseForm();
    if (validation == null) return;

    final vehicle = _buildVehicleFromData(validation);

    _handleSubmit(vehicle, isEditing: widget.initialVehicle != null);
  }

  Future<void> _onDeleteVehicle() async {
    final confirmed = await showGasosaConfirmDialog(
      context: context,
      title: 'Excluir veículo ${widget.initialVehicle!.name}?',
      message: 'Essa ação apagará também todos os abastecimentos vinculados e não poderá ser desfeita.',
      confirmText: 'Excluir',
      cancelText: 'Cancelar',
    );

    if (confirmed) {
      if (!mounted) return;
      context.read<VehicleCubit>().deleteVehicle(widget.initialVehicle!);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: AppSpacing.lg,
        children: [
          GasosaFormField(label: 'Nome do veículo *', controller: _vehicleNameEC, validator: VehicleValidators.name),
          GasosaFormField(label: 'Placa do veículo', controller: _plateEC, validator: VehicleValidators.plate),
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
          if (widget.initialVehicle != null)
            GasosaButton(label: 'Apagar veículo', onPressed: _onDeleteVehicle, backgroundColor: AppColors.error),
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/core/extensions/fuel_type_extensions.dart';
import 'package:gasosa_app/core/helpers/auth_helper.dart';
import 'package:gasosa_app/core/helpers/avaliable_fuel_type_for_refuel.dart';
import 'package:gasosa_app/core/helpers/formatters.dart';
import 'package:gasosa_app/core/validators/refuel_validators.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/pages/refuel/widgets/note_image_saver.dart';
import 'package:gasosa_app/presentation/pages/refuel/widgets/refuel_data_builder.dart';
import 'package:gasosa_app/presentation/pages/refuel/widgets/refuel_fields_validator.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_checkbox.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_dropdown_field.dart';
import 'package:gasosa_app/presentation/widgets/index.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class ManagerRefuelForm extends StatefulWidget {
  final String vehicleId;
  final Refuel? initialRefuel;

  const ManagerRefuelForm({super.key, required this.vehicleId, this.initialRefuel});

  @override
  State<ManagerRefuelForm> createState() => _ManagerRefuelFormState();
}

class _ManagerRefuelFormState extends State<ManagerRefuelForm> {
  final _formKey = GlobalKey<FormState>();
  final _litersEC = TextEditingController();
  final _totalValueEC = TextEditingController();
  final _odometerEC = TextEditingController();
  final _coldStartLitersEC = TextEditingController();
  final _coldStartValueEC = TextEditingController();

  FuelType? _selectedFuelType;
  DateTime? _selectedDate = DateTime.now();
  File? _selectedNoteImage;

  bool _hasColdStart = false;

  @override
  void initState() {
    final refuel = widget.initialRefuel;
    if (refuel != null) {
      _litersEC.text = formatMaskedLiters(refuel.liters);
      _totalValueEC.text = formatMaskedCurrency(refuel.totalValue);
      _odometerEC.text = refuel.odometer.toString();
      _selectedFuelType = refuel.fuelType;
      _selectedDate = refuel.date;
      final hasColdStart = refuel.coldStartLiters != null && refuel.coldStartValue != null;
      _hasColdStart = hasColdStart;

      if (_hasColdStart) {
        _coldStartLitersEC.text = formatMaskedLiters(refuel.coldStartLiters ?? 0);
        _coldStartValueEC.text = formatMaskedCurrency(refuel.coldStartValue ?? 0);
      } else {
        _coldStartLitersEC.clear();
        _coldStartValueEC.clear();
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _litersEC.dispose();
    _totalValueEC.dispose();
    _odometerEC.dispose();
    _coldStartLitersEC.dispose();
    _coldStartValueEC.dispose();

    super.dispose();
  }

  ({
    String vehicleId,
    DateTime? date,
    FuelType fuelType,
    double liters,
    double totalValue,
    double? coldStartLiters,
    double? coldStartValue,
    double odometer,
    String userId,
  })?
  _validateAndParseForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      Messages.showError(context, 'Preencha todos os campos corretamente');
      return null;
    }

    final vehicleId = widget.vehicleId;
    final date = _selectedDate;
    final fuelType = _selectedFuelType;
    final liters = parseMaskedLiters(_litersEC.text);
    final totalValue = parseMaskedCurrency(_totalValueEC.text);
    final odometer = parseMaskedInteger(_odometerEC.text);
    final coldStartLiters = _hasColdStart ? parseMaskedLiters(_coldStartLitersEC.text) : null;
    final coldStartValue = _hasColdStart ? parseMaskedCurrency(_coldStartValueEC.text) : null;

    if (fuelType == null) {
      Messages.showError(context, 'Selecione o tipo de combustível');
      return null;
    }

    final userId = AuthHelper.getCurrentUserId(context);

    if (userId == null) {
      Messages.showError(context, 'Usuário não autenticado');
      return null;
    }

    return (
      vehicleId: vehicleId,
      date: date,
      fuelType: fuelType,
      liters: liters,
      totalValue: totalValue,
      odometer: odometer,
      userId: userId,
      coldStartLiters: coldStartLiters,
      coldStartValue: coldStartValue,
    );
  }

  void _handleSubmit(Refuel refuel, {required bool isEditing}) {
    if (isEditing) {
      context.read<RefuelCubit>().updateRefuel(refuel);
    } else {
      context.read<RefuelCubit>().addRefuel(refuel);
    }
  }

  Future<void> _onSubmit() async {
    final formData = _validateAndParseForm();

    if (formData == null) return;

    final validationErrors = RefuelFieldsValidator.validateRefuelFields(
      liters: formData.liters,
      totalValue: formData.totalValue,
      odometer: formData.odometer,
      date: formData.date,
      fuelType: formData.fuelType,
      coldStartLiters: formData.coldStartLiters,
      coldStartValue: formData.coldStartValue,
      hasColdStart: _hasColdStart,
    );

    if (validationErrors.isNotEmpty) {
      final message = 'Corrija os campos abaixo:\n${validationErrors.join('\n')}';
      Messages.showError(context, message);
      return;
    }

    final noteImageUrl = await NoteImageSaver.save(_selectedNoteImage!);

    final refuel = RefuelDataBuilder.build(
      vehicleId: formData.vehicleId,
      date: formData.date,
      fuelType: formData.fuelType,
      liters: formData.liters,
      totalValue: formData.totalValue,
      odometer: formData.odometer,
      userId: formData.userId,
      coldStartLiters: formData.coldStartLiters,
      coldStartValue: formData.coldStartValue,
      noteImageUrl: noteImageUrl,
      previous: widget.initialRefuel,
    );

    _handleSubmit(refuel, isEditing: widget.initialRefuel != null);
  }

  @override
  Widget build(BuildContext context) {
    final buttonLabel = widget.initialRefuel != null ? 'Editar' : 'Registrar';
    return Form(
      key: _formKey,
      child: Column(
        spacing: AppSpacing.lg,
        children: [
          GasosaDatePickerField(
            label: 'Data de abastecimento *',
            initialDate: _selectedDate,
            onDateSelected: (pickedDate) {
              setState(() {
                _selectedDate = pickedDate;
              });
            },
            validator: (date) => RefuelValidators.date(date),
          ),
          GasosaFormField(
            label: 'KM atual *',
            hint: 'Ex: 100.000 KM',
            controller: _odometerEC,
            keyboardType: TextInputType.number,
            inputFormatters: [integerInputFormatter],
            validator: RefuelValidators.odometer,
          ),
          GasosaFormField(
            label: 'Litros abastecidos *',
            hint: 'Ex: 40.000 L',
            controller: _litersEC,
            keyboardType: TextInputType.number,
            inputFormatters: [litersInputFormatter],
            validator: RefuelValidators.liters,
          ),
          GasosaFormField(
            label: 'Valor total *',
            hint: 'Ex: R\$ 100,00',
            controller: _totalValueEC,
            keyboardType: TextInputType.number,
            inputFormatters: [currencyInputFormatter],
            validator: RefuelValidators.totalValue,
          ),
          GasosaDropdownField<FuelType>(
            label: 'Tipo de combustível *',
            items: avaliableFuelTypeForRefuel().map((e) => DropdownMenuItem(value: e, child: Text(e.label))).toList(),
            value: _selectedFuelType,
            hint: const Text('Selecione o tipo de combustível'),
            onChanged: (fuelType) {
              setState(() {
                _selectedFuelType = fuelType;
              });
            },
            validator: (fuelType) => RefuelValidators.fuelType(fuelType),
          ),
          if (_selectedFuelType == FuelType.ethanol || _selectedFuelType == FuelType.gnv)
            GasosaCheckbox(
              title: 'Abasteceu partida a frio?',
              value: _hasColdStart,
              onChanged: (value) {
                setState(() {
                  _hasColdStart = value ?? false;
                });
              },
            ),
          if (_hasColdStart) ...[
            GasosaFormField(
              label: 'Litros abastecidos (partida a frio) *',
              hint: 'Ex: 0.5 L',
              controller: _coldStartLitersEC,
              keyboardType: TextInputType.number,
              inputFormatters: [litersInputFormatter],
              validator: RefuelValidators.liters,
            ),
            GasosaFormField(
              label: 'Valor total (partida a frio) *',
              hint: 'Ex: R\$ 3,00',
              controller: _coldStartValueEC,
              keyboardType: TextInputType.number,
              inputFormatters: [currencyInputFormatter],
              validator: RefuelValidators.totalValue,
            ),
          ],
          GasosaPhotoPicker(
            label: 'Adicionar comprovante fiscal?',
            onFileSelected: (file) {
              setState(() {
                _selectedNoteImage = file;
              });
            },
          ),
          AppSpacing.gap8,
          GasosaButton(label: buttonLabel, onPressed: _onSubmit),
          GasosaButton(
            label: 'Cancelar',
            onPressed: () => context.pop(),
            backgroundColor: AppColors.text,
            textColor: AppColors.background,
          ),
        ],
      ),
    );
  }
}

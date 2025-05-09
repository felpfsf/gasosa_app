import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/core/extensions/fuel_type_extensions.dart';
import 'package:gasosa_app/core/helpers/auth_helper.dart';
import 'package:gasosa_app/core/helpers/formatters.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_button.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_date_picker_field.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_dropdown_field.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_form_field.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:validatorless/validatorless.dart';

class ManagerRefuelForm extends StatefulWidget {
  final String vehicleId;

  const ManagerRefuelForm({super.key, required this.vehicleId});

  @override
  State<ManagerRefuelForm> createState() => _ManagerRefuelFormState();
}

class _ManagerRefuelFormState extends State<ManagerRefuelForm> {
  final _formKey = GlobalKey<FormState>();
  final _litersEC = TextEditingController();
  final _totalValueEC = TextEditingController();
  final _odometerEC = TextEditingController();
  FuelType? _selectedFuelType;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _litersEC.dispose();
    _totalValueEC.dispose();
    _odometerEC.dispose();

    super.dispose();
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      Messages.showError(context, 'Preencha todos os campos corretamente');
    }

    final liters = parseMaskedLiters(_litersEC.text);
    final totalValue = parseMaskedCurrency(_totalValueEC.text);
    final odometer = parseMaskedCurrency(_odometerEC.text);
    final date = _selectedDate;
    final fuelType = _selectedFuelType;

    final validationErrors = <String>[];

    if (liters <= 0) validationErrors.add('Valor do litro é obrigatório');
    if (totalValue <= 0) validationErrors.add('Valor total é obrigatório');
    if (odometer <= 0) validationErrors.add('KM atual é obrigatório');
    if (date == null) validationErrors.add('Data de abastecimento é obrigatório');
    if (fuelType == null) validationErrors.add('Tipo de combustível é obrigatório');

    if (validationErrors.isNotEmpty) {
      final message = 'Corrija os campos abaixo:\n${validationErrors.join('\n')}';
      Messages.showError(context, message);
      return;
    }

    final userId = AuthHelper.getCurrentUserId(context);

    if (userId == null) {
      Messages.showError(context, 'Usuário não autenticado');
      return;
    }

    final refuel = Refuel(
      id: const Uuid().v4(),
      vehicleId: widget.vehicleId,
      liters: liters,
      totalValue: totalValue,
      odometer: odometer,
      date: date!,
      fuelType: fuelType!,
      createdAt: DateTime.now(),
      createdBy: userId,
    );

    context.read<RefuelCubit>().addRefuel(refuel);
  }

  @override
  Widget build(BuildContext context) {
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
            validator: (date) {
              if (date == null) return 'Data de abastecimento obrigatória';
              return null;
            },
          ),
          GasosaFormField(
            label: 'KM atual *',
            hint: '100.00 KM',
            controller: _odometerEC,
            keyboardType: TextInputType.number,
            inputFormatters: [decimalInputFormatter],
            validator: Validatorless.multiple([
              Validatorless.required('KM atual é obrigatório'),
              Validatorless.min(1, 'Valor inválido'),
            ]),
          ),
          GasosaFormField(
            label: 'Litros abastecidos *',
            hint: '40.000 L',
            controller: _litersEC,
            keyboardType: TextInputType.number,
            inputFormatters: [litersInputFormatter],
            validator: Validatorless.multiple([
              Validatorless.required('Litros abastecidos é obrigatório'),
              Validatorless.min(1, 'Valor inválido'),
            ]),
          ),
          GasosaFormField(
            label: 'Valor total *',
            hint: 'R\$ 100,00',
            controller: _totalValueEC,
            keyboardType: TextInputType.number,
            inputFormatters: [currencyInputFormatter],
            validator: Validatorless.multiple([
              Validatorless.required('Valor total é obrigatório'),
              Validatorless.min(1, 'Valor inválido'),
            ]),
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
          GasosaButton(label: 'Registrar abastecimento', onPressed: _onSubmit),
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


import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:validatorless/validatorless.dart';

class RefuelValidators {
  static final liters = Validatorless.multiple([
    Validatorless.required('Litros abastecidos é obrigatório'),
    Validatorless.min(1, 'Valor inválido'),
    Validatorless.max(2000, 'Esse valor parece muito alto, confira se o valor está correto'),
  ]);

  static final totalValue = Validatorless.multiple([
    Validatorless.required('Valor total é obrigatório'),
    Validatorless.min(1, 'Valor inválido'),
    Validatorless.max(2000, 'Esse valor parece muito alto, confira se o valor está correto'),
  ]);

  static final odometer = Validatorless.multiple([
    Validatorless.required('KM atual é obrigatório'),
    Validatorless.min(1, 'Valor inválido'),
    Validatorless.max(1_000_000, 'Esse valor parece muito alto, confira se o valor está correto'),
  ]);

  static String? fuelType(FuelType? fuelType) {
    if (fuelType == null) return 'Selecione o tipo de combustível';
    return null;
  }

  static String? date(DateTime? date) {
    if (date == null) return 'Data de abastecimento obrigatória';
    return null;
  }
}
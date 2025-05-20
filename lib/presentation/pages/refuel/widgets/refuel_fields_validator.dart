import 'package:gasosa_app/domain/entities/fuel_type.dart';

class RefuelFieldsValidator {
  static List<String> validateRefuelFields({
    required double liters,
    required double totalValue,
    required double odometer,
    required DateTime? date,
    required FuelType? fuelType,
    required bool hasColdStart,
    required double? coldStartLiters,
    required double? coldStartValue,
  }) {
    final errors = <String>[];

    if (liters <= 0) errors.add('Valor do litro é obrigatório');
    if (totalValue <= 0) errors.add('Valor total é obrigatório');
    if (odometer <= 0) errors.add('KM atual é obrigatório');
    if (date == null) errors.add('Data de abastecimento é obrigatório');
    if (fuelType == null) errors.add('Tipo de combustível é obrigatório');
    if (hasColdStart) {
      if (coldStartLiters == null) errors.add('Litros abastecidos (partida a frio) é obrigatório');
      if (coldStartValue == null) errors.add('Valor total (partida a frio) é obrigatório');
    }

    return errors;
  }
}

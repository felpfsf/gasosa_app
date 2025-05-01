import 'package:gasosa_app/domain/entities/fuel_type.dart';

extension FuelTypeExtension on FuelType {
  String get label {
    switch (this) {
      case FuelType.gasoline:
        return 'Gasolina';
      case FuelType.ethanol:
        return 'Etanol';
      case FuelType.diesel:
        return 'Diesel';
      case FuelType.flex:
        return 'Flex';
      case FuelType.gnv:
        return 'GNV';
    }
  }

  static FuelType fromString(String value) => FuelType.values.firstWhere((e) => e.name == value);
}

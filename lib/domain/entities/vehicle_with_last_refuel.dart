import 'package:gasosa_app/core/extensions/datetime_extensions.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart' as domain;
import 'package:gasosa_app/domain/entities/vehicle.dart';

class VehicleWithLastRefuel {
  final Vehicle vehicle;
  final DateTime? lastRefuelDate;

  VehicleWithLastRefuel({required this.vehicle, this.lastRefuelDate});

  String get id => vehicle.id;
  String get name => vehicle.name;
  String? get plate => vehicle.plate;
  domain.FuelType get fuelType => vehicle.fuelType;
  String get userId => vehicle.userId;
  DateTime get createdAt => vehicle.createdAt;

  bool get hasRfuel => lastRefuelDate != null;

  String get formattedLastRefuelDate {
    if (lastRefuelDate == null) {
      return 'Nunca abastecido';
    }

    return lastRefuelDate.formattedFullDate();
  }
}

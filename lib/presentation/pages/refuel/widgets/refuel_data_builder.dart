import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:uuid/uuid.dart';

class RefuelDataBuilder {
  static Refuel build({
    required String vehicleId,
    required DateTime? date,
    required double liters,
    required double totalValue,
    required double odometer,
    required FuelType fuelType,
    required String userId,
    double? coldStartLiters,
    double? coldStartValue,
    String? noteImageUrl,
    Refuel? previous,
  }) {
    return Refuel(
      id: previous?.id ?? const Uuid().v4(),
      vehicleId: vehicleId,
      date: date ?? DateTime.now(),
      odometer: odometer,
      fuelType: fuelType,
      liters: liters,
      totalValue: totalValue,
      coldStartLiters: coldStartLiters,
      coldStartValue: coldStartValue,
      noteImageUrl: noteImageUrl,
      createdAt: previous?.createdAt ?? DateTime.now(),
      createdBy: userId,
      updatedAt: previous?.updatedAt ?? DateTime.now(),
      updatedBy: previous?.updatedBy,
    );
  }
}

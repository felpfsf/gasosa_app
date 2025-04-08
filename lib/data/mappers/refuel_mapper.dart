import 'package:drift/drift.dart';
import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/domain/entities/refuel.dart' as domain;

extension RefuelMapper on domain.Refuel {
  RefuelsCompanion toCompanion() {
    return RefuelsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      date: Value(date),
      odometer: Value(odometer),
      fuelType: Value(fuelType),
      liters: Value(liters),
      totalValue: Value(totalValue),
      pricePerLiter: Value(pricePerLiter),
      coldStartLitters: Value(coldStartLitters),
      noteImageUrl: Value(noteImageUrl),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      createdBy: Value(createdBy),
      updatedBy: Value(updatedBy),
      updatedAt: Value(updatedAt),
    );
  }
}

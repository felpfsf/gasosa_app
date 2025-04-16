import 'package:drift/drift.dart';
import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/domain/entities/refuel.dart' as domain;

extension RefuelMapper on domain.Refuel {
  RefuelsCompanion toCompanion({forUpdate = false}) {
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

extension RefuelDataTodomain on Refuel {
  domain.Refuel toDomain() {
    return domain.Refuel(
      id: id,
      vehicleId: vehicleId,
      date: date,
      odometer: odometer,
      fuelType: fuelType,
      liters: liters,
      totalValue: totalValue,
      pricePerLiter: pricePerLiter,
      coldStartLitters: coldStartLitters,
      noteImageUrl: noteImageUrl,
      isSynced: isSynced,
      createdAt: createdAt,
      createdBy: createdBy,
      updatedBy: updatedBy,
      updatedAt: updatedAt,
    );
  }
}

import 'package:drift/drift.dart';
import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart' as domain;

extension VehicleMapper on domain.Vehicle {
  VehiclesCompanion toCompanion({forUpdate = false}) {
    return VehiclesCompanion(
      id: Value(id),
      name: Value(name),
      plate: Value(plate),
      fuelType: Value(fuelType),
      userId: Value(userId),
      createdAt: Value(createdAt),
      updatedBy: Value(updatedBy),
      updatedAt: Value(updatedAt),
    );
  }
}

extension VehicleDataTodomain on Vehicle {
  domain.Vehicle toDomain() {
    return domain.Vehicle(
      id: id,
      name: name,
      plate: plate,
      fuelType: fuelType,
      userId: userId,
      createdAt: createdAt,
      updatedBy: updatedBy,
      updatedAt: updatedAt,
    );
  }
}

import 'package:drift/drift.dart';

import 'dabase.dart';
import 'tables/vehicles.dart';

part 'vehicle_dao.g.dart';

@DriftAccessor(tables: [Vehicles])
class VehicleDao extends DatabaseAccessor<GasosaDatabase>
    with _$VehicleDaoMixin {
  VehicleDao(super.db);

  Future<void> insertVehicle(VehiclesCompanion entry) async {
    await into(vehicles).insert(entry);
  }

  Stream<List<Vehicle>> watchAllVehicles() {
    return select(vehicles).watch();
  }

  Future<void> updateVehicle(VehiclesCompanion entry) async {
    await update(vehicles).replace(entry);
  }

  Future<void> deleteVehicle(String id) async {
    await (delete(vehicles)..where((vehicle) => vehicle.id.equals(id))).go();
  }

  Future<Vehicle?> findVehicleById(String id) async {
    return (select(vehicles)
      ..where((vehicle) => vehicle.id.equals(id))).getSingleOrNull();
  }
}

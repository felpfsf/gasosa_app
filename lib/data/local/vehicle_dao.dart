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
}

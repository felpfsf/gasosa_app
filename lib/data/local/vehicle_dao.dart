import 'package:drift/drift.dart';
import 'package:gasosa_app/data/local/tables/refuels.dart';

import 'dabase.dart';
import 'tables/vehicles.dart';

part 'vehicle_dao.g.dart';

@DriftAccessor(tables: [Vehicles, Refuels])
class VehicleDao extends DatabaseAccessor<GasosaDatabase> with _$VehicleDaoMixin {
  VehicleDao(super.db);

  Future<void> insertVehicle(VehiclesCompanion entry) async {
    await into(vehicles).insert(entry);
  }

  Stream<List<({Vehicle vehicle, DateTime? lastRefuelDate})>> watchAllVehiclesByUserId(String userId) {
    final query = customSelect(
      '''
      SELECT v.*, MAX(r.date) AS lastRefuelDate
      FROM vehicles v
      LEFT JOIN refuels r ON r.vehicle_id = v.id
      WHERE v.user_id = ?
      GROUP BY v.id
      ''',
      variables: [Variable.withString(userId)],
      readsFrom: {vehicles, refuels},
    );

    return query.watch().map((rows) {
      return rows.map((row) {
        final vehicle = vehicles.map(row.data);
        final lastRefuelDate = row.readNullable<DateTime>('lastRefuelDate');
        return (vehicle: vehicle, lastRefuelDate: lastRefuelDate);
      }).toList();
    });
  }

  Future<void> updateVehicle(VehiclesCompanion entry) async {
    await update(vehicles).replace(entry);
  }

  Future<void> deleteVehicle(String id) async {
    await (delete(vehicles)..where((vehicle) => vehicle.id.equals(id))).go();
  }

  Future<({Vehicle vehicle, DateTime? lastRefuelDate})?> findVehicleById(String id) async {
    // return (select(vehicles)..where((vehicle) => vehicle.id.equals(id))).getSingleOrNull();
    final result =
        await customSelect(
          '''
      SELECT v.*, MAX(r.date) AS lastRefuelDate
      FROM vehicles v
      LEFT JOIN refuels r ON r.vehicle_id = v.id
      WHERE v.id = ?
      GROUP BY v.id
      ''',
          variables: [Variable.withString(id)],
          readsFrom: {vehicles, refuels},
        ).getSingleOrNull();

    if (result == null) return null;

    final vehicle = vehicles.map(result.data);
    final lastRefuelData = result.readNullable<DateTime>('lastRefuelDate');

    return (vehicle: vehicle, lastRefuelDate: lastRefuelData);
  }
}

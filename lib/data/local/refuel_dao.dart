import 'package:drift/drift.dart';

import 'dabase.dart';
import 'tables/refuels.dart';

part 'refuel_dao.g.dart';

@DriftAccessor(tables: [Refuels])
class RefuelDao extends DatabaseAccessor<GasosaDatabase> with _$RefuelDaoMixin {
  RefuelDao(super.db);

  Future<void> insertRefuel(RefuelsCompanion entry) async {
    await into(refuels).insert(entry);
  }

  Stream<List<Refuel>> watchRefuelByVehicleId(String vehicleId) {
    return (select(refuels)
          ..where((tbl) => tbl.vehicleId.equals(vehicleId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
        .watch();
  }

  Future<void> updateRefuel(RefuelsCompanion entry) async {
    await update(refuels).replace(entry);
  }

  Future<void> deleteRefuel(String id) async {
    await (delete(refuels)..where((refuel) => refuel.id.equals(id))).go();
  }

  Future<Refuel?> findRefuelById(String id) async {
    return (select(refuels)
      ..where((refuel) => refuel.id.equals(id))).getSingleOrNull();
  }
}

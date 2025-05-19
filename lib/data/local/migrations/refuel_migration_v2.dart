import 'package:drift/drift.dart';
import 'package:gasosa_app/data/local/dabase.dart';

Future<void> migrateToV2(Migrator migrator, GasosaDatabase db) async {
  await migrator.addColumn(db.refuels, db.refuels.coldStartLiters);
  await migrator.addColumn(db.refuels, db.refuels.coldStartValue);
}

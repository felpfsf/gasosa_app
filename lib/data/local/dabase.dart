import 'dart:developer';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:gasosa_app/data/local/migrations/refuel_migration_v2.dart';
import 'package:gasosa_app/data/local/refuel_dao.dart';
import 'package:gasosa_app/data/local/user_dao.dart';
import 'package:gasosa_app/data/local/vehicle_dao.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/refuels.dart';
import 'tables/users.dart';
import 'tables/vehicles.dart';

part 'dabase.g.dart';

const schemaVersionNumber = 2;

@DriftDatabase(tables: [Refuels, Vehicles, Users], daos: [UserDao, RefuelDao, VehicleDao])
class GasosaDatabase extends _$GasosaDatabase {
  GasosaDatabase() : super(_openConnection());

  GasosaDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => schemaVersionNumber;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from == 1) {
        log('Migrating from version 1 to version 2');
        await migrateToV2(m, this);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gasosa.sqlite'));
    final database = NativeDatabase(
      file,
      logStatements: true,
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON');
      },
    );

    return database;
  });
}

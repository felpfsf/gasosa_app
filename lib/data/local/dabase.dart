import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/refuels.dart';
import 'tables/vehicles.dart';

part 'dabase.g.dart';

@DriftDatabase(tables: [Refuels, Vehicles])
class GasosaDatabase extends _$GasosaDatabase {
  GasosaDatabase() : super(_openConnection());

  GasosaDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gasosa.sqlite'));
    return NativeDatabase(file);
  });
}

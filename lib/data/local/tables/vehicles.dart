import 'package:drift/drift.dart';

class Vehicles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get plate => text().nullable()();
  TextColumn get fuelType => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

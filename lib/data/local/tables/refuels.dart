import 'package:drift/drift.dart';
import 'package:gasosa_app/data/local/tables/users.dart';
import 'package:gasosa_app/data/local/tables/vehicles.dart';

class Refuels extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().references(Vehicles, #id)();
  DateTimeColumn get date => dateTime()();
  RealColumn get odometer => real()();
  TextColumn get fuelType => text()();
  RealColumn get liters => real()();
  RealColumn get totalValue => real()();
  RealColumn get pricePerLiter => real().nullable()();
  RealColumn get coldStartLitters => real().nullable()();
  TextColumn get noteImageUrl => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text().references(Users, #id)();
  TextColumn get updatedBy => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
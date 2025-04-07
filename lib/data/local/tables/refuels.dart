import 'package:drift/drift.dart';

class Refuels extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text()();
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

  @override
  Set<Column> get primaryKey => {id};
}
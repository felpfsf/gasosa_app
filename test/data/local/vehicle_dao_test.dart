import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/data/mappers/vehicle_mapper.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart' as domain;
import 'package:uuid/uuid.dart';

void main() {
  late GasosaDatabase db;

  setUp(() async {
    db = GasosaDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('should insert and update vehicle correctly', () async {
    final now = DateTime.now().toUtc().copyWith(microsecond: 0, millisecond: 0);
    final updated = now.add(const Duration(hours: 2));

    final vehicle = domain.Vehicle(
      id: Uuid().v4(),
      userId: 'user-1',
      name: 'GOL G4',
      plate: 'ABC1234',
      fuelType: 'gasoline',
      createdAt: now,
    );

    await db.vehicleDao.insertVehicle(vehicle.toCompanion());

    final inserted = await db.select(db.vehicles).getSingle();

    expect(inserted.id, vehicle.id);
    expect(inserted.name, vehicle.name);
    expect(inserted.plate, vehicle.plate);
    expect(inserted.updatedAt, isNull);

    final updatedVehicle = vehicle.copyWith(
      name: 'GOL G4 Updated',
      plate: 'ABC1234-updated',
      updatedAt: updated,
      updatedBy: 'user-1',
    );

    await db.vehicleDao.updateVehicle(updatedVehicle.toCompanion());

    final reloaded = await db.select(db.vehicles).getSingle();

    expect(reloaded.id, vehicle.id);
    expect(reloaded.name, 'GOL G4 Updated');
    expect(reloaded.plate, 'ABC1234-updated');
    expect(reloaded.updatedAt?.millisecondsSinceEpoch, updated.millisecondsSinceEpoch);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/usecases/refuel/watch_all_refuels_by_vehicle_id_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockRefuelRepository mockRefuelRepository;
  late WatchAllRefuelsByVehicleIdUsecase watchAllRefuelsByVehicleIdUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockRefuelRepository = MockRefuelRepository();
    watchAllRefuelsByVehicleIdUsecase = WatchAllRefuelsByVehicleIdUsecase(refuelRepository: mockRefuelRepository);
  });

  test('should emit a list of refuels from repository', () async {
    final vehicleId = 'car-1';
    final refuel = Refuel(
      id: '1',
      vehicleId: vehicleId,
      date: DateTime.now(),
      odometer: 12000,
      fuelType: FuelType.gasoline,
      liters: 40.0,
      totalValue: 240.0,
      pricePerLiter: 6.0,
      coldStartLiters: null,
      coldStartValue: null,
      noteImageUrl: null,
      isSynced: false,
      createdAt: DateTime.now(),
      createdBy: 'user-1',
    );

    when(() => mockRefuelRepository.watchRefuelByVehicleId(vehicleId)).thenAnswer((_) => Stream.value([refuel]));

    final result = watchAllRefuelsByVehicleIdUsecase(vehicleId);

    await expectLater(
      result,
      emits(isA<List<Refuel>>().having((list) => list.first.vehicleId, 'vehicleId', vehicleId)),
    );
  });

  test('should emit a list of refuels with cold start values from repository', () async {
    final vehicleId = 'car-1';
    final refuel = Refuel(
      id: '1',
      vehicleId: vehicleId,
      date: DateTime(2025, 5, 16),
      odometer: 35000,
      fuelType: FuelType.ethanol,
      liters: 38.0,
      totalValue: 247.0,
      pricePerLiter: 6.5,
      coldStartLiters: 0.5,
      coldStartValue: 3.25,
      noteImageUrl: null,
      isSynced: false,
      createdAt: DateTime.now(),
      createdBy: 'user-1',
    );

    when(() => mockRefuelRepository.watchRefuelByVehicleId(vehicleId)).thenAnswer((_) => Stream.value([refuel]));

    final result = watchAllRefuelsByVehicleIdUsecase(vehicleId);

    await expectLater(
      result,
      emits(
        isA<List<Refuel>>()
            .having((list) => list.first.coldStartLiters, 'coldStartLiters', 0.5)
            .having((list) => list.first.coldStartValue, 'coldStartValue', 3.25),
      ),
    );
  });

  test('should emit an empty list when repository emits an empty list', () async {
    final vehicleId = '1';

    when(() => mockRefuelRepository.watchRefuelByVehicleId(vehicleId)).thenAnswer((_) => Stream.empty());

    final result = watchAllRefuelsByVehicleIdUsecase(vehicleId);

    await expectLater(result, emits(isA<List<Refuel>>().having((list) => list.isEmpty, 'isEmpty', true)));
  });

  test('should emit an error when repository emits an error', () async {
    final vehicleId = '1';

    when(() => mockRefuelRepository.watchRefuelByVehicleId(vehicleId)).thenAnswer((_) => Stream.error(Exception()));

    final result = watchAllRefuelsByVehicleIdUsecase(vehicleId);

    await expectLater(result, emitsInOrder([isA<List<Refuel>>(), isA<Failure>()]));
  });
}

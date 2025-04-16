import 'package:flutter_test/flutter_test.dart';
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
    watchAllRefuelsByVehicleIdUsecase = WatchAllRefuelsByVehicleIdUsecase(
      refuelRepository: mockRefuelRepository,
    );
  });

  test('should emit a list of refuels from repository', () async {
    final vehicleId = '1';
    final refuel = Refuel(
      id: '1',
      vehicleId: 'car-1',
      date: DateTime.now(),
      odometer: 12000,
      fuelType: 'gasoline',
      liters: 40.0,
      totalValue: 240.0,
      pricePerLiter: 6.0,
      coldStartLitters: null,
      noteImageUrl: null,
      isSynced: false,
      createdAt: DateTime.now(),
      createdBy: 'user-1',
    );

    when(
      () => mockRefuelRepository.watchRefuelByVehicleId(vehicleId),
    ).thenAnswer((_) => Stream.value([refuel]));

    final result = watchAllRefuelsByVehicleIdUsecase(vehicleId);

    await expectLater(
      result,
      emits(
        isA<List<Refuel>>().having(
          (list) => list.first.vehicleId,
          'vehicleId',
          'car-1',
        ),
      ),
    );
  });
}

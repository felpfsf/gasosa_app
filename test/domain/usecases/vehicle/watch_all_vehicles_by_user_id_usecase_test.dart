import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/usecases/vehicle/watch_all_vehicles_by_user_id_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockVehicleRepository mockVehicleRepository;
  late WatchAllVehiclesByUserIdUsecase watchAllVehiclesByUserIdUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockVehicleRepository = MockVehicleRepository();
    watchAllVehiclesByUserIdUsecase = WatchAllVehiclesByUserIdUsecase(
      vehicleRepository: mockVehicleRepository,
    );
  });

  test('should emit a list of vehicles from repository', () async {
    final userId = '1';
    final vehicle = Vehicle(
      id: '1',
      name: 'car-1',
      plate: 'ABC1234',
      fuelType: 'gasoline',
      createdAt: DateTime.now(),
      userId: 'user-1',
    );

    when(
      () => mockVehicleRepository.watchAllVehiclesByUserId(userId),
    ).thenAnswer((_) => Stream.value([vehicle]));

    final result = watchAllVehiclesByUserIdUsecase(userId);

    await expectLater(
      result,
      emits(
        isA<List<Vehicle>>().having((list) => list.first.name, 'name', 'car-1'),
      ),
    );
  });
}

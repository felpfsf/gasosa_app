import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/usecases/vehicle/find_vehicle_by_id_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockVehicleRepository mockVehicleRepository;
  late FindVehicleByIdUsecase findVehicleByIdUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockVehicleRepository = MockVehicleRepository();
    findVehicleByIdUsecase = FindVehicleByIdUsecase(
      vehicleRepository: mockVehicleRepository,
    );
  });

  test('should return vehicle when find is successfull', () async {
    final id = '1';
    final vehicle = Vehicle(
      id: '1',
      name: 'car-1',
      plate: 'ABC1234',
      fuelType: 'gasoline',
      createdAt: DateTime.now(),
      userId: 'user-1',
    );

    when(
      () => mockVehicleRepository.findVehicleById(id),
    ).thenAnswer((_) async => Right(vehicle));

    final result = await findVehicleByIdUsecase(id);

    expect(result, Right(vehicle));
    verify(() => mockVehicleRepository.findVehicleById(id)).called(1);
  });

  test('should return failure when find is failed', () async {
    final id = '1';

    when(
      () => mockVehicleRepository.findVehicleById(id),
    ).thenAnswer((_) async => Left(DatabaseFailure('error')));

    final result = await findVehicleByIdUsecase(id);

    expect(result, isA<Left<Failure, Vehicle>>());
    verify(() => mockVehicleRepository.findVehicleById(id)).called(1);
  });
}

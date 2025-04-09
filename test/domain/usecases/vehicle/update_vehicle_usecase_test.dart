import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/usecases/vehicle/update_vehicle_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockVehicleRepository mockVehicleRepository;
  late UpdateVehicleUsecase updateVehicleUsecase;

  setUpAll(() => registerFallbacks());

  setUp(() {
    mockVehicleRepository = MockVehicleRepository();
    updateVehicleUsecase = UpdateVehicleUsecase(
      vehicleRepository: mockVehicleRepository,
    );
  });

  test('should return void when update is successfull', () async {
    final vehicle = Vehicle(
      id: '1',
      name: 'car-1',
      plate: 'DEF5678',
      fuelType: 'ethanol',
      createdAt: DateTime.now(),
      userId: 'user-1',
    );

    when(
      () => mockVehicleRepository.updateVehicle(vehicle),
    ).thenAnswer((_) async => Right(null));

    final result = await updateVehicleUsecase(vehicle);

    expect(result, Right(null));
    verify(() => mockVehicleRepository.updateVehicle(vehicle)).called(1);
  });

  test('should return failure when update is failed', () async {
    final vehicle = Vehicle(
      id: '1',
      name: 'car-1',
      plate: 'DEF5678',
      fuelType: 'ethanol',
      createdAt: DateTime.now(),
      userId: 'user-1',
    );

    when(
      () => mockVehicleRepository.updateVehicle(vehicle),
    ).thenAnswer((_) async => Left(DatabaseFailure('Error updating')));

    final result = await updateVehicleUsecase(vehicle);

    expect(result, isA<Left<Failure, void>>());
    verify(() => mockVehicleRepository.updateVehicle(vehicle)).called(1);
  });
}

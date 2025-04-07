import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart' as domain;
import 'package:gasosa_app/domain/usecases/vehicle/add_vehicle_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockVehicleRepository mockVehicleRepository;
  late AddVehicleUsecase addVehicleUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockVehicleRepository = MockVehicleRepository();
    addVehicleUsecase = AddVehicleUsecase(
      vehicleRepository: mockVehicleRepository,
    );
  });

  test('should return vehicle when insert is successfull', () async {
    final vehicle = domain.Vehicle(
      id: '1',
      name: 'car-1',
      plate: 'ABC1234',
      fuelType: 'gasoline',
      createdAt: DateTime.now(),
    );

    when(
      () => mockVehicleRepository.addVehicle(vehicle),
    ).thenAnswer((_) async => Right(vehicle));

    final result = await addVehicleUsecase(vehicle);

    expect(result, Right(vehicle));
    verify(() => mockVehicleRepository.addVehicle(vehicle)).called(1);
  });

  test('should return failure when insert is failed', () async {
    final vehicle = domain.Vehicle(
      id: '1',
      name: 'car-1',
      plate: 'ABC1234',
      fuelType: 'gasoline',
      createdAt: DateTime.now(),
    );

    when(
      () => mockVehicleRepository.addVehicle(vehicle),
    ).thenAnswer((_) async => Left(DatabaseFailure('error')));

    final result = await addVehicleUsecase(vehicle);

    expect(result, isA<Left<Failure, domain.Vehicle>>());
    verify(() => mockVehicleRepository.addVehicle(vehicle)).called(1);
  });
}

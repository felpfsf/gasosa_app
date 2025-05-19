import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/refuel.dart' as domain;
import 'package:gasosa_app/domain/usecases/refuel/add_refuel_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockRefuelRepository mockRefuelRepository;
  late AddRefuelUsecase addRefuelUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockRefuelRepository = MockRefuelRepository();
    addRefuelUsecase = AddRefuelUsecase(repository: mockRefuelRepository);
  });

  test('should return refuel when insert is successful', () async {
    final refuel = domain.Refuel(
      id: '1',
      vehicleId: 'car-1',
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

    when(() => mockRefuelRepository.addRefuel(refuel)).thenAnswer((_) async => Right(refuel));

    final result = await addRefuelUsecase(refuel);

    expect(result, Right(refuel));
    verify(() => mockRefuelRepository.addRefuel(refuel)).called(1);
  });

  test('should return failure when insert is failed', () async {
    final refuel = domain.Refuel(
      id: '1',
      vehicleId: 'car-1',
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

    when(() => mockRefuelRepository.addRefuel(refuel)).thenAnswer((_) async => Left(DatabaseFailure('Error')));

    final result = await addRefuelUsecase(refuel);

    expect(result, isA<Left<Failure, domain.Refuel>>());
    verify(() => mockRefuelRepository.addRefuel(refuel)).called(1);
  });

  test('should return failure when insert is failed', () async {
    final refuel = domain.Refuel(
      id: '1',
      vehicleId: 'car-1',
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

    when(() => mockRefuelRepository.addRefuel(refuel)).thenAnswer((_) async => Left(DatabaseFailure('Error')));

    final result = await addRefuelUsecase(refuel);

    expect(result, isA<Left<Failure, domain.Refuel>>());
    verify(() => mockRefuelRepository.addRefuel(refuel)).called(1);
  });

  // test with cold start values
  test('should return refuel with cold start values when insert is successful', () async {
    final refuel = domain.Refuel(
      id: '1',
      vehicleId: 'car-1',
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

    when(() => mockRefuelRepository.addRefuel(refuel)).thenAnswer((_) async => Right(refuel));

    final result = await addRefuelUsecase(refuel);

    expect(result, Right(refuel));
    verify(() => mockRefuelRepository.addRefuel(refuel)).called(1);
  });
}

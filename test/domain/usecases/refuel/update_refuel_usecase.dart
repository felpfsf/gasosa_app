import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/usecases/refuel/update_refuel_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockRefuelRepository mockRefuelRepository;
  late UpdateRefuelUsecase updateRefuelUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockRefuelRepository = MockRefuelRepository();
    updateRefuelUsecase = UpdateRefuelUsecase(
      refuelRepository: mockRefuelRepository,
    );
  });

  test('should return void when update is successfull', () async {
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
      () => mockRefuelRepository.updateRefuel(refuel),
    ).thenAnswer((_) async => Right(null));

    final result = await updateRefuelUsecase(refuel);

    expect(result, Right(null));
    verify(() => mockRefuelRepository.updateRefuel(refuel)).called(1);
  });

  test('should return failure when update is failed', () async {
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
      () => mockRefuelRepository.updateRefuel(refuel),
    ).thenAnswer((_) async => Left(DatabaseFailure('Error updating')));

    final result = await updateRefuelUsecase(refuel);

    expect(result, isA<Left<Failure, void>>());
    verify(() => mockRefuelRepository.updateRefuel(refuel)).called(1);
  });
}

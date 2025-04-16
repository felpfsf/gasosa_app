import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/usecases/refuel/find_refuel_by_id_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockRefuelRepository mockRefuelRepository;
  late FindRefuelByIdUsecase findRefuelByIdUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockRefuelRepository = MockRefuelRepository();
    findRefuelByIdUsecase = FindRefuelByIdUsecase(
      refuelRepository: mockRefuelRepository,
    );
  });

  test('should return refuel when find is successfull', () async {
    final id = '1';
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
      () => mockRefuelRepository.findRefuelById(id),
    ).thenAnswer((_) async => Right(refuel));

    final result = await findRefuelByIdUsecase(id);

    expect(result, Right(refuel));
    verify(() => mockRefuelRepository.findRefuelById(id)).called(1);
  });

  test('should return failure when find is failed', () async {
    final id = '1';

    when(
      () => mockRefuelRepository.findRefuelById(id),
    ).thenAnswer((_) async => Left(DatabaseFailure('error')));

    final result = await findRefuelByIdUsecase(id);

    expect(result, isA<Left<Failure, Refuel>>());
    verify(() => mockRefuelRepository.findRefuelById(id)).called(1);
  });
}

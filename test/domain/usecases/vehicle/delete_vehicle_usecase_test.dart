import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockVehicleRepository mockVehicleRepository;
  late MockRefuelRepository mockRefuelRepository;
  late DeleteVehicleUsecase deleteVehicleUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockVehicleRepository = MockVehicleRepository();
    mockRefuelRepository = MockRefuelRepository();

    deleteVehicleUsecase = DeleteVehicleUsecase(
      vehicleRepository: mockVehicleRepository,
      refuelRepository: mockRefuelRepository,
    );
  });

  test('should return void when both deletions are successfull', () async {
    final id = '1';

    when(() => mockRefuelRepository.deleteRefuelsByVehicleId(id)).thenAnswer((_) async => Right(null));

    when(() => mockVehicleRepository.deleteVehicle(id)).thenAnswer((_) async => Right(null));

    final result = await deleteVehicleUsecase(id);

    expect(result, Right(null));
    verify(() => mockRefuelRepository.deleteRefuelsByVehicleId(id)).called(1);
    verify(() => mockVehicleRepository.deleteVehicle(id)).called(1);
  });

  test('should return failure when deleting refuels is failed', () async {
    final id = '1';

    when(
      () => mockRefuelRepository.deleteRefuelsByVehicleId(id),
    ).thenAnswer((_) async => Left(DatabaseFailure('Erro ao deletar reabastecimentos do veículo')));

    final result = await deleteVehicleUsecase(id);

    expect(result, isA<Left<Failure, void>>());
    verify(() => mockRefuelRepository.deleteRefuelsByVehicleId(id)).called(1);
    verifyNever(() => mockVehicleRepository.deleteVehicle(id));
  });

  test('should return failure when deleting vehicle is failed', () async {
    final id = '1';

    when(() => mockRefuelRepository.deleteRefuelsByVehicleId(id)).thenAnswer((_) async => Right(null));

    when(
      () => mockVehicleRepository.deleteVehicle(id),
    ).thenAnswer((_) async => Left(DatabaseFailure('Erro ao deletar veículo')));

    final result = await deleteVehicleUsecase(id);

    expect(result, isA<Left<Failure, void>>());
    verify(() => mockRefuelRepository.deleteRefuelsByVehicleId(id)).called(1);
    verify(() => mockVehicleRepository.deleteVehicle(id)).called(1);
  });
}

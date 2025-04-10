import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockVehicleRepository mockVehicleRepository;
  late DeleteVehicleUsecase deleteVehicleUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockVehicleRepository = MockVehicleRepository();
    deleteVehicleUsecase = DeleteVehicleUsecase(
      vehicleRepository: mockVehicleRepository,
    );
  });

  test('should return void when delete is successfull', () async {
    final id = '1';

    when(
      () => mockVehicleRepository.deleteVehicle(id),
    ).thenAnswer((_) async => Right(null));

    final result = await deleteVehicleUsecase(id);

    expect(result, null);
    verify(() => mockVehicleRepository.deleteVehicle(id)).called(1);
  });

  test('should return failure when delete is failed', () async {
    final id = '1';

    when(
      () => mockVehicleRepository.deleteVehicle(id),
    ).thenAnswer((_) async => Left(DatabaseFailure('error')));

    final result = await deleteVehicleUsecase(id);

    expect(result, isA<Left<Failure, void>>());
    verify(() => mockVehicleRepository.deleteVehicle(id)).called(1);
  });
}

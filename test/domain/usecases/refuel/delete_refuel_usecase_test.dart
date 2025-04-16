import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/usecases/refuel/delete_refuel_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main(){
  late MockRefuelRepository mockRefuelRepository;
  late DeleteRefuelUsecase deleteRefuelUsecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    mockRefuelRepository = MockRefuelRepository();
    deleteRefuelUsecase = DeleteRefuelUsecase(
      refuelRepository: mockRefuelRepository,
    );
  });

  test('should return void when delete is successfull', () async {
    final id = '1';

    when(
      () => mockRefuelRepository.deleteRefuel(id),
    ).thenAnswer((_) async => Right(null));

    final result = await deleteRefuelUsecase(id);

    expect(result, Right(null));
    verify(() => mockRefuelRepository.deleteRefuel(id)).called(1);
  });

  test('should return failure when delete is failed', () async {
    final id = '1';

    when(
      () => mockRefuelRepository.deleteRefuel(id),
    ).thenAnswer((_) async => Left(DatabaseFailure('error')));

    final result = await deleteRefuelUsecase(id);

    expect(result, isA<Left<Failure, void>>());
    verify(() => mockRefuelRepository.deleteRefuel(id)).called(1);
  });
}
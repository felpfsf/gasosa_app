import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/usecases/user/load_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late MockUserRepository userRepository;
  late ILoadUserUsecase usecase;

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    userRepository = MockUserRepository();
    usecase = LoadUserUsecase(userRepository: userRepository);
  });

  group('Load User Usecase', () {
    test('should call repository.findUserById', () async {
      final userId = 'userId';
      when(
        () => userRepository.findUserById(userId),
      ).thenAnswer((_) async => Right(null));

      await usecase(userId);

      verify(() => userRepository.findUserById(userId)).called(1);
    });

    test(
      'should return right when repository.findUserById returns right',
      () async {
        final userId = 'userId';
        when(
          () => userRepository.findUserById(userId),
        ).thenAnswer((_) async => Right(null));

        final result = await usecase(userId);

        expect(result, Right(null));
        verify(() => userRepository.findUserById(userId)).called(1);
      },
    );

    test(
      'should return left when repository.findUserById returns left',
      () async {
        final userId = 'userId';
        when(
          () => userRepository.findUserById(userId),
        ).thenAnswer((_) async => Left(DatabaseFailure('error')));

        final result = await usecase(userId);

        expect(result, isA<Left<Failure, User?>>());
        verify(() => userRepository.findUserById(userId)).called(1);
      },
    );
  });
}

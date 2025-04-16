import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/usecases/user/load_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/save_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/update_user_usecase.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../../mocks/fallbacks_values.dart';
import '../../../mocks/mock_classes.dart';

void main() {
  late AuthCubit authCubit;
  late ISaveUserUsecase saveUserUsecase;
  late ILoadUserUsecase loadUserUsecase;
  late IUpdateUserUsecase updateUserUsecase;

  final userId = const Uuid().v4();

  final user = User(
    id: userId,
    name: 'Jon Snow',
    email: 'jon.snow@got.com',
    photoUrl: 'https://picsum.photos/200',
    createdAt: DateTime.now(),
  );

  setUpAll(() {
    registerFallbacks();
  });

  setUp(() {
    saveUserUsecase = MockSaveUserUsecase();
    loadUserUsecase = MockLoadUserUsecase();
    updateUserUsecase = MockUpdateUserUsecase();

    authCubit = AuthCubit(loadUserUsecase, saveUserUsecase, updateUserUsecase);
  });

  group('AuthCubit', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, authenticated] when loadUser returns a user',
      build: () {
        when(
          () => loadUserUsecase(userId),
        ).thenAnswer((_) async => Right(user));

        return authCubit;
      },
      act: (cubit) => cubit.loadUser(userId),
      expect: () => [const AuthState.loading(), AuthState.authenticated(user)],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, unauthenticated] when loadUser returns null',
      build: () {
        when(
          () => loadUserUsecase(userId),
        ).thenAnswer((_) async => Right(null));

        return authCubit;
      },
      act: (cubit) => cubit.loadUser(userId),
      expect: () => [const AuthState.loading(), AuthState.unauthenticated()],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when loadUser fails',
      build: () {
        when(
          () => loadUserUsecase(userId),
        ).thenAnswer((_) async => Left(DatabaseFailure('error')));

        return authCubit;
      },
      act: (cubit) => cubit.loadUser(userId),
      expect:
          () => [const AuthState.loading(), AuthState.error(message: 'error')],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when saveUser is successful',
      build: () {
        when(() => saveUserUsecase(user)).thenAnswer((_) async => Right(null));

        return authCubit;
      },
      act: (cubit) => cubit.saveUser(user),
      expect:
          () => [
            const AuthState.loading(),
            AuthState.success('Successfully saved user'),
          ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when saveUser fails',
      build: () {
        when(
          () => saveUserUsecase(user),
        ).thenAnswer((_) async => Left(DatabaseFailure('error')));

        return authCubit;
      },
      act: (cubit) => cubit.saveUser(user),
      expect:
          () => [const AuthState.loading(), AuthState.error(message: 'error')],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] when updateUser is successful',
      build: () {
        when(
          () => updateUserUsecase(user),
        ).thenAnswer((_) async => Right(null));

        return authCubit;
      },
      act: (cubit) => cubit.updateUser(user),
      expect:
          () => [
            const AuthState.loading(),
            AuthState.success('Successfully updated user'),
          ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when updateUser fails',
      build: () {
        when(
          () => updateUserUsecase(user),
        ).thenAnswer((_) async => Left(DatabaseFailure('error')));

        return authCubit;
      },
      act: (cubit) => cubit.updateUser(user),
      expect:
          () => [const AuthState.loading(), AuthState.error(message: 'error')],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [unauthenticated] when logout is called',
      build: () {
        return authCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [AuthState.unauthenticated()],
    );
  });
}

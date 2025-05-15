import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart' as domain;
import 'package:gasosa_app/domain/repositories/auth_repository.dart';
import 'package:gasosa_app/domain/services/firebase_auth_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepositoryImpl({required FirebaseAuthService firebaseAuthService}) : _firebaseAuthService = firebaseAuthService;

  @override
  Future<Either<Failure, domain.User>> loginWithEmail(String email, String password) async {
    try {
      final user = await _firebaseAuthService.signInWithEmailAndPassword(email, password);

      if (user == null) {
        return Left(AuthFailure('Falha ao fazer login'));
      }

      return Right(
        domain.User(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          photoUrl: user.photoURL ?? '',
          createdAt: user.metadata.creationTime ?? DateTime.now(),
        ),
      );
    } on Exception catch (e) {
      return Left(AuthFailure('Erro ao fazer login: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuthService.signOut();
      return Right(null);
    } on Exception catch (e) {
      return Left(AuthFailure('Erro ao fazer logout: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.User>> registerWithEmail(domain.User user, String password) async {
    try {
      final createdUser = await _firebaseAuthService.registerWithEmailAndPassword(user.email, password);

      if (createdUser == null) {
        return Left(AuthFailure('Falha ao criar usuário'));
      }

      await _firebaseAuthService.updateUserProfile(displayName: user.name);

      final updatedUser = _firebaseAuthService.currentUser;
      if (updatedUser == null) {
        return Left(AuthFailure('Falha ao atualizar usuário'));
      }

      return Right(
        domain.User(
          id: updatedUser.uid,
          name: updatedUser.displayName ?? '',
          email: updatedUser.email ?? '',
          photoUrl: updatedUser.photoURL ?? '',
          createdAt: updatedUser.metadata.creationTime ?? DateTime.now(),
        ),
      );
    } on Exception catch (e) {
      return Left(AuthFailure('Erro ao criar usuário: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.User>> signInWithGoogle() async {
    try {
      final user = await _firebaseAuthService.signInWithGoogle();

      if (user == null) {
        return Left(AuthFailure('Falha ao fazer login com Google'));
      }

      return Right(
        domain.User(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          photoUrl: user.photoURL ?? '',
          createdAt: user.metadata.creationTime ?? DateTime.now(),
        ),
      );
    } on Exception catch (e, s) {
      log('❌ Erro ao fazer login com Google: $e \n stacktrace: $s');
      return Left(AuthFailure('Erro ao fazer login com Google: $e'));
    }
  }
}

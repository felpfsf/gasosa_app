import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<Either<Failure, User?>> findUserById(String userId);
  Future<Either<Failure, void>> saveUser(User user);
  Future<Either<Failure, void>> updateUser(User user);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> registerWithEmail(User user, String password);
  Future<Either<Failure, User>> loginWithEmail(String email, String password);
}

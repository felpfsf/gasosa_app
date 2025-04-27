import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/data/local/user_dao.dart';
import 'package:gasosa_app/data/mappers/user_mapper.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserDao _userDao;

  UserRepositoryImpl(this._userDao);

  @override
  Future<Either<Failure, User?>> findUserById(String userId) async {
    try {
      final user = await _userDao.findUserById(userId);
      return Right(user?.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Erro ao buscar o usuário: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(User user) async {
    try {
      await _userDao.insertOrReplaceUser(user.toCompanion());
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Erro ao salvar o usuário: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(User user) async {
    try {
      await _userDao.updateUser(user.toCompanion());
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Erro ao atualizar o usuário: $e'));
    }
  }
}

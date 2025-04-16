import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ILoadUserUsecase {
  Future<Either<Failure, User?>> call(String userId);
}

@Injectable(as: ILoadUserUsecase)
class LoadUserUsecase implements ILoadUserUsecase {
  final UserRepository _userRepository;

  LoadUserUsecase({required UserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, User?>> call(String userId) async {
    return await _userRepository.findUserById(userId);
  }
}

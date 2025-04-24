import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ILogoutUsecase {
  Future<Either<Failure, void>> call();
}

@Injectable(as: ILogoutUsecase)
class LogoutUsecase implements ILogoutUsecase {
  final UserRepository _userRepository;

  LogoutUsecase({required UserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call() async {
    return await _userRepository.logout();
  }
}

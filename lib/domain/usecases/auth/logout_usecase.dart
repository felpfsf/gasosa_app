import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ILogoutUsecase {
  Future<Either<Failure, void>> call();
}

@Injectable(as: ILogoutUsecase)
class LogoutUsecase implements ILogoutUsecase {
  final AuthRepository _authRepository;

  LogoutUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call() async {
    return await _authRepository.logout();
  }
}

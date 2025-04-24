import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ILoginWithEmailUsecase {
  Future<Either<Failure, User>> call(String email, String password);
}

@Injectable(as: ILoginWithEmailUsecase)
class LoginWithEmailUsecase implements ILoginWithEmailUsecase {
  final AuthRepository _authRepository;

  LoginWithEmailUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> call(String email, String password) async {
    return await _authRepository.loginWithEmail(email, password);
  }
}

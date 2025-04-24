import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IRegisterWithEmailUsecase {
  Future<Either<Failure, User>> call(User user, String password);
}

@Injectable(as: IRegisterWithEmailUsecase)
class RegisterWithEmailUsecase implements IRegisterWithEmailUsecase {
  final AuthRepository _authRepository;

  RegisterWithEmailUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> call(User user, String password) async {
    return await _authRepository.registerWithEmail(user, password);
  }
}

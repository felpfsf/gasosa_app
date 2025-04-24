import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ILoginWithEmailUsecase {
  Future<Either<Failure, User>> call(String email, String password);
}

@Injectable(as: ILoginWithEmailUsecase)
class LoginWithEmailUsecase implements ILoginWithEmailUsecase {
  final UserRepository _userRepository;

  LoginWithEmailUsecase({required UserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, User>> call(String email, String password) async {
    return await _userRepository.loginWithEmail(email, password);
  }
}

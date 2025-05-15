import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

abstract class ISignInWithGoogleUsecase {
  Future<Either<Failure, User>> call();
}

@Injectable(as: ISignInWithGoogleUsecase)
class SignInWithGoogleUsecase implements ISignInWithGoogleUsecase {
  final AuthRepository _authRepository;

  SignInWithGoogleUsecase({required AuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> call() {
    return _authRepository.signInWithGoogle();
  }
}

import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IUpdateUserUsecase {
  Future<Either<Failure, void>> call(User user);
}

@Injectable(as: IUpdateUserUsecase)
class UpdateUserUsecase implements IUpdateUserUsecase {
  final UserRepository _userRepository;

  UpdateUserUsecase({required UserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call(User user) async {
    return await _userRepository.updateUser(user);
  }
}

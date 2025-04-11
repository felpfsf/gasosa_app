import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IDeleteRefuelUsecase {
  Future<Either<Failure, void>> call(String id);
}

@Injectable(as: IDeleteRefuelUsecase)
class DeleteRefuelUsecase implements IDeleteRefuelUsecase {
  final RefuelRepository _refuelRepository;

  DeleteRefuelUsecase({required RefuelRepository refuelRepository})
    : _refuelRepository = refuelRepository;
    
  @override
  Future<Either<Failure, void>> call(String id) async {
    return await _refuelRepository.deleteRefuel(id);
  }
}

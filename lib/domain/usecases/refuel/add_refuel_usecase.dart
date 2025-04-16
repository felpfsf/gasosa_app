import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IAddRefuelUsecase {
  Future<Either<Failure, Refuel>> call(Refuel refuel);
}

@Injectable(as: IAddRefuelUsecase)
class AddRefuelUsecase implements IAddRefuelUsecase {
  final RefuelRepository _repository;

  AddRefuelUsecase({required RefuelRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, Refuel>> call(Refuel refuel) async {
    return await _repository.addRefuel(refuel);
  }
}

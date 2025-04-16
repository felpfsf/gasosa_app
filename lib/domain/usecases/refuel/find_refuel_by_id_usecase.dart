import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IFindRefuelByIdUsecase {
  Future<Either<Failure, Refuel>> call(String id);
}

@Injectable(as: IFindRefuelByIdUsecase)
class FindRefuelByIdUsecase implements IFindRefuelByIdUsecase {
  final RefuelRepository _refuelRepository;

  FindRefuelByIdUsecase({required RefuelRepository refuelRepository})
    : _refuelRepository = refuelRepository;

  @override
  Future<Either<Failure, Refuel>> call(String id) async {
    return await _refuelRepository.findRefuelById(id);
  }
}

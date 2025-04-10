import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FindRefuelByIdUsecase {
  final RefuelRepository _refuelRepository;

  FindRefuelByIdUsecase({required RefuelRepository refuelRepository})
    : _refuelRepository = refuelRepository;

  Future<Either<Failure, Refuel>> call(String id) async {
    return await _refuelRepository.findRefuelById(id);
  }
}

import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateRefuelUsecase {
  final RefuelRepository _refuelRepository;

  UpdateRefuelUsecase({required RefuelRepository refuelRepository})
    : _refuelRepository = refuelRepository;

  Future<Either<Failure, void>> call(Refuel refuel) async {
    return await _refuelRepository.updateRefuel(refuel);
  }
}

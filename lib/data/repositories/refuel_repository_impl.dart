import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/data/local/refuel_dao.dart';
import 'package:gasosa_app/data/mappers/refuel_mapper.dart';
import 'package:gasosa_app/domain/entities/refuel.dart' as domain;
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RefuelRepository)
class RefuelRepositoryImpl implements RefuelRepository {
  final RefuelDao _refuelDao;

  RefuelRepositoryImpl(this._refuelDao);

  @override
  Future<Either<Failure, domain.Refuel>> addRefuel(domain.Refuel refuel) async {
    try {
      await _refuelDao.insertRefuel(
        // RefuelsCompanion.insert(
        //   id: refuel.id,
        //   vehicleId: refuel.vehicleId,
        //   date: refuel.date,
        //   odometer: refuel.odometer,
        //   fuelType: refuel.fuelType,
        //   liters: refuel.liters,
        //   totalValue: refuel.totalValue,
        //   pricePerLiter: Value(refuel.pricePerLiter),
        //   coldStartLitters: Value(refuel.coldStartLitters),
        //   createdAt: refuel.createdAt,
        //   createdBy: refuel.createdBy,
        // ),
        refuel.toCompanion(),
      );

      return Right(refuel);
    } catch (e) {
      return Left(DatabaseFailure('Erro ao salvar o abastecimento: $e'));
    }
  }
}

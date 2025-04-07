import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/data/local/vehicle_dao.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart' as domain;
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: VehicleRepository)
class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleDao _vehicleDao;

  VehicleRepositoryImpl(this._vehicleDao);

  @override
  Future<Either<Failure, domain.Vehicle>> addVehicle(
    domain.Vehicle vehicle,
  ) async {
    try {
      await _vehicleDao.insertVehicle(
        VehiclesCompanion.insert(
          id: vehicle.id,
          name: vehicle.name,
          fuelType: vehicle.fuelType,
          createdAt: vehicle.createdAt,
        ),
      );

      return Right(vehicle);
    } on Exception catch (e) {
      return Left(DatabaseFailure('Erro ao salvar o veículo: $e'));
    }
  }
}

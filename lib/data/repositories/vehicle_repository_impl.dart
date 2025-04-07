import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
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

  @override
  Future<Either<Failure, void>> updateVehicle(domain.Vehicle vehicle) async {
    try {
      await _vehicleDao.updateVehicle(
        VehiclesCompanion(
          id: Value(vehicle.id),
          name: Value(vehicle.name),
          plate: Value(vehicle.plate),
          fuelType: Value(vehicle.fuelType),
          createdAt: Value(vehicle.createdAt),
        ),
      );

      return Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure('Erro ao atualizar o veículo: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVehicle(String id) async {
    try {
      await _vehicleDao.deleteVehicle(id);
      return Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure('Erro ao deletar o veículo: $e'));
    }
  }
}

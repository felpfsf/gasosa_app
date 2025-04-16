import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/data/local/vehicle_dao.dart';
import 'package:gasosa_app/data/mappers/vehicle_mapper.dart';
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
        // VehiclesCompanion.insert(
        //   id: vehicle.id,
        //   name: vehicle.name,
        //   fuelType: vehicle.fuelType,
        //   createdAt: vehicle.createdAt,
        //   userId: vehicle.userId,
        // ),
        vehicle.toCompanion(),
      );

      return Right(vehicle);
    } catch (e) {
      return Left(DatabaseFailure('Erro ao salvar o veículo: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.Vehicle>> findVehicleById(String id) async {
    try {
      final vehicle = await _vehicleDao.findVehicleById(id);
      if (vehicle == null) {
        return Left(DatabaseFailure('Veículo não encontrado'));
      }

      return Right(vehicle.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Erro ao buscar o veículo: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateVehicle(domain.Vehicle vehicle) async {
    try {
      await _vehicleDao.updateVehicle(
        // VehiclesCompanion(
        //   id: Value(vehicle.id),
        //   name: Value(vehicle.name),
        //   plate: Value(vehicle.plate),
        //   fuelType: Value(vehicle.fuelType),
        //   updatedAt: Value(vehicle.updatedAt),
        //   updatedBy: Value(vehicle.updatedBy),
        // ),
        vehicle.toCompanion(forUpdate: true),
      );

      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Erro ao atualizar o veículo: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteVehicle(String id) async {
    try {
      await _vehicleDao.deleteVehicle(id);
      return Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Erro ao deletar o veículo: $e'));
    }
  }

  @override
  Stream<List<domain.Vehicle>> watchAllVehiclesByUserId(String userId) {
    return _vehicleDao
        .watchAllVehiclesByUserId(userId)
        .map(
          (vehicles) => vehicles.map((vehicle) => vehicle.toDomain()).toList(),
        );
  }
}

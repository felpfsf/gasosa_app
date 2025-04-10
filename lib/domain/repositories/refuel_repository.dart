import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';

abstract interface class RefuelRepository {
  Future<Either<Failure, Refuel>> addRefuel(Refuel refuel);
  Future<Either<Failure, Refuel>> findRefuelById(String id);
  Future<Either<Failure, void>> updateRefuel(Refuel refuel);
  Future<Either<Failure, void>> deleteRefuel(String id);
  Stream<List<Refuel>> watchRefuelByVehicleId(String vehicleId);
}

import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';

abstract interface class VehicleRepository {
  Future<Either<Failure, Vehicle>> addVehicle(Vehicle vehicle); 
}
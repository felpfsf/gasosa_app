import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateVehicleUsecase {
  final VehicleRepository _vehicleRepository;

  UpdateVehicleUsecase({required VehicleRepository vehicleRepository})
    : _vehicleRepository = vehicleRepository;

  Future<Either<Failure, void>> call(Vehicle vehicle) {
    return _vehicleRepository.updateVehicle(vehicle);
  }
}

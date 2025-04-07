import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddVehicleUsecase {
  final VehicleRepository _vehicleRepository;

  AddVehicleUsecase({required VehicleRepository vehicleRepository})
    : _vehicleRepository = vehicleRepository;

  Future<Either<Failure, Vehicle>> call(Vehicle vehicle) async {
    return await _vehicleRepository.addVehicle(vehicle);
  }
}

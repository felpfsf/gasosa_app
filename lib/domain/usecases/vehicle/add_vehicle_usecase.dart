import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IAddVehicleUsecase {
  Future<Either<Failure, Vehicle>> call(Vehicle vehicle);
}

@Injectable(as: IAddVehicleUsecase)
class AddVehicleUsecase implements IAddVehicleUsecase {
  final VehicleRepository _vehicleRepository;

  AddVehicleUsecase({required VehicleRepository vehicleRepository})
    : _vehicleRepository = vehicleRepository;

  @override
  Future<Either<Failure, Vehicle>> call(Vehicle vehicle) async {
    return await _vehicleRepository.addVehicle(vehicle);
  }
}

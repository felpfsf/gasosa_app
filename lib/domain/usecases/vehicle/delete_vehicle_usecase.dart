import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteVehicleUsecase {
  final VehicleRepository _vehicleRepository;

  DeleteVehicleUsecase({required VehicleRepository vehicleRepository})
    : _vehicleRepository = vehicleRepository;

  Future<Either<Failure, void>> call(String id) {
    return _vehicleRepository.deleteVehicle(id);
  }
}

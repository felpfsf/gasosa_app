import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IDeleteVehicleUsecase {
  Future<Either<Failure, void>> call(String id);
}

@Injectable(as: IDeleteVehicleUsecase)
class DeleteVehicleUsecase implements IDeleteVehicleUsecase {
  final VehicleRepository _vehicleRepository;

  DeleteVehicleUsecase({required VehicleRepository vehicleRepository})
    : _vehicleRepository = vehicleRepository;

  @override
  Future<Either<Failure, void>> call(String id) {
    return _vehicleRepository.deleteVehicle(id);
  }
}

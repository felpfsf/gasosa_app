import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IFindVehicleByIdUsecase {
  Future<Either<Failure, Vehicle>> call(String id);
}

@Injectable(as: IFindVehicleByIdUsecase)
class FindVehicleByIdUsecase implements IFindVehicleByIdUsecase {
  final VehicleRepository _vehicleRepository;

  FindVehicleByIdUsecase({required VehicleRepository vehicleRepository})
    : _vehicleRepository = vehicleRepository;

  @override
  Future<Either<Failure, Vehicle>> call(String id) async {
    return await _vehicleRepository.findVehicleById(id);
  }
}

import 'package:dartz/dartz.dart';
import 'package:gasosa_app/core/errors/failure.dart';
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IDeleteVehicleUsecase {
  Future<Either<Failure, void>> call(String id);
}

@Injectable(as: IDeleteVehicleUsecase)
class DeleteVehicleUsecase implements IDeleteVehicleUsecase {
  final VehicleRepository _vehicleRepository;
  final RefuelRepository _refuelRepository;

  DeleteVehicleUsecase({required VehicleRepository vehicleRepository, required RefuelRepository refuelRepository})
    : _vehicleRepository = vehicleRepository,
      _refuelRepository = refuelRepository;

  @override
  Future<Either<Failure, void>> call(String id) async {
    final deleteRefuels = await _refuelRepository.deleteRefuelsByVehicleId(id);
    if (deleteRefuels is Left<Failure, void>) return deleteRefuels;

    return _vehicleRepository.deleteVehicle(id);
  }
}

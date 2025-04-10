import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchAllVehiclesByUserIdUsecase {
  final VehicleRepository _vehicleRepository;

  WatchAllVehiclesByUserIdUsecase({
    required VehicleRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  Stream<List<Vehicle>> call(String userId) {
    return _vehicleRepository.watchAllVehiclesByUserId(userId);
  }
}

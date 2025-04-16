import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IWatchAllVehiclesByUserIdUsecase {
  Stream<List<Vehicle>> call(String userId);
}

@Injectable(as: IWatchAllVehiclesByUserIdUsecase)
class WatchAllVehiclesByUserIdUsecase
    implements IWatchAllVehiclesByUserIdUsecase {
  final VehicleRepository _vehicleRepository;

  WatchAllVehiclesByUserIdUsecase({
    required VehicleRepository vehicleRepository,
  }) : _vehicleRepository = vehicleRepository;

  @override
  Stream<List<Vehicle>> call(String userId) {
    return _vehicleRepository.watchAllVehiclesByUserId(userId);
  }
}

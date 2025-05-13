import 'package:gasosa_app/domain/entities/vehicle_with_last_refuel.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IWatchAllVehiclesByUserIdUsecase {
  Stream<List<VehicleWithLastRefuel>> call(String userId);
}

@Injectable(as: IWatchAllVehiclesByUserIdUsecase)
class WatchAllVehiclesByUserIdUsecase implements IWatchAllVehiclesByUserIdUsecase {
  final VehicleRepository _vehicleRepository;

  WatchAllVehiclesByUserIdUsecase({required VehicleRepository vehicleRepository})
    : _vehicleRepository = vehicleRepository;

  @override
  Stream<List<VehicleWithLastRefuel>> call(String userId) async* {
    yield* _vehicleRepository.watchAllVehiclesByUserId(userId);
  }
}

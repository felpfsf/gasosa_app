import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:injectable/injectable.dart';

abstract class IWatchAllRefuelsByVehicleIdUsecase {
  Stream<List<Refuel>> call(String vehicleId);
}

@Injectable(as: IWatchAllRefuelsByVehicleIdUsecase)
class WatchAllRefuelsByVehicleIdUsecase
    implements IWatchAllRefuelsByVehicleIdUsecase {
  final RefuelRepository _refuelRepository;

  WatchAllRefuelsByVehicleIdUsecase({
    required RefuelRepository refuelRepository,
  }) : _refuelRepository = refuelRepository;

  @override
  Stream<List<Refuel>> call(String vehicleId) {
    return _refuelRepository.watchRefuelByVehicleId(vehicleId);
  }
}

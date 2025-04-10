import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchAllRefuelsByVehicleIdUsecase {
  final RefuelRepository _refuelRepository;

  WatchAllRefuelsByVehicleIdUsecase({
    required RefuelRepository refuelRepository,
  }) : _refuelRepository = refuelRepository;

  Stream<List<Refuel>> call(String vehicleId) {
    return _refuelRepository.watchRefuelByVehicleId(vehicleId);
  }
}

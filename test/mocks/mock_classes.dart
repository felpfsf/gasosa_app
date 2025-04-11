import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:gasosa_app/domain/usecases/refuel/add_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/delete_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/find_refuel_by_id_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/update_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/watch_all_refuels_by_vehicle_id_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/add_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/update_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/watch_all_vehicles_by_user_id_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRefuelRepository extends Mock implements RefuelRepository {}

class MockVehicleRepository extends Mock implements VehicleRepository {}

class MockWaWatchAllVehiclesByUserIdUsecase extends Mock
    implements IWatchAllVehiclesByUserIdUsecase {}

class MockWaAddVehicleUsecase extends Mock implements IAddVehicleUsecase {}

class MockWaUpdateVehicleUsecase extends Mock
    implements IUpdateVehicleUsecase {}

class MockWaDeleteVehicleUsecase extends Mock
    implements IDeleteVehicleUsecase {}

class MockWaFindRefuelByIdUsecase extends Mock
    implements IFindRefuelByIdUsecase {}

class MockWaWatchAllRefuelsByVehicleIdUsecase extends Mock
    implements IWatchAllRefuelsByVehicleIdUsecase {}

class MockWaAddRefuelUsecase extends Mock implements IAddRefuelUsecase {}

class MockWaUpdateRefuelUsecase extends Mock implements IUpdateRefuelUsecase {}

class MockWaDeleteRefuelUsecase extends Mock implements IDeleteRefuelUsecase {}

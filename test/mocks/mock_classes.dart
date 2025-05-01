import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:gasosa_app/domain/repositories/user_repository.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:gasosa_app/domain/usecases/auth/login_with_email_usecase.dart';
import 'package:gasosa_app/domain/usecases/auth/logout_usecase.dart';
import 'package:gasosa_app/domain/usecases/auth/register_with_email_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/add_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/delete_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/find_refuel_by_id_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/update_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/watch_all_refuels_by_vehicle_id_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/load_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/save_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/update_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/add_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/update_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/watch_all_vehicles_by_user_id_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockRefuelRepository extends Mock implements RefuelRepository {}

class MockVehicleRepository extends Mock implements VehicleRepository {}

/* Auth */

class MockLoadUserUsecase extends Mock implements ILoadUserUsecase {}

class MockSaveUserUsecase extends Mock implements ISaveUserUsecase {}

class MockUpdateUserUsecase extends Mock implements IUpdateUserUsecase {}

class MockLoginWithEmailUsecase extends Mock implements ILoginWithEmailUsecase {}

class MockLogoutUsecase extends Mock implements ILogoutUsecase {}

class MockRegisterWithEmailUsecase extends Mock implements IRegisterWithEmailUsecase {}

/* Vehicle */

class MockWatchAllVehiclesByUserIdUsecase extends Mock implements IWatchAllVehiclesByUserIdUsecase {}

class MockAddVehicleUsecase extends Mock implements IAddVehicleUsecase {}

class MockUpdateVehicleUsecase extends Mock implements IUpdateVehicleUsecase {}

class MockDeleteVehicleUsecase extends Mock implements IDeleteVehicleUsecase {}

/* Refuel */

class MockFindRefuelByIdUsecase extends Mock implements IFindRefuelByIdUsecase {}

class MocktchAllRefuelsByVehicleIdUsecase extends Mock implements IWatchAllRefuelsByVehicleIdUsecase {}

class MockAddRefuelUsecase extends Mock implements IAddRefuelUsecase {}

class MockUpdateRefuelUsecase extends Mock implements IUpdateRefuelUsecase {}

class MockDeleteRefuelUsecase extends Mock implements IDeleteRefuelUsecase {}

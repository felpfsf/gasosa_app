// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gasosa_app/data/local/refuel_dao.dart' as _i441;
import 'package:gasosa_app/data/local/vehicle_dao.dart' as _i208;
import 'package:gasosa_app/data/repositories/refuel_repository_impl.dart'
    as _i146;
import 'package:gasosa_app/data/repositories/vehicle_repository_impl.dart'
    as _i106;
import 'package:gasosa_app/domain/repositories/refuel_repository.dart' as _i857;
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart' as _i35;
import 'package:gasosa_app/domain/usecases/refuel/add_refuel_usecase.dart'
    as _i452;
import 'package:gasosa_app/domain/usecases/refuel/delete_refuel_usecase.dart'
    as _i146;
import 'package:gasosa_app/domain/usecases/refuel/find_refuel_by_id_usecase.dart'
    as _i586;
import 'package:gasosa_app/domain/usecases/refuel/update_refuel_usecase.dart'
    as _i925;
import 'package:gasosa_app/domain/usecases/refuel/watch_all_refuels_by_vehicle_id_usecase.dart'
    as _i353;
import 'package:gasosa_app/domain/usecases/vehicle/add_vehicle_usecase.dart'
    as _i267;
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart'
    as _i766;
import 'package:gasosa_app/domain/usecases/vehicle/find_vehicle_by_id_usecase.dart'
    as _i406;
import 'package:gasosa_app/domain/usecases/vehicle/update_vehicle_usecase.dart'
    as _i793;
import 'package:gasosa_app/domain/usecases/vehicle/watch_all_vehicles_by_user_id_usecase.dart'
    as _i868;
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart'
    as _i817;
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart'
    as _i1070;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i35.VehicleRepository>(
      () => _i106.VehicleRepositoryImpl(gh<_i208.VehicleDao>()),
    );
    gh.factory<_i267.IAddVehicleUsecase>(
      () => _i267.AddVehicleUsecase(
        vehicleRepository: gh<_i35.VehicleRepository>(),
      ),
    );
    gh.factory<_i766.IDeleteVehicleUsecase>(
      () => _i766.DeleteVehicleUsecase(
        vehicleRepository: gh<_i35.VehicleRepository>(),
      ),
    );
    gh.lazySingleton<_i857.RefuelRepository>(
      () => _i146.RefuelRepositoryImpl(gh<_i441.RefuelDao>()),
    );
    gh.factory<_i793.IUpdateVehicleUsecase>(
      () => _i793.UpdateVehicleUsecase(
        vehicleRepository: gh<_i35.VehicleRepository>(),
      ),
    );
    gh.factory<_i868.IWatchAllVehiclesByUserIdUsecase>(
      () => _i868.WatchAllVehiclesByUserIdUsecase(
        vehicleRepository: gh<_i35.VehicleRepository>(),
      ),
    );
    gh.factory<_i353.IWatchAllRefuelsByVehicleIdUsecase>(
      () => _i353.WatchAllRefuelsByVehicleIdUsecase(
        refuelRepository: gh<_i857.RefuelRepository>(),
      ),
    );
    gh.factory<_i452.IAddRefuelUsecase>(
      () => _i452.AddRefuelUsecase(repository: gh<_i857.RefuelRepository>()),
    );
    gh.factory<_i1070.IVehicleCubit>(
      () => _i1070.VehicleCubit(
        gh<_i868.IWatchAllVehiclesByUserIdUsecase>(),
        gh<_i267.IAddVehicleUsecase>(),
        gh<_i793.IUpdateVehicleUsecase>(),
        gh<_i766.IDeleteVehicleUsecase>(),
      ),
    );
    gh.factory<_i406.IFindVehicleByIdUsecase>(
      () => _i406.FindVehicleByIdUsecase(
        vehicleRepository: gh<_i35.VehicleRepository>(),
      ),
    );
    gh.factory<_i586.IFindRefuelByIdUsecase>(
      () => _i586.FindRefuelByIdUsecase(
        refuelRepository: gh<_i857.RefuelRepository>(),
      ),
    );
    gh.factory<_i146.IDeleteRefuelUsecase>(
      () => _i146.DeleteRefuelUsecase(
        refuelRepository: gh<_i857.RefuelRepository>(),
      ),
    );
    gh.factory<_i925.IUpdateRefuelUsecase>(
      () => _i925.UpdateRefuelUsecase(
        refuelRepository: gh<_i857.RefuelRepository>(),
      ),
    );
    gh.factory<_i817.IRefuelCubit>(
      () => _i817.RefuelCubit(
        gh<_i452.IAddRefuelUsecase>(),
        gh<_i146.IDeleteRefuelUsecase>(),
        gh<_i586.IFindRefuelByIdUsecase>(),
        gh<_i925.IUpdateRefuelUsecase>(),
        gh<_i353.IWatchAllRefuelsByVehicleIdUsecase>(),
      ),
    );
    return this;
  }
}

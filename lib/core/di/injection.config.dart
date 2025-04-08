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
import 'package:gasosa_app/domain/usecases/vehicle/add_vehicle_usecase.dart'
    as _i267;
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart'
    as _i766;
import 'package:gasosa_app/domain/usecases/vehicle/update_vehicle_usecase.dart'
    as _i793;
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
    gh.lazySingleton<_i857.RefuelRepository>(
      () => _i146.RefuelRepositoryImpl(gh<_i441.RefuelDao>()),
    );
    gh.factory<_i793.UpdateVehicleUsecase>(
      () => _i793.UpdateVehicleUsecase(
        vehicleRepository: gh<_i35.VehicleRepository>(),
      ),
    );
    gh.factory<_i766.DeleteVehicleUsecase>(
      () => _i766.DeleteVehicleUsecase(
        vehicleRepository: gh<_i35.VehicleRepository>(),
      ),
    );
    gh.factory<_i267.AddVehicleUsecase>(
      () => _i267.AddVehicleUsecase(
        vehicleRepository: gh<_i35.VehicleRepository>(),
      ),
    );
    gh.factory<_i452.AddRefuelUsecase>(
      () => _i452.AddRefuelUsecase(repository: gh<_i857.RefuelRepository>()),
    );
    return this;
  }
}

import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/data/local/refuel_dao.dart';
import 'package:gasosa_app/data/local/vehicle_dao.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies({
  String enviroment = Environment.dev,
}) async {
  getIt.init(environment: enviroment);
  manualRegisterOverride();
}

void manualRegisterOverride() {
  final db = getIt<GasosaDatabase>();
  getIt.registerLazySingleton<RefuelDao>(() => RefuelDao(db));
  getIt.registerLazySingleton<VehicleDao>(() => VehicleDao(db));
}

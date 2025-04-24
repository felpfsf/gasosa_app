import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/data/local/refuel_dao.dart';
import 'package:gasosa_app/data/local/user_dao.dart';
import 'package:gasosa_app/data/local/vehicle_dao.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DaoModule {
  @lazySingleton
  RefuelDao providerRefuelDao(GasosaDatabase db) => RefuelDao(db);

  @lazySingleton
  VehicleDao providerVehicleDao(GasosaDatabase db) => VehicleDao(db);

  @lazySingleton
  UserDao providerUserDao(GasosaDatabase db) => UserDao(db);
}

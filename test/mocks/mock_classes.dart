import 'package:gasosa_app/domain/repositories/refuel_repository.dart';
import 'package:gasosa_app/domain/repositories/vehicle_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockRefuelRepository extends Mock implements RefuelRepository {}

class MockVehicleRepository extends Mock implements VehicleRepository {}

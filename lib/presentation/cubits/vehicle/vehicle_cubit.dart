import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/entities/vehicle_with_last_refuel.dart';
import 'package:gasosa_app/domain/usecases/vehicle/add_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/find_vehicle_by_id_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/update_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/watch_all_vehicles_by_user_id_usecase.dart';
import 'package:injectable/injectable.dart';

import 'vehicle_state.dart';

enum VehicleAction { created, updated, deleted }

abstract class IVehicleCubit {
  void fetchVehicles(String userId);
  Future<void> addVehicle(Vehicle vehicle);
  Future<void> updateVehicle(Vehicle vehicle);
  Future<void> deleteVehicle(Vehicle vehicle);
  Future<void> close();
  void fetchVehiclesMock();
  Future<void> fetchVehicleById(String id);
}

@Injectable(as: IVehicleCubit)
class VehicleCubit extends Cubit<VehicleState> implements IVehicleCubit {
  final IWatchAllVehiclesByUserIdUsecase _watchAll;
  final IAddVehicleUsecase _add;
  final IUpdateVehicleUsecase _update;
  final IDeleteVehicleUsecase _delete;
  final IFindVehicleByIdUsecase _findVehicleById;

  VehicleCubit(this._watchAll, this._add, this._update, this._delete, this._findVehicleById)
    : super(const VehicleState.initial());

  StreamSubscription<List<Vehicle>>? _vehicleStream;

  @override
  void fetchVehicles(String userId) {
    emit(const VehicleState.loading());

    // _vehicleStream = _watchAll(userId);
    _vehicleStream?.cancel();

    _vehicleStream = _watchAll(userId).listen((vehicles) {
      final vehiclesWithLastRefuel =
          vehicles.map((vehicle) {
            return VehicleWithLastRefuel(
              vehicle: vehicle,
              lastRefuelDate: null, // todo: get last refuel date
            );
          }).toList();

      emit(VehicleState.loaded(vehiclesWithLastRefuel));
    }, onError: (error) => emit(VehicleState.error(message: error.toString())));
  }

  @override
  Future<void> addVehicle(Vehicle vehicle) async {
    emit(const VehicleState.loading());
    final result = await _add(vehicle);

    result.fold(
      (failure) => emit(VehicleState.error(action: VehicleAction.created, message: failure.message)),
      // (_) => fetchVehicles(vehicle.userId),
      (_) => emit(VehicleState.success(action: VehicleAction.created)),
    );
  }

  @override
  Future<void> updateVehicle(Vehicle vehicle) async {
    emit(const VehicleState.loading());
    final result = await _update(vehicle);

    result.fold(
      (failure) => emit(VehicleState.error(action: VehicleAction.updated, message: failure.message)),
      // (_) => fetchVehicles(vehicle.userId),
      (_) async {
        await fetchVehicleById(vehicle.id);
        emit(VehicleState.success(action: VehicleAction.updated));
      },
    );
  }

  @override
  Future<void> deleteVehicle(Vehicle vehicle) async {
    emit(const VehicleState.loading());

    final result = await _delete(vehicle.id);

    result.fold(
      (failure) => emit(VehicleState.error(action: VehicleAction.deleted, message: failure.message)),
      // (_) => fetchVehicles(vehicle.userId),
      (_) async {
        fetchVehicles(vehicle.userId);
        emit(VehicleState.success(action: VehicleAction.deleted));
      },
    );
  }

  @override
  Future<void> close() async {
    _vehicleStream?.cancel();
    await super.close();
  }

  @override
  void fetchVehiclesMock() {
    emit(VehicleState.loading());

    Future.delayed(const Duration(milliseconds: 800), () {
      emit(
        VehicleState.loaded([
          VehicleWithLastRefuel(
            vehicle: Vehicle(
              id: '1',
              name: 'Corolla XRS 2015',
              plate: 'ABC-1234',
              fuelType: FuelType.gasoline,
              createdAt: DateTime.now(),
              userId: 'mock-user',
            ),
            lastRefuelDate: DateTime.now().subtract(const Duration(days: 10)),
          ),
          VehicleWithLastRefuel(
            vehicle: Vehicle(
              id: '2',
              name: 'Civic 2020',
              plate: 'XYZ-5678',
              fuelType: FuelType.ethanol,
              createdAt: DateTime.now(),
              userId: 'mock-user',
            ),
            lastRefuelDate: DateTime.now().subtract(const Duration(days: 5)),
          ),
          VehicleWithLastRefuel(
            vehicle: Vehicle(
              id: '3',
              name: 'Fusca 1970',
              plate: 'OLD-1234',
              fuelType: FuelType.gasoline,
              createdAt: DateTime.now(),
              userId: 'mock-user',
            ),
            lastRefuelDate: DateTime.now().subtract(const Duration(days: 20)),
          ),
          // Vehicle(
          //   id: '1',
          //   name: 'Corolla XRS 2015',
          //   plate: 'ABC-1234',
          //   fuelType: 'Flex',
          //   createdAt: DateTime.now(),
          //   userId: 'mock-user',
          // ),
          // Vehicle(
          //   id: '2',
          //   name: 'Civic 2020',
          //   plate: 'XYZ-5678',
          //   fuelType: 'Gasoline',
          //   createdAt: DateTime.now(),
          //   userId: 'mock-user',
          // ),
          // Vehicle(
          //   id: '3',
          //   name: 'Fusca 1970',
          //   plate: 'OLD-1234',
          //   fuelType: 'Gasoline',
          //   createdAt: DateTime.now(),
          //   userId: 'mock-user',
          // ),
        ]),
      );
    });
  }

  @override
  Future<void> fetchVehicleById(String id) async {
    emit(const VehicleState.loading());

    final result = _findVehicleById(id);

    result.then((value) {
      value.fold(
        (failure) => emit(VehicleState.error(message: failure.message)),
        (vehicle) => emit(VehicleState.detail(VehicleWithLastRefuel(vehicle: vehicle, lastRefuelDate: null))),
      );
    });
  }
}

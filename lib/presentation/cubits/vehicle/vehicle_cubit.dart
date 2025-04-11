import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/domain/usecases/vehicle/add_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/delete_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/update_vehicle_usecase.dart';
import 'package:gasosa_app/domain/usecases/vehicle/watch_all_vehicles_by_user_id_usecase.dart';
import 'package:injectable/injectable.dart';

import 'vehicle_state.dart';

abstract class IVehicleCubit {
  void fetchVehicles(String userId);
  Future<void> addVehicle(Vehicle vehicle);
  Future<void> updateVehicle(Vehicle vehicle);
  Future<void> deleteVehicle(Vehicle vehicle);
  Future<void> close();
}

@Injectable(as: IVehicleCubit)
class VehicleCubit extends Cubit<VehicleState> implements IVehicleCubit {
  final IWatchAllVehiclesByUserIdUsecase _watchAll;
  final IAddVehicleUsecase _add;
  final IUpdateVehicleUsecase _update;
  final IDeleteVehicleUsecase _delete;

  StreamSubscription<List<Vehicle>>? _vehicleStream;

  VehicleCubit(this._watchAll, this._add, this._update, this._delete)
    : super(const VehicleState.initial());

  @override
  void fetchVehicles(String userId) {
    emit(const VehicleState.loading());

    // _vehicleStream = _watchAll(userId);
    _vehicleStream?.cancel();

    _vehicleStream = _watchAll(userId).listen(
      (vehicles) => emit(VehicleState.loaded(vehicles)),
      onError: (error) => emit(VehicleState.error(message: error.toString())),
    );
  }

  @override
  Future<void> addVehicle(Vehicle vehicle) async {
    emit(const VehicleState.loading());
    final result = await _add(vehicle);

    result.fold(
      (failure) => emit(VehicleState.error(message: failure.message)),
      // (_) => fetchVehicles(vehicle.userId),
      (_) => emit(VehicleState.success('Vehicle added successfully')),
    );
  }

  @override
  Future<void> updateVehicle(Vehicle vehicle) async {
    emit(const VehicleState.loading());
    final result = await _update(vehicle);

    result.fold(
      (failure) => emit(VehicleState.error(message: failure.message)),
      // (_) => fetchVehicles(vehicle.userId),
      (_) => emit(VehicleState.success('Vehicle updated successfully')),
    );
  }

  @override
  Future<void> deleteVehicle(Vehicle vehicle) async {
    emit(const VehicleState.loading());

    final result = await _delete(vehicle.id);

    result.fold(
      (failure) => emit(VehicleState.error(message: failure.message)),
      // (_) => fetchVehicles(vehicle.userId),
      (_) => emit(VehicleState.success('Vehicle deleted successfully')),
    );
  }

  @override
  Future<void> close() async {
    _vehicleStream?.cancel();
    await super.close();
  } 
}

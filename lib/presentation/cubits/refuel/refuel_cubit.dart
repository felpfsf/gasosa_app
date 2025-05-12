import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/core/enums/crud_action.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/usecases/refuel/add_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/delete_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/find_refuel_by_id_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/update_refuel_usecase.dart';
import 'package:gasosa_app/domain/usecases/refuel/watch_all_refuels_by_vehicle_id_usecase.dart';
import 'package:injectable/injectable.dart';

import 'refuel_state.dart';

abstract class IRefuelCubit {
  void watchRefuels(String vehicleId);
  Future<void> addRefuel(Refuel refuel);
  Future<void> updateRefuel(Refuel refuel);
  Future<void> deleteRefuel(Refuel refuel);
  Future<Refuel?> findRefuelById(String id);
  Future<void> close();

  void fetchRefuelsMock();
}

@Injectable(as: IRefuelCubit)
class RefuelCubit extends Cubit<RefuelState> implements IRefuelCubit {
  final IWatchAllRefuelsByVehicleIdUsecase _watchAll;
  final IAddRefuelUsecase _add;
  final IDeleteRefuelUsecase _delete;
  final IFindRefuelByIdUsecase _findRefuelById;
  final IUpdateRefuelUsecase _update;

  RefuelCubit(this._add, this._delete, this._findRefuelById, this._update, this._watchAll)
    : super(const RefuelState.initial());

  StreamSubscription<List<Refuel>>? _refuelStream;

  @override
  void watchRefuels(String vehicleId) {
    emit(const RefuelState.loading());

    _refuelStream?.cancel();

    _refuelStream = _watchAll(vehicleId).listen(
      (refuels) => emit(RefuelState.loaded(refuels)),
      onError: (error) => emit(RefuelState.error(message: error.toString())),
    );
  }

  @override
  Future<void> addRefuel(Refuel refuel) async {
    emit(const RefuelState.loading());

    final result = await _add(refuel);

    result.fold(
      (failure) => emit(RefuelState.error(action: CrudAction.created, message: failure.message)),
      (_) => emit(RefuelState.success(action: CrudAction.created)),
    );
  }

  @override
  Future<void> deleteRefuel(Refuel refuel) async {
    emit(const RefuelState.loading());

    final result = await _delete(refuel.id);

    result.fold(
      (failure) => emit(RefuelState.error(action: CrudAction.deleted, message: failure.message)),
      (_) => emit(RefuelState.success(action: CrudAction.deleted)),
    );
  }

  @override
  Future<void> updateRefuel(Refuel refuel) async {
    emit(const RefuelState.loading());

    final result = await _update(refuel);

    result.fold(
      (failure) => emit(RefuelState.error(action: CrudAction.updated, message: failure.message)),
      (_) => emit(RefuelState.success(action: CrudAction.updated)),
    );
  }

  @override
  Future<Refuel?> findRefuelById(String id) {
    emit(const RefuelState.loading());

    return _findRefuelById(id).then((refuel) => refuel.fold((failure) => null, (refuel) => refuel));
  }

  @override
  void fetchRefuelsMock() {
    emit(RefuelState.loading());

    Future.delayed(const Duration(milliseconds: 800), () {
      emit(
        RefuelState.loaded([
          Refuel(
            id: '1',
            vehicleId: '1',
            date: DateTime.now().subtract(const Duration(days: 10)),
            fuelType: FuelType.gasoline,
            odometer: 10000,
            liters: 50,
            totalValue: 250,
            createdBy: 'mock-user',
            createdAt: DateTime.now(),
          ),
          Refuel(
            id: '2',
            vehicleId: '1',
            date: DateTime.now().subtract(const Duration(days: 5)),
            fuelType: FuelType.ethanol,
            odometer: 10100,
            liters: 40,
            totalValue: 200,
            createdBy: 'mock-user',
            createdAt: DateTime.now(),
          ),
          Refuel(
            id: '3',
            vehicleId: '2',
            date: DateTime.now().subtract(const Duration(days: 2)),
            fuelType: FuelType.diesel,
            odometer: 10200,
            liters: 60,
            totalValue: 300,
            createdBy: 'mock-user',
            createdAt: DateTime.now(),
          ),
          Refuel(
            id: '4',
            vehicleId: '2',
            date: DateTime.now(),
            fuelType: FuelType.gasoline,
            odometer: 10300,
            liters: 70,
            totalValue: 350,
            createdBy: 'mock-user',
            createdAt: DateTime.now(),
          ),
          Refuel(
            id: '5',
            vehicleId: '3',
            date: DateTime.now().subtract(const Duration(days: 10)),
            fuelType: FuelType.gasoline,
            odometer: 10400,
            liters: 80,
            totalValue: 400,
            createdBy: 'mock-user',
            createdAt: DateTime.now(),
          ),
          Refuel(
            id: '6',
            vehicleId: '3',
            date: DateTime.now().subtract(const Duration(days: 5)),
            fuelType: FuelType.ethanol,
            odometer: 10500,
            liters: 90,
            totalValue: 450,
            createdBy: 'mock-user',
            createdAt: DateTime.now(),
          ),
        ]),
      );
    });
  }
}

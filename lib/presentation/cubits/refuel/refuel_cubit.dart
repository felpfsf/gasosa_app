import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
}

@Injectable(as: IRefuelCubit)
class RefuelCubit extends Cubit<RefuelState> implements IRefuelCubit {
  final IWatchAllRefuelsByVehicleIdUsecase _watchAll;
  final IAddRefuelUsecase _add;
  final IDeleteRefuelUsecase _delete;
  final IFindRefuelByIdUsecase _findRefuelById;
  final IUpdateRefuelUsecase _update;

  RefuelCubit(
    this._add,
    this._delete,
    this._findRefuelById,
    this._update,
    this._watchAll,
  ) : super(const RefuelState.initial());

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
      (failure) => emit(RefuelState.error(message: failure.message)),
      (_) => emit(RefuelState.success('Refuel added successfully')),
    );
  }

  @override
  Future<void> deleteRefuel(Refuel refuel) async {
    emit(const RefuelState.loading());

    final result = await _delete(refuel.id);

    result.fold(
      (failure) => emit(RefuelState.error(message: failure.message)),
      (_) => emit(RefuelState.success('Refuel deleted successfully')),
    );
  }

  @override
  Future<void> updateRefuel(Refuel refuel) async {
    emit(const RefuelState.loading());

    final result = await _update(refuel);

    result.fold(
      (failure) => emit(RefuelState.error(message: failure.message)),
      (_) => emit(RefuelState.success('Refuel updated successfully')),
    );
  }

  @override
  Future<Refuel?> findRefuelById(String id) {
    emit(const RefuelState.loading());

    return _findRefuelById(
      id,
    ).then((refuel) => refuel.fold((failure) => null, (refuel) => refuel));
  }
}

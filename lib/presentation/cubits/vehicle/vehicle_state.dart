import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gasosa_app/core/enums/crud_action.dart';
import 'package:gasosa_app/domain/entities/vehicle_with_last_refuel.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';

part 'vehicle_state.freezed.dart';

@freezed
class VehicleState with _$VehicleState {
  const factory VehicleState.initial() = _Initial;
  const factory VehicleState.loading() = _Loading;
  const factory VehicleState.loaded(List<VehicleWithLastRefuel> vehicles) = _Loaded;
  const factory VehicleState.detail(VehicleWithLastRefuel vehicle) = _Detail;
  const factory VehicleState.success({required CrudAction action}) = _Success;
  const factory VehicleState.error({CrudAction? action, required String message}) = _Error;
}

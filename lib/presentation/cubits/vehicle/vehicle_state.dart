import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';

part 'vehicle_state.freezed.dart';

@freezed
class VehicleState with _$VehicleState {
  const factory VehicleState.initial() = _Initial;
  const factory VehicleState.loading() = _Loading;
  const factory VehicleState.loaded(List<Vehicle> vehicles) = _Loaded;
  const factory VehicleState.success(String message) = _Success;
  const factory VehicleState.error({required String message}) = _Error;
}

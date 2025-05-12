import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gasosa_app/core/enums/crud_action.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';

part 'refuel_state.freezed.dart';

@freezed
class RefuelState with _$RefuelState {
  const factory RefuelState.initial() = _Initial;
  const factory RefuelState.loading() = _Loading;
  const factory RefuelState.loaded(List<Refuel> refuels) = _Loaded;
  const factory RefuelState.success({required CrudAction action}) = _Success;
  const factory RefuelState.error({CrudAction? action, required String message}) = _Error;
}

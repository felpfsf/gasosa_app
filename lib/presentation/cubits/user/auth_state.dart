import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gasosa_app/domain/entities/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(String message) = _Success;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error({required String message}) = _Error;
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/usecases/user/load_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/save_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/update_user_usecase.dart';
import 'package:injectable/injectable.dart';

import 'auth_state.dart';

abstract class IAuthCubit {
  Future<void> loadUser(String userId);
  Future<void> saveUser(User user);
  Future<void> updateUser(User user);
  void logout();
}

@Injectable(as: IAuthCubit)
class AuthCubit extends Cubit<AuthState> implements IAuthCubit {
  final ILoadUserUsecase _loadUserUsecase;
  final ISaveUserUsecase _saveUserUsecase;
  final IUpdateUserUsecase _updateUserUsecase;

  AuthCubit(
    this._loadUserUsecase,
    this._saveUserUsecase,
    this._updateUserUsecase,
  ) : super(AuthState.initial());

  @override
  Future<void> loadUser(String userId) async {
    emit(const AuthState.loading());

    final result = await _loadUserUsecase(userId);

    result.fold((failure) => emit(AuthState.error(message: failure.message)), (
      user,
    ) {
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(AuthState.unauthenticated());
      }
    });
  }

  @override
  Future<void> saveUser(User user) async {
    emit(const AuthState.loading());

    final result = await _saveUserUsecase(user);

    result.fold(
      (failure) => emit(AuthState.error(message: failure.message)),
      (_) => emit(AuthState.success('Successfully saved user')),
    );
  }

  @override
  Future<void> updateUser(User user) async {
    emit(const AuthState.loading());

    final result = await _updateUserUsecase(user);

    result.fold(
      (failure) => emit(AuthState.error(message: failure.message)),
      (_) => emit(AuthState.success('Successfully updated user')),
    );
  }

  @override
  void logout() {
    emit(AuthState.unauthenticated());
  }
}

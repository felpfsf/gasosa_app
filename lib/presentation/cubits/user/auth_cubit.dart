import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/core/helpers/shared_preferences_helper.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/usecases/auth/login_with_email_usecase.dart';
import 'package:gasosa_app/domain/usecases/auth/logout_usecase.dart';
import 'package:gasosa_app/domain/usecases/auth/register_with_email_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/load_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/save_user_usecase.dart';
import 'package:gasosa_app/domain/usecases/user/update_user_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_state.dart';

abstract class IAuthCubit {
  Future<void> loadUser(String userId);
  Future<void> saveUser(User user);
  Future<void> updateUser(User user);
  void logout();
  Future<void> register(User user, String password);
  Future<void> login(String email, String password);
  Future<void> checkLogionStatus();
}

@Injectable(as: IAuthCubit)
class AuthCubit extends Cubit<AuthState> implements IAuthCubit {
  final ILoadUserUsecase _loadUserUsecase;
  final ISaveUserUsecase _saveUserUsecase;
  final IUpdateUserUsecase _updateUserUsecase;
  final ILoginWithEmailUsecase _loginWithEmailUsecase;
  final ILogoutUsecase _logoutUsecase;
  final IRegisterWithEmailUsecase _registerWithEmailUsecase;

  AuthCubit(
    this._loadUserUsecase,
    this._saveUserUsecase,
    this._updateUserUsecase,
    this._loginWithEmailUsecase,
    this._logoutUsecase,
    this._registerWithEmailUsecase,
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
  void logout() async {
    emit(AuthState.unauthenticated());
    final result = await _logoutUsecase();
    await removeUserId();
    result.fold(
      (failure) => emit(AuthState.error(message: failure.message)),
      (_) => emit(AuthState.unauthenticated()),
    );
  }

  @override
  Future<void> login(String email, String password) async {
    final result = await _loginWithEmailUsecase(email, password);

    result.fold((failure) => emit(AuthState.error(message: failure.message)), (
      user,
    ) async {
      await persistUserId(user.id);
      emit(AuthState.authenticated(user));
    });
  }

  @override
  Future<void> register(User user, String password) async {
    final result = await _registerWithEmailUsecase(user, password);

    await result.fold(
      (failure) async {
        emit(AuthState.error(message: failure.message));
      },
      (firebaseUser) async {
        final userEntity = User(
          id: firebaseUser.id,
          name: firebaseUser.name,
          email: firebaseUser.email,
          photoUrl: firebaseUser.photoUrl,
          createdAt: DateTime.now(),
        );

        final saveResult = await _saveUserUsecase(userEntity);

        await persistUserId(firebaseUser.id);

        saveResult.fold(
          (saveFailure) => emit(AuthState.error(message: saveFailure.message)),
          (_) => emit(AuthState.authenticated(userEntity)),
        );
      },
    );
  }

  @override
  Future<void> checkLogionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId != null) {
      await loadUser(userId);
    } else {
      emit(AuthState.unauthenticated());
    }
  }
}

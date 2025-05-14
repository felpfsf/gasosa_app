import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';

class AuthHelper {
  static String? getCurrentUserId(BuildContext context) {
    final state = context.read<AuthCubit>().state;

    return state.maybeWhen(authenticated: (user) => user.id, orElse: () => null);
  }

  static User getAuthenticatedUser(BuildContext context) {
  final state = context.read<AuthCubit>().state;

  return state.maybeWhen(
    authenticated: (user) => user,
    orElse: () => throw StateError('User is not authenticated'),
  );
}
}

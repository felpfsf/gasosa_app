import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/app/routes/route_names.dart';
import 'package:gasosa_app/app/routes/route_paths.dart';
import 'package:gasosa_app/core/di/injection.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/pages/auth/login_screen.dart';
import 'package:gasosa_app/presentation/pages/auth/register_screen.dart';
import 'package:gasosa_app/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:gasosa_app/presentation/pages/splash/splash_screen.dart';
import 'package:gasosa_app/presentation/pages/vehicles/register_vehicle_screen.dart';
import 'package:gasosa_app/presentation/pages/vehicles/vehicle_detail_screen.dart';
import 'package:go_router/go_router.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

final appRouter = GoRouter(
  observers: [routeObserver],
  initialLocation: RoutePaths.splash,
  // refreshListenable: GoRouterRefreshStream(getIt<AuthCubit>().stream),
  redirect: (context, state) {
    final authState = context.read<AuthCubit>().state;
    if (authState.maybeWhen(unauthenticated: () => true, orElse: () => false)) {
      return RoutePaths.login;
    }

    return null;

    // final authCubit = getIt<AuthCubit>();
    // final authState = authCubit.state;

    // final isLoggingIn = state.uri.toString() == RoutePaths.login || state.uri.toString() == RoutePaths.register;

    // if (authState.maybeWhen(unauthenticated: () => true, orElse: () => false)) {
    //   return isLoggingIn ? null : RoutePaths.login;
    // }

    // if (authState.maybeWhen(authenticated: (_) => true, orElse: () => false)) {
    //   return isLoggingIn ? RoutePaths.dashboard : null;
    // }

    // return null;
  },
  routes: [
    GoRoute(path: RoutePaths.splash, name: RouteNames.splash, builder: (context, state) => const SplashScreen()),
    GoRoute(path: RoutePaths.login, name: RouteNames.login, builder: (context, state) => const LoginScreen()),
    GoRoute(path: RoutePaths.register, name: RouteNames.register, builder: (context, state) => const RegisterScreen()),
    GoRoute(
      path: RoutePaths.dashboard,
      name: RouteNames.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: RoutePaths.registerVehicle,
      name: RouteNames.registerVehicle,
      builder: (context, state) => const RegisterVehicleScreen(),
    ),
    GoRoute(
      path: RoutePaths.vehicleDetail(':vehicleId'),
      name: RouteNames.vehicleDetail,
      builder: (context, state) {
        final vehicleId = state.pathParameters['vehicleId']!;
        return VehicleDetailScreen(vehicleId: vehicleId);
      },
    ),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

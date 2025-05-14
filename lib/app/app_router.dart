import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/app/routes/route_names.dart';
import 'package:gasosa_app/app/routes/route_paths.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/pages/auth/login_screen.dart';
import 'package:gasosa_app/presentation/pages/auth/register_screen.dart';
import 'package:gasosa_app/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:gasosa_app/presentation/pages/profile/user_profile_screen.dart';
import 'package:gasosa_app/presentation/pages/refuel/manage_refuel_screen.dart';
import 'package:gasosa_app/presentation/pages/splash/splash_screen.dart';
import 'package:gasosa_app/presentation/pages/vehicles/manage_vehicle_screen.dart';
import 'package:gasosa_app/presentation/pages/vehicles/vehicle_detail_screen.dart';
import 'package:go_router/go_router.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

GoRouter createGoRouter(BuildContext context) {
  return GoRouter(
    observers: [routeObserver],
    initialLocation: RoutePaths.splash,
    refreshListenable: GoRouterRefreshStream(context.read<AuthCubit>().stream),
    redirect: (context, state) {
      final authState = context.read<AuthCubit>().state;
      final isAuthenticated = authState.maybeWhen(authenticated: (_) => true, orElse: () => false);
      final isOnLogin = state.matchedLocation == RoutePaths.login || state.matchedLocation == RoutePaths.register;

      if (!isAuthenticated && !isOnLogin) {
        return RoutePaths.splash;
      }

      if (isAuthenticated && isOnLogin) {
        return RoutePaths.dashboard;
      }

      return null;
    },
    routes: [
      GoRoute(path: RoutePaths.splash, name: RouteNames.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RoutePaths.login, name: RouteNames.login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        name: RouteNames.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.manageVehicle,
        name: RouteNames.manageVehicle,
        builder: (context, state) {
          final vehicle = state.extra as Vehicle?;
          return ManageVehicleScreen(vehicle: vehicle);
        },
      ),
      GoRoute(
        path: RoutePaths.vehicleDetail(':vehicleId'),
        name: RouteNames.vehicleDetail,
        builder: (context, state) {
          final vehicleId = state.pathParameters['vehicleId']!;
          return VehicleDetailScreen(vehicleId: vehicleId);
        },
      ),
      GoRoute(
        path: RoutePaths.manageRefuel(':vehicleId'),
        name: RouteNames.manageRefuel,
        builder: (context, state) {
          final vehicleId = state.pathParameters['vehicleId']!;
          final refuel = state.extra as Refuel?;
          return ManageRefuelScreen(vehicleId: vehicleId, refuel: refuel);
        },
      ),
      GoRoute(
        path: RoutePaths.profile,
        name: RouteNames.profile,
        builder: (context, state) {
          final user = state.extra as User;
          return UserProfileScreen(user: user);
        },
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:gasosa_app/app/routes/route_names.dart';
import 'package:gasosa_app/app/routes/route_paths.dart';
import 'package:gasosa_app/presentation/pages/auth/login_screen.dart';
import 'package:gasosa_app/presentation/pages/auth/register_screen.dart';
import 'package:gasosa_app/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:gasosa_app/presentation/pages/splash/splash_screen.dart';
import 'package:gasosa_app/presentation/pages/vehicles/register_vehicle_screen.dart';
import 'package:gasosa_app/presentation/pages/vehicles/vehicle_detail_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  observers: [],
  initialLocation: RoutePaths.splash,
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

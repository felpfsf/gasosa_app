abstract class RoutePaths {
  static const splash = '/splash';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const dashboard = '/dashboard';

  static const manageVehicle = '/vehicles/manage';
  static String vehicleDetail(String vehicleId) => '/vehicles/detail/$vehicleId';

  static String manageRefuel(String vehicleId) => '/refuel/manage/$vehicleId';

  static String profile = '/profile';
}
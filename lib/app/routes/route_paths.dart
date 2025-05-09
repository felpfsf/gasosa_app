abstract class RoutePaths {
  static const splash = '/splash';
  static const login = '/auth/login';
  static const register = '/auth/register';
  static const dashboard = '/dashboard';

  static const registerVehicle = '/vehicles/register';
  static String vehicleDetail(String vehicleId) => '/vehicles/detail/$vehicleId';

  static String registerRefuel(String vehicleId) => '/refuel/register/$vehicleId';
}
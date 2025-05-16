import 'package:gasosa_app/domain/entities/fuel_type.dart';

List<FuelType> avaliableFuelTypeForRefuel() {
  return FuelType.values.where((e) => e != FuelType.flex).toList();
}

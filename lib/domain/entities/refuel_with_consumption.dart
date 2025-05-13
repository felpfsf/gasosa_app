import 'package:gasosa_app/domain/entities/refuel.dart';

class RefuelWithConsumption {
  final Refuel refuel;
  final double? consumption;
  final double? distance;

  RefuelWithConsumption({required this.refuel, this.consumption, this.distance});
}

import 'package:collection/collection.dart';
import 'package:gasosa_app/core/helpers/calculate_consumption.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/domain/entities/refuel_with_consumption.dart';

List<RefuelWithConsumption> mapToRefuelsWithConsumption(List<Refuel> refuels) {
  final sorted = refuels.sortedBy((r) => r.date);

  final result = <RefuelWithConsumption>[];

  for (var i = 0; i < sorted.length; i++) {
    final current = sorted[i];

    if (i == 0) {
      result.add(RefuelWithConsumption(refuel: current));
    } else {
      final previous = sorted[i - 1];

      final distance = current.odometer - previous.odometer;

      final consumption = calculateConsumption(
        currentOdometer: current.odometer,
        previousOdometer: previous.odometer,
        liters: current.liters,
      );

      result.add(RefuelWithConsumption(refuel: current, consumption: consumption, distance: distance));
    }
  }

  return result;
}

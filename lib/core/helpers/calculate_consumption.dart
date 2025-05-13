double calculateConsumption({
  required double previousOdometer,
  required double currentOdometer,
  required double liters,
}) {
  final distance = currentOdometer - previousOdometer;
  if (distance <= 0 || liters <= 0) return 0;
  return distance / liters;
}

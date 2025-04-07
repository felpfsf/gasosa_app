class Refuel {
  final String id;
  final String vehicleId;
  final DateTime date;
  final double odometer;
  final String fuelType;
  final double liters;
  final double totalValue;
  final double? pricePerLiter;
  final double? coldStartLitters;
  final String? noteImageUrl;
  final bool isSynced;
  final DateTime createdAt;

  Refuel({
    required this.id,
    required this.vehicleId,
    required this.date,
    required this.odometer,
    required this.fuelType,
    required this.liters,
    required this.totalValue,
    this.pricePerLiter,
    this.coldStartLitters,
    this.noteImageUrl,
    this.isSynced = false,
    required this.createdAt,
  });
}

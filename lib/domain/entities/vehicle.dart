class Vehicle {
  final String id;
  final String name;
  final String? plate;
  final String fuelType;
  final DateTime createdAt;

  Vehicle({
    required this.id,
    required this.name,
    this.plate,
    required this.fuelType,
    required this.createdAt,
  });
}

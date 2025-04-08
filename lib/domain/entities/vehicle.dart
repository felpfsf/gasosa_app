class Vehicle {
  final String id;
  final String name;
  final String? plate;
  final String fuelType;
  final String userId;
  final DateTime createdAt;
  final String? updatedBy;
  final DateTime? updatedAt;

  Vehicle({
    required this.id,
    required this.name,
    this.plate,
    required this.fuelType,
    required this.userId,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });
}

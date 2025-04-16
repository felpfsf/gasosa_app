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

  Vehicle copyWith({
    String? name,
    String? plate,
    String? fuelType,
    DateTime? updatedAt,
    String? updatedBy,
  }) {
    return Vehicle(
      id: id,
      userId: userId,
      name: name ?? this.name,
      plate: plate ?? this.plate,
      fuelType: fuelType ?? this.fuelType,
      createdAt: createdAt,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

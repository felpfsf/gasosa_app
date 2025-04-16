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
  final String createdBy;
  final DateTime createdAt;
  final String? updatedBy;
  final DateTime? updatedAt;

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
    required this.createdBy,
    required this.createdAt,
    this.updatedBy,
    this.updatedAt,
  });

  Refuel copyWith({
    DateTime? date,
    double? odometer,
    double? liters,
    String? fuelType,
    double? pricePerLiter,
    double? coldStartLitters,
    double? totalValue,
    String? noteImageUrl,
    bool? isSynced,
    String? updatedBy,
    DateTime? updatedAt,
  }) {
    return Refuel(
      id: id,
      vehicleId: vehicleId,
      date: date ?? this.date,
      odometer: odometer ?? this.odometer,
      fuelType: fuelType ?? this.fuelType,
      liters: liters ?? this.liters,
      totalValue: totalValue ?? this.totalValue,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      coldStartLitters: coldStartLitters ?? this.coldStartLitters,
      noteImageUrl: noteImageUrl ?? this.noteImageUrl,
      isSynced: isSynced ?? this.isSynced,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

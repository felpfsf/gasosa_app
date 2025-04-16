import 'package:mocktail/mocktail.dart';

import 'fake_classes.dart';

void registerFallbacks() {
  registerFallbackValue(
    // Refuel(
    //   id: 'fallback-id',
    //   vehicleId: 'fallback-vehicle',
    //   date: DateTime(2000),
    //   odometer: 0.0,
    //   fuelType: 'fallback',
    //   liters: 0.0,
    //   totalValue: 0.0,
    //   pricePerLiter: 0.0,
    //   coldStartLitters: null,
    //   noteImageUrl: null,
    //   isSynced: false,
    //   createdAt: DateTime(2000),
    // ),
    FakeRefuel(),
  );

  registerFallbackValue(FakeVehicle());
}

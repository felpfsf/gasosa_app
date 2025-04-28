import 'package:flutter/material.dart';
import 'package:gasosa_app/domain/entities/vehicle_with_last_refuel.dart';
import 'package:gasosa_app/presentation/pages/dashboard/widgets/vehicle_card_widget.dart';
import 'package:gasosa_app/theme/app_spacing.dart';

class VehicleListWidget extends StatelessWidget {
  final List<VehicleWithLastRefuel> vehicles;

  const VehicleListWidget({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => AppSpacing.gap16,
      shrinkWrap: true,
      itemCount: vehicles.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return VehicleCardWidget(vehicle: vehicle);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gasosa_app/domain/entities/vehicle_with_last_refuel.dart';
import 'package:gasosa_app/presentation/pages/dashboard/widgets/vehicle_card_widget.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_typography.dart';

// TODO: SERIA MELHOR ALTERAR A COR DE BACKGROUND ???
class VehicleDetailHeader extends StatelessWidget {
  final VehicleWithLastRefuel vehicle;
  const VehicleDetailHeader({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return GasosaCard(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        spacing: AppSpacing.sm,
        children: [
          Text(vehicle.name, style: AppTypography.titleMd),
          if (vehicle.plate != null)
            Text(vehicle.plate!, style: AppTypography.textSmRegular, overflow: TextOverflow.ellipsis),
          Row(
            spacing: AppSpacing.sm,
            children: [Icon(Icons.local_gas_station), FuelTypeBadge(fuelType: vehicle.fuelType)],
          ),
          Row(
            spacing: AppSpacing.sm,
            children: [
              Icon(Icons.calendar_month),
              RichText(
                text: TextSpan(
                  style: AppTypography.textSmRegular,
                  text: 'Último abastecimento: ',
                  children: [TextSpan(text: vehicle.formattedLastRefuelDate, style: AppTypography.textSmBold)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

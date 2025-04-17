import 'package:flutter/material.dart';
import 'package:gasosa_app/data/local/dabase.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onTap;

  const VehicleCard({super.key, required this.vehicle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GasosaCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(vehicle.name, style: AppTypography.titleSm),
          AppSpacing.gap4,
          Text(
            '${vehicle.fuelType} • ${vehicle.plate ?? 'Sem placa'}',
            style: AppTypography.textSmRegular,
          ),
          AppSpacing.gap8,
          Text(
            'Último abastecimento: --/--/----',
            style: AppTypography.textSmMedium,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gasosa_app/domain/entities/vehicle_with_last_refuel.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class VehicleCardWidget extends StatelessWidget {
  final VehicleWithLastRefuel vehicle;

  const VehicleCardWidget({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return GasosaCard(
      onTap: () {},
      color: Colors.white,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                Row(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(vehicle.name, style: AppTypography.titleSm.copyWith(color: AppColors.border)),
                    if (vehicle.plate != null)
                      Text('• ${vehicle.plate!}', style: AppTypography.textSmRegular.copyWith(color: AppColors.border)),
                  ],
                ),
                Row(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_gas_station, color: AppColors.border),
                    Text(vehicle.fuelType, style: AppTypography.textMdRegular.copyWith(color: AppColors.border)),
                  ],
                ),
                Row(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_month, color: AppColors.border, size: 16),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: AppTypography.textSmRegular.copyWith(color: AppColors.border),
                          children: [
                            TextSpan(text: 'Último abastecimento: '),
                            TextSpan(
                              text: vehicle.formattedLastRefuelDate,
                              style: AppTypography.textSmBold.copyWith(color: AppColors.border),
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: AppColors.border),
        ],
      ),
    );
  }
}

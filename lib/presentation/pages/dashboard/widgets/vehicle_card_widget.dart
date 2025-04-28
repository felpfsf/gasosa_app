import 'package:flutter/material.dart';
import 'package:gasosa_app/domain/entities/vehicle.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class VehicleCardWidget extends StatelessWidget {
  final Vehicle vehicle;

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
                    Text(
                      vehicle.name,
                      style: AppTypography.titleSm.copyWith(
                        color: AppColors.border,
                      ),
                    ),
                    if (vehicle.plate != null)
                      Text(
                        vehicle.plate!,
                        style: AppTypography.textSmRegular.copyWith(
                          color: AppColors.border,
                        ),
                      ),
                  ],
                ),
                Row(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_gas_station,
                      color: AppColors.border,
                    ),
                    Text(
                      vehicle.fuelType,
                      style: AppTypography.textMdRegular.copyWith(
                        color: AppColors.border,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Último abastecimento:',
                      style: AppTypography.textMdRegular.copyWith(
                        color: AppColors.border,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_month,
                      color: AppColors.border,
                      size: 16,
                    ),
                    Text(
                      '12/10/2023',
                      style: AppTypography.textMdRegular.copyWith(
                        color: AppColors.border,
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

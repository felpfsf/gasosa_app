import 'package:flutter/material.dart';
import 'package:gasosa_app/core/extensions/fuel_type_extensions.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/vehicle_with_last_refuel.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class VehicleCardWidget extends StatelessWidget {
  final VehicleWithLastRefuel vehicle;

  const VehicleCardWidget({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return GasosaCard(
      onTap: () async {
        context.push('/vehicles/detail/${vehicle.id}');
      },
      color: Colors.white,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.sm,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppSpacing.sm,
                  children: [
                    Text(
                      vehicle.name,
                      style: AppTypography.titleSm.copyWith(color: AppColors.border),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (vehicle.plate != null)
                      Text(
                        '• ${vehicle.plate!}',
                        style: AppTypography.textSmRegular.copyWith(color: AppColors.border),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
                Wrap(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.local_gas_station, color: AppColors.border, size: 18),
                    // Text(
                    //   vehicle.fuelType,
                    //   style: AppTypography.textMdRegular.copyWith(color: AppColors.border),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    FuelTypeBadge(fuelType: vehicle.fuelType),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppSpacing.sm,
                  children: [
                    const Icon(Icons.calendar_month, color: AppColors.border, size: 18),
                    Flexible(
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

class FuelTypeBadge extends StatelessWidget {
  final FuelType fuelType;

  const FuelTypeBadge({super.key, required this.fuelType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: .1), borderRadius: AppSpacing.radiusMd),
      child: Text(fuelType.label, style: AppTypography.textSmBold.copyWith(color: AppColors.primary)),
    );
  }
}

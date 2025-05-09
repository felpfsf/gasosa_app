import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gasosa_app/app/routes/route_paths.dart';
import 'package:gasosa_app/core/extensions/datetime_extensions.dart';
import 'package:gasosa_app/core/extensions/fuel_type_extensions.dart';
import 'package:gasosa_app/domain/entities/refuel.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RefuelCard extends StatelessWidget {
  final Refuel refuel;

  const RefuelCard({super.key, required this.refuel});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'pt_BR');

    final pricePerLiter = refuel.pricePerLiter?.toStringAsFixed(2) ?? '';
    final liters = refuel.liters.toStringAsFixed(2);
    final totalRefueledValue = currency.format(refuel.totalValue);

    void onEditPressed() {
      context.push(RoutePaths.manageRefuel(refuel.vehicleId), extra: refuel);
    }

    void onDeletePressed() {
      context.read<RefuelCubit>().deleteRefuel(refuel);
    }

    return GasosaCard(
      enableSwipeActions: true,
      slideActions: [
        SlidableAction(
          label: 'Editar',
          icon: Icons.edit,
          backgroundColor: AppColors.primary,
          onPressed: (_) => onEditPressed(),
        ),
        SlidableAction(
          label: 'Excluir',
          icon: Icons.delete,
          backgroundColor: AppColors.error,
          onPressed: (_) => onDeletePressed(),
        ),
      ],
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        spacing: AppSpacing.sm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(refuel.date.formattedDate(), style: AppTypography.textSmBold),
              Row(
                spacing: AppSpacing.xs,
                children: [
                  Icon(Icons.local_gas_station),
                  Text(refuel.fuelType.label, style: AppTypography.textSmRegular),
                ],
              ),
            ],
          ),
          Divider(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: AppSpacing.sm,
            children: [
              Text('$liters L', style: AppTypography.textSmRegular),
              if (pricePerLiter.isNotEmpty) Text('$pricePerLiter/L', style: AppTypography.textSmBold),
              Text(totalRefueledValue, style: AppTypography.textSmBold),
            ],
          ),
          AppSpacing.gap4,
          Text('KM Atual: ${refuel.odometer} km', style: AppTypography.textSmRegular),
        ],
      ),
    );
  }
}

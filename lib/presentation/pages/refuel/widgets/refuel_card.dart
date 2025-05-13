import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gasosa_app/app/routes/route_paths.dart';
import 'package:gasosa_app/core/extensions/datetime_extensions.dart';
import 'package:gasosa_app/core/extensions/fuel_type_extensions.dart';
import 'package:gasosa_app/core/helpers/dialog_helper.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/refuel_with_consumption.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RefuelCard extends StatelessWidget {
  final RefuelWithConsumption item;

  const RefuelCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'pt_BR');

    final pricePerLiter = item.refuel.pricePerLiter?.toStringAsFixed(2) ?? '';
    final liters = item.refuel.liters.toStringAsFixed(2);
    final totalRefueledValue = currency.format(item.refuel.totalValue);
    final unit = item.refuel.fuelType == FuelType.gnv ? 'm³' : 'L';
    final consumptionLabel = 'Consumo: ${item.consumption?.toStringAsFixed(1)} km/$unit';

    void onEditPressed() {
      context.push(RoutePaths.manageRefuel(item.refuel.vehicleId), extra: item.refuel);
    }

    void onDeletePressed() async {
      final confirm = await showGasosaConfirmDialog(
        context: context,
        title: 'Excluir abastecimento do dia ${item.refuel.date.formattedDate()}?',
        message: 'Essa ação não poderá ser desfeita.',
        confirmText: 'Excluir',
        cancelText: 'Cancelar',
      );

      if (confirm) {
        if (!context.mounted) return;
        context.read<RefuelCubit>().deleteRefuel(item.refuel);
      }
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
              Text(item.refuel.date.formattedDate(), style: AppTypography.textSmBold),
              Row(
                spacing: AppSpacing.xs,
                children: [
                  Icon(Icons.local_gas_station),
                  Text(item.refuel.fuelType.label, style: AppTypography.textSmRegular),
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
          Text('KM Atual: ${item.refuel.odometer} km', style: AppTypography.textSmRegular),
          if (item.consumption != null) ...[
            Divider(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Distância Percorrida: ${item.distance} km', style: AppTypography.textSmRegular),
                Row(children: [Icon(Icons.car_repair), Text(consumptionLabel, style: AppTypography.textSmRegular)]),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gasosa_app/app/routes/route_paths.dart';
import 'package:gasosa_app/core/extensions/datetime_extensions.dart';
import 'package:gasosa_app/core/extensions/fuel_type_extensions.dart';
import 'package:gasosa_app/core/helpers/dialog_helper.dart';
import 'package:gasosa_app/core/helpers/formatters.dart';
import 'package:gasosa_app/domain/entities/fuel_type.dart';
import 'package:gasosa_app/domain/entities/refuel_with_consumption.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_card.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_image_preview.dart';
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
    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    final pricePerLiter = item.refuel.pricePerLiter?.toStringAsFixed(2) ?? '';
    final liters = item.refuel.liters.toStringAsFixed(2);
    final totalRefueledValue = currency.format(item.refuel.totalValue);

    final unit = item.refuel.fuelType == FuelType.gnv ? 'm³' : 'L';
    final consumptionLabel = formatConsumption(item.consumption, unit);

    final distanceLabel = formatDistance(item.distance);

    final hasColdStart = item.refuel.coldStartLiters != null && item.refuel.coldStartValue != null;

    final coldStartLiters = item.refuel.coldStartLiters?.toStringAsFixed(2) ?? '';
    final coldStartValue = item.refuel.coldStartValue?.toStringAsFixed(2) ?? '';

    final hasNoteImage = item.refuel.noteImageUrl != null;

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
        context.read<VehicleCubit>().fetchVehicleById(item.refuel.vehicleId);
      }
    }

    Future<void> openFullImage(BuildContext context, String imagePath, {String? heroTag}) {
      // return showDialog(
      //   context: context,
      //   barrierColor: AppColors.surface,
      //   builder: (_) {
      //     return GasosaImagePreview(imageUrl: imagePath, heroTag: heroTag);
      //   },
      // );
      return Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          barrierDismissible: true,
          barrierColor: AppColors.background,
          pageBuilder: (context, animation, secondaryAnimation) => GasosaImagePreview(imageUrl: imagePath, heroTag: heroTag),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
                child: child,
              ),
            );
          },
        )
      );
    }

    // Future<void> openGasosaImagePreview(BuildContext context, String imagePath, {String? heroTag}) {
    //   return Navigator.of(context).push(
    //     PageRouteBuilder(
    //       opaque: false,
    //       barrierDismissible: true,
    //       barrierColor: Colors.black.withOpacity(0.8),
    //       pageBuilder: (_, __, ___) => GasosaImagePreview(imageUrl: imagePath, heroTag: heroTag),
    //       transitionsBuilder: (_, animation, __, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: ScaleTransition(
    //             scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
    //             child: child,
    //           ),
    //         );
    //       },
    //     ),
    //   );
    // }

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
          Text('Km Atual: ${item.refuel.odometer.toStringAsFixed(0)} km', style: AppTypography.textSmRegular),
          if (item.consumption != null) ...[
            Divider(height: AppSpacing.md),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.xs,
              children: [
                Row(
                  spacing: AppSpacing.xs,
                  children: [
                    Icon(Icons.route),
                    Text('Distância Percorrida: $distanceLabel', style: AppTypography.textSmRegular),
                  ],
                ),
                Row(
                  spacing: AppSpacing.xs,
                  children: [Icon(Icons.speed), Text('Consumo: $consumptionLabel', style: AppTypography.textSmRegular)],
                ),
              ],
            ),
          ],
          if (hasColdStart) ...[
            Divider(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: AppSpacing.sm,
              children: [
                Text('Abastecimento Partida a Frio', style: AppTypography.textSmRegular),
                Text('$coldStartLiters L', style: AppTypography.textSmBold),
                Text('$coldStartValue R\$', style: AppTypography.textSmBold),
              ],
            ),
          ],
          if (hasNoteImage) ...[
            Divider(height: AppSpacing.md),
            Column(
              spacing: AppSpacing.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nota', style: AppTypography.textSmBold),
                ClipRRect(
                  borderRadius: AppSpacing.radiusSm,
                  child: GestureDetector(
                    onTap:
                        () =>
                            openFullImage(context, item.refuel.noteImageUrl!, heroTag: 'note-image-${item.refuel.id}'),
                    child: Hero(
                      tag: 'note-image-${item.refuel.id}',
                      child: Image.file(
                        File(item.refuel.noteImageUrl!),
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

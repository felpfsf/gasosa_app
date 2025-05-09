import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_cubit.dart';
import 'package:gasosa_app/presentation/cubits/refuel/refuel_state.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_state.dart';
import 'package:gasosa_app/presentation/pages/refuel/widgets/refuel_card.dart';
import 'package:gasosa_app/presentation/pages/vehicles/widgets/vehicle_detail_header.dart';
import 'package:gasosa_app/presentation/widgets/custom_loader.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_appbar.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_empty_state_widget.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_error_widget.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class VehicleDetailScreen extends StatefulWidget {
  final String vehicleId;
  const VehicleDetailScreen({super.key, required this.vehicleId});

  @override
  State<VehicleDetailScreen> createState() => _VehicleDetailScreenState();
}

class _VehicleDetailScreenState extends State<VehicleDetailScreen> {
  @override
  void initState() {
    final vehicle = context.read<VehicleCubit>();
    final refuelCubit = context.read<RefuelCubit>();

    vehicle.fetchVehicleById(widget.vehicleId);
    // refuelCubit.watchRefuels(widget.vehicleId);
    refuelCubit.fetchRefuelsMock();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GasosaAppbar(
        title: 'Detalhes do veículo',
        showBackButton: true,
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: Column(
        spacing: AppSpacing.md,
        children: [
          BlocBuilder<VehicleCubit, VehicleState>(
            builder: (context, state) {
              return state.maybeWhen(
                detail: (vehicle) => VehicleDetailHeader(vehicle: vehicle),
                orElse:
                    // () => CustomLoader<VehicleCubit, VehicleState>(selector: (_) => true, isOverlay: true, size: 48),
                    () => CircularProgressIndicator(),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<RefuelCubit, RefuelState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading:
                      () => CustomLoader<RefuelCubit, RefuelState>(selector: (_) => true, isOverlay: true, size: 48),
                  loaded: (refuels) {
                    if (refuels.isEmpty) {
                      return GaososaEmptyStateWidget(
                        title: 'Nenhum abastecimento encontrado',
                        actionLabel: 'Registrar abastecimento',
                        onPressed: () {},
                      );
                    }

                    return ListView.separated(
                      itemCount: refuels.length,
                      separatorBuilder: (_, __) => AppSpacing.gap16,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        final refuel = refuels[index];
                        return RefuelCard(refuel: refuel);
                      },
                    );
                  },

                  success: (_) => const SizedBox.shrink(),
                  error: (message) => GasosaErrorWidget(message: 'Erro ao carregar abastecimentos: $message'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/refuel/register/${widget.vehicleId}');
        },
        tooltip: 'Registrar abastecimento',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, color: AppColors.text),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/app/app_router.dart';
import 'package:gasosa_app/app/routes/route_paths.dart';
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

class _VehicleDetailScreenState extends State<VehicleDetailScreen> with RouteAware {
  @override
  void initState() {
    // refuelCubit.fetchRefuelsMock();
    _loadVehicle();

    super.initState();
  }

  @override
  void didPopNext() {
    _loadVehicle();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void _loadVehicle() {
    final vehicle = context.read<VehicleCubit>();
    final refuelCubit = context.read<RefuelCubit>();

    vehicle.fetchVehicleById(widget.vehicleId);
    refuelCubit.watchRefuels(widget.vehicleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<VehicleCubit, VehicleState>(
          builder: (context, state) {
            return GasosaAppbar(
              title: 'Detalhes do veículo',
              showBackButton: true,
              leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_rounded)),
              actions: [
                state.maybeWhen(
                  detail:
                      (item) => IconButton(
                        onPressed: () {
                          context.push(RoutePaths.manageVehicle, extra: item.vehicle);
                        },
                        icon: Icon(Icons.edit),
                      ),
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ),
      body: Column(
        spacing: AppSpacing.md,
        children: [
          BlocBuilder<VehicleCubit, VehicleState>(
            builder: (context, state) {
              return state.maybeWhen(
                detail: (vehicle) => VehicleDetailHeader(key: ValueKey(vehicle.id + vehicle.name), vehicle: vehicle),
                orElse: () {
                  // CustomLoader<VehicleCubit, VehicleState>(selector: (_) => true, isOverlay: true, size: 48),
                  return const CircularProgressIndicator();
                },
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
                        onPressed: () {
                          context.push(RoutePaths.manageRefuel(widget.vehicleId));
                        },
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
                  error: (_, message) => GasosaErrorWidget(message: 'Erro ao carregar abastecimentos: $message'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePaths.manageRefuel(widget.vehicleId));
        },
        tooltip: 'Registrar abastecimento',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, color: AppColors.text),
      ),
    );
  }
}

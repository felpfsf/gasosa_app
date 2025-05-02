import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/domain/entities/vehicle_with_last_refuel.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_state.dart';
import 'package:gasosa_app/presentation/pages/dashboard/widgets/vehicle_list_widget.dart';
import 'package:gasosa_app/presentation/widgets/custom_loader.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_appbar.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_empty_state_widget.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_error_widget.dart';
import 'package:gasosa_app/presentation/widgets/messages.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    final user = context.read<AuthCubit>().state.maybeWhen(authenticated: (user) => user, orElse: () => null);

    if (user != null) {
      context.read<VehicleCubit>().fetchVehicles(user.id);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;

    String username = authState.maybeWhen(authenticated: (user) => user.name, orElse: () => 'Usuário');

    Future<void> logout() async {
      await context.read<AuthCubit>().logout();
    }

    return Scaffold(
      appBar: GasosaAppbar(
        title: 'Bem vindo, $username',
        centerTitle: true,
        showBackButton: true,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [IconButton(onPressed: () => logout(), icon: const Icon(Icons.logout))],
      ),
      body: BlocConsumer<VehicleCubit, VehicleState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              Messages.showError(context, 'Erro ao carregar os veículos: $message');
            },
          );
        },
        listenWhen: (_, __) => false, // não ouvimos eventos aqui
        builder: (context, state) {
          return BlocBuilder<VehicleCubit, VehicleState>(
            buildWhen: (previous, current) => true,
            builder: (context, current) {
              final isLoading = current.maybeWhen(loading: () => true, orElse: () => false);
              final wasLoaded = state.maybeWhen(loaded: (_) => true, orElse: () => false);

              if (isLoading && wasLoaded) {
                final List<VehicleWithLastRefuel> vehicles = state.maybeWhen(loaded: (v) => v, orElse: () => []);

                return Stack(
                  children: [
                    _buildVehicleList(vehicles),
                    CustomLoader<VehicleCubit, VehicleState>(selector: (_) => true, isOverlay: true, size: 48),
                  ],
                );
              }

              return current.when(
                initial: () => const SizedBox.shrink(),
                loading:
                    () => CustomLoader<VehicleCubit, VehicleState>(selector: (_) => true, isOverlay: true, size: 48),
                error: (message) => GasosaErrorWidget(message: message),
                success: (_) => const SizedBox.shrink(),
                loaded: (vehicles) => _buildVehicleList(vehicles),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/vehicles/register'),
        tooltip: 'Adicionar veículo',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, color: AppColors.text),
      ),
    );
  }

  Widget _buildVehicleList(List<VehicleWithLastRefuel> vehicles) {
    if (vehicles.isEmpty) {
      return GaososaEmptyStateWidget(
        title: 'Nenhum veículo encontrado',
        message: 'Você ainda não possui nenhum veículo cadastrado.',
        actionLabel: 'Adicionar veículo',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.md,
        children: [Text('Seus veículos', style: AppTypography.titleMd), VehicleListWidget(vehicles: vehicles)],
      ),
    );
  }
}

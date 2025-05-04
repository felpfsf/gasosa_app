import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/app/app_router.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_state.dart';
import 'package:gasosa_app/presentation/pages/dashboard/widgets/vehicle_list_widget.dart';
import 'package:gasosa_app/presentation/widgets/custom_loader.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_appbar.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_empty_state_widget.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_error_widget.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with RouteAware {
  @override
  void initState() {
    _loadVehicles();

    super.initState();
  }

  @override
  void didPopNext() {
    _loadVehicles();
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

  void _loadVehicles() {
    final user = context.read<AuthCubit>().state.maybeWhen(authenticated: (user) => user, orElse: () => null);

    if (user != null) {
      context.read<VehicleCubit>().fetchVehicles(user.id);
    }
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
      body: BlocBuilder<VehicleCubit, VehicleState>(
        builder: (context, state) {
          return state.when(
            detail: (_) => const SizedBox.shrink(),
            initial: () => const SizedBox.shrink(),
            loading: () => CustomLoader<VehicleCubit, VehicleState>(selector: (_) => true, isOverlay: true, size: 48),
            error: (message) => GasosaErrorWidget(message: message),
            success: (_) => const SizedBox.shrink(),
            loaded: (vehicles) {
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
                  children: [
                    Text('Seus veículos', style: AppTypography.titleMd),
                    VehicleListWidget(vehicles: vehicles),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/vehicles/register');
        },
        tooltip: 'Adicionar veículo',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, color: AppColors.text),
      ),
    );
  }
}

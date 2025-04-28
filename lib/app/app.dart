import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/app/app_router.dart';
import 'package:gasosa_app/core/config/app_config.dart';
import 'package:gasosa_app/core/di/injection.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_state.dart';
import 'package:gasosa_app/presentation/cubits/vehicle/vehicle_cubit.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:gasosa_app/theme/app_typography.dart';
import 'package:super_banners/super_banners.dart';

class GasosaApp extends StatelessWidget {
  const GasosaApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget app = MaterialApp.router(
      title: 'Gasosa App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
    app = MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<IAuthCubit>() as AuthCubit),
        BlocProvider(
          create: (context) => getIt<IVehicleCubit>() as VehicleCubit,
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listenWhen:
            (previous, current) => current == const AuthState.unauthenticated(),
        listener: (context, state) {},
        child: app,
      ),
    );

    if (AppConfig.isDev) {
      // app = Directionality(
      //   textDirection: TextDirection.ltr,
      //   child: Banner(
      //     message: 'DEV MODE',
      //     location: BannerLocation.topStart,
      //     color: AppColors.primary,
      //     textStyle: AppTypography.textSmRegular,
      //     child: app,
      //   ),
      // );

      app = Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            app,
            CornerBanner(
              bannerColor: AppColors.primary,
              bannerPosition: CornerBannerPosition.topLeft,
              child: Text('DEV MODE', style: AppTypography.textSmRegular),
            ),
          ],
        ),
      );
    }

    return app;
  }
}

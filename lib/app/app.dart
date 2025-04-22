import 'package:flutter/material.dart';
import 'package:gasosa_app/app/app_router.dart';
import 'package:gasosa_app/theme/app_theme.dart';

class GasosaApp extends StatelessWidget {
  const GasosaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gasosa App',
      debugShowCheckedModeBanner: true,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}

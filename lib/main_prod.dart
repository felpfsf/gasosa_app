import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gasosa_app/app/app.dart';
import 'package:gasosa_app/core/config/app_config.dart';
import 'package:gasosa_app/core/config/env.dart';
import 'package:gasosa_app/core/di/injection.dart';
import 'package:gasosa_app/firebase_options_dev.dart'; // todo change to prod later
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await initializeDateFormatting('pt_BR');
  await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AppConfig.setEnvironment(Env.production);
  runApp(const GasosaApp());
}

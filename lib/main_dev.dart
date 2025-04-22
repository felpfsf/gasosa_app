import 'package:flutter/material.dart';
import 'package:gasosa_app/app/app.dart';
import 'package:gasosa_app/core/config/app_config.dart';
import 'package:gasosa_app/core/config/env.dart';

void main() {
  AppConfig.setEnvironment(Env.development);
  runApp(GasosaApp());
}

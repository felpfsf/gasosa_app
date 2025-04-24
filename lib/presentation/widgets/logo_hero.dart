import 'package:flutter/material.dart';

class LogoHero extends StatelessWidget {
  final String tag;
  final String assetPath;
  final double size;

  const LogoHero({
    super.key,
    this.tag = 'app-logo',
    this.assetPath = 'assets/images/app_logo_novo.png',
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Image.asset(assetPath, width: size, height: size),
    );
  }
}

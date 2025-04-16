
import 'package:flutter/widgets.dart';

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: md);

  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(6));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(20));

  static const SizedBox gap4 = SizedBox(height: 4);
  static const SizedBox gap8 = SizedBox(height: 8);
  static const SizedBox gap16 = SizedBox(height: 16);
  static const SizedBox gap24 = SizedBox(height: 24);
}


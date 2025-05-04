import 'package:flutter/material.dart';
import 'package:gasosa_app/theme/app_typography.dart';

class GasosaAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;

  const GasosaAppbar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTypography.textSmBold),
      centerTitle: centerTitle,
      leading: showBackButton ? leading ?? BackButton(onPressed: () => Navigator.of(context).pop) : null,
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomLoader<B extends StateStreamable<S>, S> extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;
  final double size;
  final bool isOverlay;
  final Color overlayColor;

  const CustomLoader({
    super.key,
    required this.selector,
    this.size = 24,
    this.isOverlay = false,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 0.5),
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<B, S, bool>(
      selector: selector,
      builder: (context, loading) {
        if (!loading) return const SizedBox.shrink();

        final loader = Center(
          child: SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(),
          ),
        );

        if (isOverlay) {
          return SizedBox.expand(
            child: Stack(
              children: [
                Positioned.fill(child: ColoredBox(color: overlayColor)),
                Positioned.fill(child: loader),
              ],
            ),
          );
        }

        return loader;
      },
    );
  }
}

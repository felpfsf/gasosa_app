import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_state.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoAnimation;
  late AnimationController _textController;
  // late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // _textAnimation = CurvedAnimation(
    //   parent: _textController,
    //   curve: Curves.easeIn,
    // );

    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      _textController.forward();
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.read<AuthCubit>().checkLogionStatus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (_) => context.go('/dashboard'),
          unauthenticated: () => context.go('/auth/login'),
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            spacing: 24,
            mainAxisSize: MainAxisSize.min,
            children: [
              SlideTransition(
                position: _logoAnimation,
                child: Hero(
                  tag: 'app-logo',
                  child: Image.asset('assets/images/app_logo_novo.png'),
                ),
              ),
              // FadeTransition(
              //   opacity: _textAnimation,
              //   child: Text('Gasosa App', style: AppTypography.titleLg),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


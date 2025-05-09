import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_state.dart';
import 'package:go_router/go_router.dart';

const splashMinDuration = Duration(milliseconds: 1500);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<Offset> _logoAnimation;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool _animationDone = false;
  AuthState? _authState;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeInOutBack));

    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));

    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeController.forward();
      _logoController.forward();
    });

    context.read<AuthCubit>().checkLogionStatus();

    Future.delayed(splashMinDuration, () {
      _animationDone = true;
      _tryRedirect();
    });
  }

  void _tryRedirect() {
    if (!mounted || !_animationDone || _authState == null) return;

    _authState!.whenOrNull(
      authenticated: (_) => context.go('/dashboard'),
      unauthenticated: () => context.go('/auth/login'),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        _authState = state;
        _tryRedirect();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: SlideTransition(
              position: _logoAnimation,
              child: Hero(
                tag: 'app-logo',
                child: Image.asset('assets/images/app_logo_novo.png', width: 256, height: 256),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

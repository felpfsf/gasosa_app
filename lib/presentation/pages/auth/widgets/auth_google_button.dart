import 'package:flutter/material.dart';

class AuthGoogleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const AuthGoogleButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Image.asset('assets/images/google_logo.png', width: 20, height: 20),
      label: const Text('Entrar com Google'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

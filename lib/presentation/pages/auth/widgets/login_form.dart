import 'package:flutter/material.dart';
import 'package:gasosa_app/presentation/widgets/index.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:gasosa_app/theme/app_theme.dart';
import 'package:validatorless/validatorless.dart';

class LoginForm extends StatefulWidget {
  final void Function(String email, String password) onSubmit;

  const LoginForm({super.key, required this.onSubmit});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  bool _obscureText = true;

  void _onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      widget.onSubmit(_emailEC.text.trim(), _passwordEC.text.trim());
    }
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: AppSpacing.lg,
        children: [
          GasosaFormField(
            label: 'E-mail',
            controller: _emailEC,
            keyboardType: TextInputType.emailAddress,
            validator: Validatorless.multiple([
              Validatorless.required('E-mail é obrigatório'),
              Validatorless.email('E-mail inválido'),
            ]),
          ),
          GasosaFormField(
            label: 'Senha',
            controller: _passwordEC,
            keyboardType: TextInputType.text,
            obscureText: _obscureText,
            validator: Validatorless.multiple([
              Validatorless.required('Senha é obrigatória'),
              Validatorless.min(6, 'Senha deve ter no mínimo 6 caracteres'),
            ]),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              color: AppColors.text.withValues(alpha: .6),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),

          AppSpacing.gap8,
          GasosaButton(label: 'Cadastrar', onPressed: _onSubmit),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_password_field.dart';
import 'package:gasosa_app/presentation/widgets/index.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:validatorless/validatorless.dart';

class RegisterForm extends StatefulWidget {
  final void Function(String name, String email, String password) onSubmit;

  const RegisterForm({super.key, required this.onSubmit});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  final bool _obscureText = true;

  void _onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      final name = _nameEC.text.trim();
      final email = _emailEC.text.trim();
      final password = _passwordEC.text.trim();

      widget.onSubmit(name, email, password);
    }
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
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
            label: 'Nome',
            controller: _nameEC,
            validator: Validatorless.multiple([
              Validatorless.required('Nome é obrigatório'),
              Validatorless.min(3, 'Nome deve ter no mínimo 3 caracteres'),
            ]),
          ),
          GasosaFormField(
            label: 'E-mail',
            controller: _emailEC,
            keyboardType: TextInputType.emailAddress,
            validator: Validatorless.multiple([
              Validatorless.required('E-mail é obrigatório'),
              Validatorless.email('E-mail inválido'),
            ]),
          ),
          GasosaPasswordField(
            label: 'Senha',
            controller: _passwordEC,
            validator: Validatorless.multiple([
              Validatorless.required('Confirmar senha é obrigatória'),
              Validatorless.min(6, 'Senha deve ter no mínimo 6 caracteres'),
            ]),
          ),
          GasosaPasswordField(
            label: 'Confirmar senha',
            controller: _confirmPasswordEC,
            validator: Validatorless.multiple([
              Validatorless.required('Confirmar senha é obrigatória'),
              Validatorless.compare(_passwordEC, 'Senhas não coincidem'),
              Validatorless.min(6, 'Senha deve ter no mínimo 6 caracteres'),
            ]),
          ),
          AppSpacing.gap8,
          GasosaButton(label: 'Entrar', onPressed: _onSubmit),
        ],
      ),
    );
  }
}

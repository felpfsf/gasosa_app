import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gasosa_app/domain/entities/user.dart';
import 'package:gasosa_app/presentation/cubits/user/auth_cubit.dart';
import 'package:gasosa_app/presentation/widgets/gasosa_password_field.dart';
import 'package:gasosa_app/presentation/widgets/index.dart';
import 'package:gasosa_app/theme/app_spacing.dart';
import 'package:uuid/uuid.dart';
import 'package:validatorless/validatorless.dart';

class RegisterForm extends StatefulWidget {
  final bool isLoading;

  const RegisterForm({super.key, this.isLoading = false});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  void _onSubmit() {
    if (formKey.currentState?.validate() ?? false) {
      final name = _nameEC.text.trim();
      final email = _emailEC.text.trim();
      final password = _passwordEC.text.trim();

      final user = User(
        id: const Uuid().v4(),
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );

      context.read<AuthCubit>().register(user, password);
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
          GasosaButton(
            label: 'Entrar',
            onPressed: _onSubmit,
            isDisabled: widget.isLoading,
            
          ),
        ],
      ),
    );
  }
}

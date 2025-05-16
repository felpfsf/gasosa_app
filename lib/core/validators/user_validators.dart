import 'package:flutter/widgets.dart';
import 'package:validatorless/validatorless.dart';

class UserValidators {
  static final name = Validatorless.multiple([
    Validatorless.required('Nome do usuário é obrigatório'),
    Validatorless.min(3, 'Nome do usuário deve ter no mínimo 3 caracteres'),
    Validatorless.max(50, 'Nome do usuário deve ter no máximo 50 caracteres'),
  ]);

  static final email = Validatorless.multiple([
    Validatorless.required('Email é obrigatório'),
    Validatorless.min(3, 'Email deve ter no mínimo 3 caracteres'),
    Validatorless.max(50, 'Email deve ter no máximo 50 caracteres'),
    Validatorless.regex(RegExp(r'^[a-zA-Z0-9\s]+$'), 'Email deve conter apenas caracteres alfanuméricos'),
  ]);

  static final password = Validatorless.multiple([
    Validatorless.required('Senha é obrigatório'),
    Validatorless.min(6, 'Senha deve ter no mínimo 6 caracteres'),
    Validatorless.max(50, 'Senha deve ter no máximo 50 caracteres'),
  ]);

  static FormFieldValidator<String> confirmPassword(TextEditingController controller) {
    return Validatorless.multiple([
      Validatorless.required('Confirme a senha é obrigatório'),
      Validatorless.min(6, 'Confirme a senha deve ter no mínimo 6 caracteres'),
      Validatorless.max(50, 'Confirme a senha deve ter no máximo 50 caracteres'),
      Validatorless.compare(controller, 'As senhas não coincidem'),
    ]);
  }
}

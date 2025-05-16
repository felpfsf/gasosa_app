
import 'package:validatorless/validatorless.dart';

class VehicleValidators {
  static final name = Validatorless.multiple([
    Validatorless.required('Nome do veículo é obrigatório'),
    Validatorless.min(3, 'Nome do veículo deve ter no mínimo 3 caracteres'),
    Validatorless.max(50, 'Nome do veículo deve ter no máximo 50 caracteres'),
    Validatorless.regex(RegExp(r'^[a-zA-Z0-9\s]+$'), 'Nome do veículo deve conter apenas caracteres alfanuméricos'),
  ]);

  static final plate = Validatorless.multiple([
    Validatorless.required('Placa do veículo é obrigatório'),
    Validatorless.min(3, 'Placa do veículo deve ter no mínimo 3 caracteres'),
    Validatorless.max(50, 'Placa do veículo deve ter no máximo 50 caracteres'),
    Validatorless.regex(RegExp(r'^[a-zA-Z0-9\s]+$'), 'Placa do veículo deve conter apenas caracteres alfanuméricos'),
  ]);
}
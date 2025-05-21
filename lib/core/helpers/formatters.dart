import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:intl/intl.dart';

final litersInputFormatter = MaskedInputFormatter('##.###', allowedCharMatcher: RegExp(r'[0-9]'));
final decimalInputFormatter = MaskedInputFormatter('###.###', allowedCharMatcher: RegExp(r'[0-9]'));
final integerInputFormatter = MaskedInputFormatter('######', allowedCharMatcher: RegExp(r'[0-9]'));

final currencyInputFormatter = CurrencyInputFormatter(
  leadingSymbol: 'R\$',
  thousandSeparator: ThousandSeparator.Period,
  useSymbolPadding: true,
);

double parseMaskedInteger(String value) {
  final cleaned = value.replaceAll(RegExp(r'[^\d.]'), '');

  return double.tryParse(cleaned) ?? 0.0;
}

double parseMaskedCurrency(String value) {
  final cleaned = value
      .replaceAll('R\$', '')
      .replaceAll('.', '') 
      .replaceAll(',', '.') 
      .replaceAll(RegExp(r'[^\d.]'), '');

  return double.tryParse(cleaned) ?? 0.0;
}

double parseMaskedLiters(String value) {
  final cleaned = value
      .replaceAll(RegExp(r'[^\d.]'), '');

  return double.tryParse(cleaned) ?? 0.000;
}

String formatMaskedCurrency(double value) {
  return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
}

String formatMaskedLiters(double value) {
  final formatted = NumberFormat('#0.###', 'pt_BR').format(value);
  return formatted.replaceAll(',', '.');
}

String formatDistance(double? distance) {
  if (distance == null) return '-';
  if (distance < 1.0) return '${(distance * 1000).round()} m';
  return '${distance.toStringAsFixed(0)} km';
}

String formatConsumption(double? consumption, String unit) {
  if (consumption == null || consumption <= 0) return '-';
  return '${consumption.toStringAsFixed(1)} km/$unit';
}

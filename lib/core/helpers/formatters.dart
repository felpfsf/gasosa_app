import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:intl/intl.dart';

final litersInputFormatter = MaskedInputFormatter('##.###', allowedCharMatcher: RegExp(r'[0-9]'));

final decimalInputFormatter = MaskedInputFormatter('###.###', allowedCharMatcher: RegExp(r'[0-9]'));

final integerInputFormatter = MaskedInputFormatter('######', allowedCharMatcher: RegExp(r'[0-9]'));

final currencyInputFormatter = CurrencyInputFormatter(
  leadingSymbol: 'R\$',
  thousandSeparator: ThousandSeparator.Comma,
  useSymbolPadding: true,
);

double parseMaskedInteger(String value) {
  final cleaned = value.replaceAll(RegExp(r'[^\d.]'), '');

  return double.tryParse(cleaned) ?? 0.0;
}

double parseMaskedCurrency(String value) {
  final cleaned = value.replaceAll('R\$', '').replaceAll(',', '.').replaceAll(RegExp(r'[^\d.]'), '');

  return double.tryParse(cleaned) ?? 0.0;
}

double parseMaskedLiters(String value) {
  final cleaned = value.replaceAll(RegExp(r'[^\d.]'), '');

  return double.tryParse(cleaned) ?? 0.000;
}

String formatMaskedCurrency(double value) {
  final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  return currency;
}

String formatMaskedLiters(double value) {
  final liters = NumberFormat('#0.###', 'pt_BR').format(value);
  return liters;
}

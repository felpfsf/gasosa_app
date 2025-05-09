import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';

final litersInputFormatter = MaskedInputFormatter('##.###', allowedCharMatcher: RegExp(r'[0-9]'));

final decimalInputFormatter = MaskedInputFormatter('###.###', allowedCharMatcher: RegExp(r'[0-9]'));

final currencyInputFormatter = CurrencyInputFormatter(
  leadingSymbol: 'R\$',
  thousandSeparator: ThousandSeparator.Comma,
  useSymbolPadding: true,
);

double parseMaskedCurrency(String value) {
  final cleaned = value.replaceAll(RegExp(r'[ˆ\d,]'), '').replaceAll(',', '.');

  return double.tryParse(cleaned) ?? 0.00;
}

double parseMaskedLiters(String value) {
  final cleaned = value.replaceAll(RegExp(r'[^\d.]'), '');

  return double.tryParse(cleaned) ?? 0.000;
}

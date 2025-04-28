import 'package:intl/intl.dart';

extension DatetimeExtensions on DateTime? {
  // format like 03/03/2025
  String formattedDate() {
    if (this == null) return '--/--/----';
    return DateFormat('dd/MM/yyyy').format(this!);
  }

  // format like 03 de março de 2025
  String formattedFullDate() {
    if (this == null) return '';
    return DateFormat('d \'de\' MMMM \'de\' y', 'pt_BR' ).format(this!);
  }
}

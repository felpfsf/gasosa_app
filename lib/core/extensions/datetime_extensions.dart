import 'package:intl/intl.dart';

extension DatetimeExtensions on DateTime? {
  String formattedDate() {
    if (this == null) return '--/--/----';
    return DateFormat('dd/MM/yyyy').format(this!);
  }

  String formattedFullDate() {
    if (this == null) return '';
    return DateFormat('d \'de\' MMMM \'de\' y', 'pt_BR' ).format(this!);
  }
}

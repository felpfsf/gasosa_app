import 'package:shared_preferences/shared_preferences.dart';

Future<void> persistUserId(String id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', id);
}

Future<void> removeUserId() async {
  final prefs = await SharedPreferences.getInstance();

  prefs.clear();
  // prefs.remove('userId');
}

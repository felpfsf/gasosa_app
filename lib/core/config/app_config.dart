import 'package:gasosa_app/core/config/env.dart';

class AppConfig {
  static late Env _env;

  static void setEnvironment(Env environment) {
    _env = environment;
  }

  static Env get env => _env;

  static bool get isDev => env == Env.development;
  static bool get isProd => env == Env.production;
}

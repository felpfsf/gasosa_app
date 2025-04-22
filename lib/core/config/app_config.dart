import 'package:gasosa_app/core/config/env.dart';

class AppConfig {
  static late Env _env;

  static void setEnvironment(Env enviroment) {
    _env = enviroment;
  }

  static Env get env => _env;

  static bool get isDev => env == Env.dev;
  static bool get isProd => env == Env.prod;
}

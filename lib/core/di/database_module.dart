import 'package:gasosa_app/data/local/dabase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  GasosaDatabase get database => GasosaDatabase();
}

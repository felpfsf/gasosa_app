import 'package:firebase_auth/firebase_auth.dart';
import 'package:gasosa_app/domain/services/firebase_auth_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseAuthService providerFirebaseAuthService(FirebaseAuth auth) =>
      FirebaseAuthService(instance: auth);
}

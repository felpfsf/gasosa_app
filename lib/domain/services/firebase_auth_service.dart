import 'package:firebase_auth/firebase_auth.dart' as firebase;

class FirebaseAuthService {
  final firebase.FirebaseAuth _auth;

  FirebaseAuthService({required firebase.FirebaseAuth? instance})
    : _auth = instance ?? firebase.FirebaseAuth.instance;

  Future<firebase.User?> signInWithEmailAndPassword(String email, String password) async {
    final credentials = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credentials.user;
  }

  Future<firebase.User?> registerWithEmailAndPassword(String email, String password) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credentials.user;
  }

  Future<firebase.User?> signInWithGoogle() async {}

  Future<void> signOut() async {
    await _auth.signOut();
  }

  firebase.User? get currentUser => _auth.currentUser;
}

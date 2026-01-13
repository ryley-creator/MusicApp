import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (error) {
      throw Exception('Error $error');
    }
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (error) {
      throw Exception('Error $error');
    }
  }

  void logout() async {
    await auth.signOut();
  }
}

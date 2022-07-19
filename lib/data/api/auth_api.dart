import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  AuthApi._();

  static final AuthApi _instance = AuthApi._();

  factory AuthApi() => _instance;

  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final credencials =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credencials.user?.uid;
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    final credencials = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credencials.user?.uid;
  }

  Future<String?> getUserId() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;

    return uid;
  }
}

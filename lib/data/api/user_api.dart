import 'package:cloud_firestore/cloud_firestore.dart';

class UserApi {
  UserApi._();

  static final UserApi _instance = UserApi._();

  factory UserApi() => _instance;

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    required String password,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    await docUser.set({
      'name': name,
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>?> getUserById(String uid) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    final userSnapshot = await docUser.get();

    return userSnapshot.data();
  }
}

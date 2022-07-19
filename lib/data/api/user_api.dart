import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
      'id': uid,
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

  Future<void> updateUserImage({
    required String uid,
    required File image,
  }) async {
    final String path = 'users_images/$uid.jpg';

    final ref = FirebaseStorage.instance.ref().child(path);

    final uploadTask = ref.putFile(image);

    final snapshot = await uploadTask.whenComplete(() {});

    final url = await snapshot.ref.getDownloadURL();

    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    await docUser.update({'imageUrl': url});
  }
}

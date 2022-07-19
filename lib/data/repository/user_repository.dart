import 'dart:io';

import 'package:chat_app2/data/api/auth_api.dart';
import 'package:chat_app2/data/api/user_api.dart';
import 'package:chat_app2/data/models/user_model.dart';

class UserRepository {
  UserRepository({
    required this.userApi,
    required this.authApi,
  });

  final UserApi userApi;
  final AuthApi authApi;

  Future<UserModel?> getUser() async {
    final String? uid = await authApi.getUserId();

    if (uid == null) return null;

    final Map<String, dynamic>? userMap = await userApi.getUserById(uid);

    if (userMap == null) return null;

    final UserModel user = UserModel.fromMap(userMap);

    return user;
  }

  Future<void> updateUserImage({
    required String uid,
    required File image,
  }) async {
    await userApi.updateUserImage(
      uid: uid,
      image: image,
    );
  }
}

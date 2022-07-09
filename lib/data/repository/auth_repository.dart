import 'package:chat_app2/data/api/auth_api.dart';
import 'package:chat_app2/data/api/user_api.dart';
import 'package:chat_app2/data/models/user_model.dart';

class AuthRepository {
  AuthRepository({
    required this.authApi,
    required this.userApi,
  });

  final AuthApi authApi;
  final UserApi userApi;

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final uid = await authApi.signUp(
      email: email,
      password: password,
      name: name,
    );

    if (uid == null) return null;

    await userApi.createUser(
      uid: uid,
      name: name,
      email: email,
      password: password,
    );

    final Map<String, dynamic>? userMap = await userApi.getUserById(uid);

    if (userMap == null) return null;

    userMap['id'] = uid;

    final UserModel user = UserModel.fromMap(userMap);

    return user;
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    final uid = await authApi.signIn(
      email: email,
      password: password,
    );

    if (uid == null) return null;

    final Map<String, dynamic>? userMap = await userApi.getUserById(uid);

    if (userMap == null) return null;

    userMap['id'] = uid;

    final UserModel user = UserModel.fromMap(userMap);

    return user;
  }
}

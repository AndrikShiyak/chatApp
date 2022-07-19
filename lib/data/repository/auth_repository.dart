import 'package:chat_app2/data/api/auth_api.dart';
import 'package:chat_app2/data/api/user_api.dart';
import 'package:chat_app2/data/models/user_model.dart';
import 'package:chat_app2/data/repository/user_repository.dart';

class AuthRepository {
  AuthRepository({
    required this.authApi,
    required this.userApi,
    required this.userRepository,
  });

  final AuthApi authApi;
  final UserApi userApi;
  final UserRepository userRepository;

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final String? uid = await authApi.signUp(
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

    final UserModel? user = await userRepository.getUser();

    return user;
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    await authApi.signIn(
      email: email,
      password: password,
    );

    final UserModel? user = await userRepository.getUser();

    return user;
  }
}

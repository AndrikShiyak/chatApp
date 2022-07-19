import 'package:chat_app2/data/models/user_model.dart';
import 'package:chat_app2/data/repository/auth_repository.dart';
import 'package:chat_app2/logic/cubit/user_cubit.dart';
import 'package:chat_app2/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<void> {
  AuthCubit({
    required this.authRepository,
    required this.userCubit,
  }) : super(AuthState());

  final AuthRepository authRepository;
  final UserCubit userCubit;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserModel? user = await authRepository.signUp(
          email: email, password: password, name: name);

      userCubit.emit(userCubit.state.copyWith(user: user));
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
    } catch (e) {
      Utils.showSnackbar(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserModel? user =
          await authRepository.signIn(email: email, password: password);

      userCubit.emit(userCubit.state.copyWith(user: user));
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
    } catch (e) {
      Utils.showSnackbar(e.toString());
    }
  }
}

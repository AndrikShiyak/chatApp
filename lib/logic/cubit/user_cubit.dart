import 'dart:io';

import 'package:chat_app2/data/models/user_model.dart';
import 'package:chat_app2/data/repository/user_repository.dart';
import 'package:chat_app2/logic/bloc/loader_bloc.dart';
import 'package:chat_app2/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required this.userRepository,
    required this.loaderBloc,
  }) : super(UserState());

  final UserRepository userRepository;
  final LoaderBloc loaderBloc;

  Future<void> getUser() async {
    try {
      loaderBloc.add(IncrementLoader());

      final UserModel? user = await userRepository.getUser();

      emit(state.copyWith(user: user));
    } catch (e) {
      Utils.showSnackbar(e.toString());
    } finally {
      loaderBloc.add(DecrementLoader());
    }
  }

  Future<void> updateUserImage({
    required File image,
  }) async {
    final String uid = state.user!.id;

    try {
      loaderBloc.add(IncrementLoader());

      await userRepository.updateUserImage(
        uid: uid,
        image: image,
      );

      await getUser();
    } catch (e) {
      Utils.showSnackbar(e.toString());
    } finally {
      loaderBloc.add(DecrementLoader());
    }
  }
}

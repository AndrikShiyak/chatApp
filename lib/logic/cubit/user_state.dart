part of 'user_cubit.dart';

class UserState {
  UserState({this.user});

  final UserModel? user;

  UserState copyWith({
    UserModel? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }

  @override
  String toString() => 'UserState(user: $user)';
}

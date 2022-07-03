import 'package:chat_app2/exceptions/route_exception.dart';
import 'package:chat_app2/screens/auth_screen.dart';
import 'package:chat_app2/screens/chat_screen.dart';
import 'package:chat_app2/screens/reset_password_screen.dart';
import 'package:chat_app2/screens/main_screen.dart';
import 'package:chat_app2/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String main = '/';
  static const String auth = '/auth';
  static const String resetPassword = '/resetPassword';
  static const String chat = '/chat';
  static const String profile = '/profile';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainScreen(),
        );
      case auth:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AuthScreen(),
        );
      case resetPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ResetPasswordScreen(),
        );
      case chat:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ChatScreen(),
        );
      case profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProfileScreen(),
        );
      default:
        throw RouteException('Route not found!');
    }
  }
}

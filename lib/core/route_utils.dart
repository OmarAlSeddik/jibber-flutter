import 'package:flutter/material.dart';
import 'package:jibber/core/constants/paths.dart';
import 'package:jibber/core/models/user_model.dart';
import 'package:jibber/ui/screens/auth/auth_screen.dart';
import 'package:jibber/ui/screens/chat_room/chat_room_screen.dart';
import 'package:jibber/ui/screens/splash_screen.dart';
import 'package:jibber/ui/wrapper/wrapper.dart';

class RouteUtils {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case auth:
        return MaterialPageRoute(builder: (context) => const AuthScreen());
      case wrapper:
        return MaterialPageRoute(builder: (context) => const Wrapper());
      case chatRoom:
        return MaterialPageRoute(
            builder: (context) => ChatRoomScreen(
                  receiver: args as UserModel,
                ));

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("No Route Found")),
          ),
        );
    }
  }
}

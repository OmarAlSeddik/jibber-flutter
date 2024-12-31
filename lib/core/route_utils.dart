import 'package:flutter/material.dart';
import 'package:jibber/core/constants/paths.dart';
import 'package:jibber/ui/screens/splash_screen.dart';

class RouteUtils {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case signup:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case wrapper:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case chatRoom:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Center(
                    child: Text("Page not found"),
                  ),
                ));
    }
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/providers/user_provider.dart';
import 'package:jibber/core/route_utils.dart';
import 'package:jibber/core/services/database_service.dart';
import 'package:jibber/firebase_options.dart';
import 'package:jibber/ui/screens/auth/auth_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => ChangeNotifierProvider(
            create: (context) => UserProvider(DatabaseService()),
            child: MaterialApp(
                title: "Jibber (Beta)",
                onGenerateRoute: RouteUtils.onGenerateRoute,
                home: const AuthScreen(),
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.purple,
                    brightness: Brightness.dark,
                  ),
                ))));
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jibber/core/providers/user_provider.dart';
import 'package:jibber/ui/screens/auth/auth_screen.dart';
import 'package:jibber/ui/screens/main/main_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    log("Wrapper Screen");
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong!"));
        }

        if (user == null) {
          log("User logged out");
          return const AuthScreen();
        } else {
          userProvider.loadUser(user.uid);
          log("User logged in");
          return const MainScreen();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/constants/paths.dart';
import 'package:jibber/core/constants/typography.dart';
import 'package:jibber/ui/screens/auth/auth_viewmodel.dart';
import 'package:jibber/ui/wrapper/wrapper.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          splashFrame,
          height: 1.sh,
          width: 1.sw,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Jibber', style: title),
              ElevatedButton(
                onPressed: () async {
                  final viewModel = AuthScreenViewModel();
                  final user = await viewModel.signInWithGoogle();
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Welcome, ${user.displayName}!')),
                    );
                    // Navigate to the Wrapper widget
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Wrapper()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sign-in failed.')),
                    );
                  }
                },
                child: Text('Sign in with Google', style: body),
              )
            ],
          ),
        )
      ]),
    );
  }
}

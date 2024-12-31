import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibber/core/constants/paths.dart';
import 'package:jibber/core/constants/typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, wrapper);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
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
              Text("Jibber (Beta)", textAlign: TextAlign.center, style: title)
            ]))
      ],
    ));
  }
}

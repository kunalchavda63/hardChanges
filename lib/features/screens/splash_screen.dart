import 'dart:async';

import 'package:b_and_b/core/services/navigation/router.dart';
import 'package:b_and_b/features/widgets/src/extensions.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            (){
          context.pushReplacement('/home');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle()
            .c(Colors.black)
            .s(20)
            .w(500)

        ),
      ),
    );
  }
}
